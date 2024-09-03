
`include "../param/sb_defs.svh"

module store_buffer_controller (
    input wire                            clk,
    input wire                            rst_n,

    input logic                           dcache_flush_i,
    input logic                           dcache_kill_i,
    input logic                           dcache_flush_o,
    input logic                           dcache_kill_o,

    // Interface signals to/from store_buffer_datapath
    output logic                          top_que_en,
    output logic                          bottom_que_en,
    output logic                          wr_en,
    output logic                          set_valid,
    output logic                          clear_valid,
    output logic                          read_en,
    output logic                          read_sel,
    input logic                           tq_eq_bq,
    input logic                           is_valid_tq,
    input logic                           is_valid_bq,
    input logic  [SB_NO_OF_LINES-1:0]     addr_availables,

    // Interface control signals LSU/MMU to/from store buffer 
    input logic                           lsummu2sb_i_w_en,
    input logic                           lsummu2sb_i_req,
    output logic                          sb2lsummu_o_ack,

    // Interface control signals store buffer to/from dcache
    output logic                          sb2dcache_o_w_en,
    output logic                          sb2dcache_o_req,
    input logic                           dcache2sb_i_ack
    
);

    type_sb_evacuate_states_e             sb_evacuate_states_ff, sb_evacuate_states_next;
    type_sb_cachehandler_states_e         sb_cachehandler_ff, sb_cachehandler_next;

    logic                                 cache_write, cache_write_ack, cache_read, cache_read_ack;
    logic                                 sb2lsummu_o_ack_read, sb2lsummu_o_ack_write;
    logic                                 stall;
    logic                                 addr_not_available;

    assign stall = tq_eq_bq & is_valid_bq;
    assign addr_not_available = addr_availables == 0;
    assign sb2lsummu_o_ack = sb2lsummu_o_ack_read | sb2lsummu_o_ack_write;

    // State machines
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            sb_evacuate_states_ff = SB_CHECK_EVACUATE;
            sb_cachehandler_ff = SB_CACHE_IDLE;
        end
        else begin
            sb_evacuate_states_ff = sb_evacuate_states_next;
            sb_cachehandler_ff = sb_cachehandler_next;
        end
    end

    // Next state and output logic for store buffer evacuate
    always_comb begin
        // Defaults
        bottom_que_en = 1'b0;
        clear_valid = 1'b0;
        cache_write = 1'b0;

        if ( !(tq_eq_bq & !is_valid_bq) ) begin
            cache_write = 1;
           
            if (cache_write_ack) begin
                clear_valid = 1;
                bottom_que_en = 1;
            end
        end
        
    end

    // // Next state and output logic for store buffer evacuate
    // always_comb begin
    //     // Defaults
    //     sb_evacuate_states_next = sb_evacuate_states_ff;
    //     bottom_que_en = 1'b0;
    //     clear_valid = 1'b0;
    //     cache_write = 1'b0;

    //     case (sb_evacuate_states_ff)
    //         SB_CHECK_EVACUATE: 
    //         begin
    //             if ( !(tq_eq_bq & !is_valid_bq) ) begin
    //                 sb_evacuate_states_next = SB_EVACUATE;
    //                 cache_write = 1;
    //             end
    //         end

    //         SB_EVACUATE:
    //         begin
    //             if (cache_write_ack) begin
    //                 sb_evacuate_states_next = SB_CHECK_EVACUATE;
    //                 clear_valid = 1;
    //                 bottom_que_en = 1;
    //             end
    //         end
    //     endcase
    // end

    // Logic for storing data in buffer
    always_comb begin
        if (lsummu2sb_i_req & lsummu2sb_i_w_en & !stall) begin
            // store incoming data
            top_que_en = 1;
            wr_en = 1;
            set_valid = 1;
            sb2lsummu_o_ack_write = 1;
        end
        else begin
            // dont store incoming data, stall processor
            top_que_en = 0;
            wr_en = 0;
            set_valid = 0;
            sb2lsummu_o_ack_write = 0;
        end
    end
    
    // Logic for load request
    always_comb begin
        // Defaults
        cache_read = 0;
        sb2lsummu_o_ack_read = 0;
        read_sel = 0;

        // check for a load request
        if (lsummu2sb_i_req & !lsummu2sb_i_w_en) begin
            if (!addr_not_available) begin
                // load from store buffer
                read_sel = 1;
                sb2lsummu_o_ack_read = 1;
            end
            else begin
                // load from cache
                read_sel = 0;
                cache_read = 1;

                if (dcache2sb_i_ack) begin
                    sb2lsummu_o_ack_read = 1;
                end
            end
        end
    end
    
    // dcache handler
    always_comb begin
        cache_read_ack = 0;
        cache_write_ack = 0;
        sb2dcache_o_w_en = 0;
        sb2dcache_o_req = 0;
        read_en = 0;

        case (sb_cachehandler_ff)
            SB_CACHE_IDLE:
            begin
                if (cache_read) begin
                    sb_cachehandler_next = SB_CACHE_READ;
                    sb2dcache_o_w_en = 0;
                    sb2dcache_o_req = 1;
                    read_en = 1;
                end
                else if (cache_write) begin
                    sb_cachehandler_next = SB_CACHE_WRITE;
                    sb2dcache_o_w_en = 1;
                    sb2dcache_o_req = 1;
                end
                else begin
                    sb_cachehandler_next = SB_CACHE_IDLE;
                end
            end

            SB_CACHE_READ:
            begin
                if (dcache2sb_i_ack) begin
                    cache_read_ack = 1;

                    if (cache_read) begin
                        sb_cachehandler_next = SB_CACHE_READ;
                        sb2dcache_o_w_en = 0;
                        sb2dcache_o_req = 1;
                        read_en = 1;
                    end
                    else if (cache_write) begin
                        sb_cachehandler_next = SB_CACHE_WRITE;
                        sb2dcache_o_w_en = 1;
                        sb2dcache_o_req = 1;
                    end
                    else begin
                        sb_cachehandler_next = SB_CACHE_IDLE;
                    end
                end
                else begin
                    sb_cachehandler_next = SB_CACHE_READ;
                    sb2dcache_o_w_en = 0;
                    sb2dcache_o_req = 1;
                    read_en = 1;
                end
            end

            SB_CACHE_WRITE:
            begin
                if (dcache2sb_i_ack) begin
                    cache_write_ack = 1;
                    
                    if (cache_read) begin
                        sb_cachehandler_next = SB_CACHE_READ;
                        sb2dcache_o_w_en = 0;
                        sb2dcache_o_req = 1;
                        read_en = 1;
                    end
                    else if (cache_write) begin
                        sb_cachehandler_next = SB_CACHE_WRITE;
                        sb2dcache_o_w_en = 1;
                        sb2dcache_o_req = 1;
                    end
                    else begin
                        sb_cachehandler_next = SB_CACHE_IDLE;
                    end
                end
                else begin
                    sb_cachehandler_next = SB_CACHE_WRITE;
                    sb2dcache_o_w_en = 1;
                    sb2dcache_o_req = 1;
                end
            end
        endcase
    end



endmodule
