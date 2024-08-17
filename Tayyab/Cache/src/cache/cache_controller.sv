/*
    Name: cache_controller.sv
    Author: Muhammad Tayyab
    Date: 13-8-2024
    Description: Controller for cache
*/

import cache_parameters::*;
import axi4lite_parameters::type_axi4lite_master2slave_s;
import axi4lite_parameters::type_axi4lite_slave2master_s;

module cache_controller
(
    input logic clk, reset,
    input type_processor2cache_s processor2cache,
    output type_cache2processor_s cache2processor,

    input type_axi4lite_slave2master_s memory2cache,
    output type_axi4lite_master2slave_s cache2memory,

    output type_cache_controller2datapath_s controller2datapath,
    input type_cache_datapath2controller_s datapath2controller
);

    logic hold_signal_info, wr_req, wr_req_done, cache_hit, cache_flush, cache_flush_done, cache_index_counter_wr, cache_index_counter_clear;
    logic is_valid, is_dirty, wr_en, wr_sel, set_dirty, set_valid;
    logic cvalid, cready, pvalid, pready;
    logic rvalid, arvalid, arready, rready, awvalid, wvalid, bready, awready, wready, bvalid;

    assign cache_hit = datapath2controller.is_valid && datapath2controller.tag_match;

    //================================= Signal renames =================================
    // Datapath
    assign is_valid = datapath2controller.is_valid;
    assign is_dirty = datapath2controller.is_dirty;
    assign cache_flush_done = datapath2controller.cache_flush_done;
    
    assign controller2datapath.cache_index_counter_wr = cache_index_counter_wr;
    assign controller2datapath.cache_index_counter_clear = cache_index_counter_clear;;
    assign controller2datapath.cache_flush = cache_flush;
    assign controller2datapath.wr_en     = wr_en;
    assign controller2datapath.wr_sel    = wr_sel;
    assign controller2datapath.set_dirty = set_dirty;
    assign controller2datapath.set_valid = set_valid;

    // Processor
    assign cache2processor.valid = cvalid;
    assign cache2processor.ready = cready;

    assign pvalid = processor2cache.valid;
    assign pready = processor2cache.ready;

    // Memory
    assign cache2memory.rac.arvalid = arvalid;
    assign cache2memory.rdc.rready  = rready;
    assign cache2memory.wac.awvalid = awvalid;
    assign cache2memory.wdc.wvalid  = wvalid;
    assign cache2memory.wrc.bready  = bready;

    assign arready = memory2cache.rac.arready;
    assign rvalid  = memory2cache.rdc.rvalid;
    assign awready = memory2cache.wac.awready;
    assign wready  = memory2cache.wdc.wready; 
    assign bvalid  = memory2cache.wrc.bvalid;

    //================================= Hold signal information in registers =================================    
    // Cache flush request from processor
    always_ff @(posedge clk, negedge reset) begin
        if (!reset)
            cache_flush <= 0;
        else if (cache_flush_done)
            cache_flush <= 0;
        else if (hold_signal_info)
            cache_flush <= processor2cache.operation === OPFLUSH;
    end

    // write request from processor
    always_ff @(posedge clk, negedge reset) begin
        if (!reset)
            wr_req <= 0;
        else if (wr_req_done)
            wr_req <= 0;
        else if (hold_signal_info)
            wr_req <= processor2cache.operation === OPWRITE;
    end

    //================================= Store current state =================================
    type_cache_states_e current_state, next_state;

    always @(posedge clk, negedge reset) begin
        if (!reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    //================================= Next state and output logic =================================
    always_comb begin
        // Defaults
        next_state = IDLE;

        hold_signal_info          = 0;
        wr_req_done               = 0;
        cache_index_counter_wr    = 0;
        cache_index_counter_clear = 0;
        wr_en                     = 0;
        wr_sel                    = PROCESSOR_WRITE;
        set_dirty                 = 0;
        set_valid                 = 0;
                                  
        cready   = 0;
        cvalid   = 0;
        arvalid  = 0;
        rready   = 0;
        awvalid  = 0;
        wvalid   = 0;
        bready   = 0;

        case (current_state)
            IDLE: 
            begin
                cready = 1;
                hold_signal_info = 1;

                if (!pvalid)
                begin
                    next_state = IDLE;
                end
                else if (cache_flush)
                begin
                    next_state = FLUSH;
                    cache_index_counter_clear = 1;
                    cache_index_counter_wr = 1;
                end
                else
                begin
                    next_state = PROCESS_REQUEST;
                end
            end

            WAIT:
            begin
                cvalid = 1;
                cready = 1;
                if (pready)
                begin
                    next_state = IDLE;
                end
                else
                begin
                    next_state = WAIT;
                end
            end

            PROCESS_REQUEST:
            begin
                rready = 1;

                if (pready & cache_hit & wr_req)
                begin
                    next_state = IDLE;
                    set_valid = 1;
                    set_dirty = 1;
                    wr_en = 1;
                    cvalid = 1;
                end
                else if (pready & cache_hit & !wr_req)
                begin
                    next_state = IDLE;
                    cvalid = 1;
                end
                else if (cache_hit & wr_req)
                begin
                    next_state = WAIT;
                    wr_en = 1;
                    set_valid = 1;
                    set_dirty = 1;
                    cvalid = 1;
                end
                else if (cache_hit & !wr_req)
                begin
                    next_state = WAIT;
                    cvalid = 1;
                end
                else if ((!wr_req & !cache_hit) | (wr_req & !is_valid))
                begin
                    arvalid = 1;
                    rready = 1;
                    if (arready)
                        next_state = MEM_READ;
                    else
                        next_state = PROCESS_REQUEST;
                end
                else if (!cache_hit & is_dirty)
                begin
                    awvalid = 1;
                    wvalid = 1;
                    if (awready & wready)
                    begin
                        next_state = WRITE_BACK;    
                    end
                    else
                    begin
                        next_state = PROCESS_REQUEST;
                    end
                    
                end

            end

            MEM_READ:
            begin
                rready = 1;

                if (rvalid)
                begin
                    next_state = PROCESS_REQUEST;
                    wr_sel = MEMORY_WRITE;
                    set_valid = 1;
                    set_dirty = 0;
                    wr_en = 1;
                    //wr_req_done = 1;
                end
                else
                begin
                    next_state = MEM_READ;
                end
            end
            

            HANDSHAKE_WRITE_BACK:
            begin
                awvalid = 1;
                wvalid = 1;
                if (awready & wready & !bvalid)
                begin
                    next_state = WRITE_BACK;
                    bready = 1;
                end
                else if (awready & wready & bvalid & !cache_flush)
                begin
                    next_state = HANDSHAKE_MEM_READ;
                    arvalid = 1;
                    rready = 1;
                end
                else if (awready & wready & bvalid & cache_flush)
                begin
                    next_state = FLUSH;
                    set_valid = 0;
                    set_dirty = 0;
                    wr_en = 1;
                end
                else if (awready & !wready)
                begin
                    next_state = ADDRESS_HANDSHAKE_WRITE_BACK;
                    wvalid = 1;
                    //bready = 0;
                end
                else if (!awready & wready)
                begin
                    next_state = DATA_HANDSHAKE_WRITE_BACK;
                    awvalid = 1;
                    //bready = 0;
                end
                else
                begin
                    next_state = HANDSHAKE_WRITE_BACK;
                    awvalid = 1;
                    wvalid = 1;
                    bready = 1;
                end
            end

            ADDRESS_HANDSHAKE_WRITE_BACK:
            begin
                awvalid = 1;
                if (wready)
                begin
                    next_state = WRITE_BACK;
                    bready = 1;
                end
                else
                begin
                    next_state = ADDRESS_HANDSHAKE_WRITE_BACK;
                    wvalid = 1;
                    //bready = 0;
                end
            end

            DATA_HANDSHAKE_WRITE_BACK:
            begin
                if (awready)
                begin
                    next_state = WRITE_BACK;
                    bready = 1;
                end
                else
                begin
                    next_state = DATA_HANDSHAKE_WRITE_BACK;
                    awvalid = 1;
                    //bready = 0;
                end
            end

            WRITE_BACK:
            begin
                bready = 1;
                if (!bvalid)
                begin
                    next_state = WRITE_BACK;
                end
                else if (cache_flush)
                begin
                    next_state = FLUSH;
                end
                else
                begin
                    arvalid = 1;
                    rready = 1;
                    if (arready)
                        next_state = MEM_READ;
                    else
                        next_state = WRITE_BACK;
                end
            end

            FLUSH:
            begin
                if (cache_flush_done)
                begin
                    next_state = WAIT;
                    cready=1;
                    cvalid = 1;
                end
                else if (!is_dirty)
                begin
                    next_state = FLUSH;
                    cache_index_counter_wr = 1;
                    set_valid = 0;
                    set_dirty = 0;
                    wr_en = 1;
                end
                else
                begin
                    next_state = HANDSHAKE_WRITE_BACK;
                    awvalid = 1;
                    wvalid = 1;
                    bready = 1;
                end
            end

            default:
            begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
