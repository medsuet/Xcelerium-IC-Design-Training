/*
    Name: controller.sv
    Author: Muhammad Tayyab
    Date: 14-8-2024
    Description: Controller for SequentialSignedMultiplier.sv
*/

import memory_parameters::*;
import axi4lite_parameters::type_axi4lite_master2slave_s;
import axi4lite_parameters::type_axi4lite_slave2master_s;

module memory_controller
(
    input type_axi4lite_master2slave_s cache2memory,
    output type_axi4lite_slave2master_s memory2cache,
    input type_mem_datapath2controller_s datapath2controller,
    output type_mem_controller2datapath_s controller2datapath
);

    logic clk, reset;
    logic rdata_done, wdata_done, wr_en;
    logic rvalid, arvalid, arready, rready, awvalid, wvalid, bready, awready, wready, bvalid;

    //================================= Signal renames =================================
    // Datapath
    assign rdata_done = datapath2controller.rdata_done;
    assign wdata_done = datapath2controller.wdata_done;

    assign controller2datapath.wr_en = wr_en;

    // cache - memory
    assign clk = cache2memory.aclk;
    assign reset = cache2memory.aresetn;
    assign arvalid = cache2memory.rac.arvalid;
    assign rready = cache2memory.rdc.rready;
    assign awvalid = cache2memory.wac.awvalid;
    assign wvalid = cache2memory.wdc.wvalid;
    assign bready = cache2memory.wrc.bready;

    assign memory2cache.rdc.rvalid = rvalid;
    assign memory2cache.rac.arready = arready;
    assign memory2cache.wac.awready = awready;
    assign memory2cache.wdc.wready = wready;
    assign memory2cache.wrc.bvalid = bvalid;

    type_memory_states_e current_state, next_state;

    //================================= Store current state =================================
    always_ff @(posedge clk, negedge reset) begin
        if (!reset)
            current_state <= M_IDLE;
        else
            current_state <= next_state;
    end

    //================================= Next state and output logic =================================
    always_comb 
    begin
        next_state = M_IDLE;
        arready = 0;
        rvalid = 0;
        awready = 0;
        wready = 0;
        bvalid = 0;
        wr_en = 0;

        case (current_state)
            M_IDLE: 
                begin
                    arready = 1;
                    awready = 1;
                    wready = 1;
                    wr_en = 1;

                    if (arvalid)
                    begin
                        next_state = READ;
                        arready = 1;
                    end
                    else if (awvalid & wvalid)
                    begin
                        awready = 1;
                        wready = 1;
                        wr_en = 1;
                    end
                    else 
                    begin
                        next_state = M_IDLE;
                    end
                end
            READ: 
                begin
                    if (rdata_done & rready)
                    begin
                        next_state = M_IDLE;
                        rvalid = 1;
                    end
                    else if (rdata_done & !rready)
                    begin
                        next_state = READ;
                        rvalid = 1;
                    end
                    else
                    begin
                        next_state = READ;
                    end
                end
            WRITE:
                begin
                    if (wdata_done & bready)
                    begin
                        next_state = M_IDLE;
                        bvalid = 1;
                    end
                    else if (wdata_done & !bready)
                    begin
                        next_state = WRITE;
                        bvalid = 1;
                    end
                    else
                    begin
                        next_state = WRITE;
                        wr_en = 1;
                    end
                end
            
            default: next_state = M_IDLE;
        endcase
    end


endmodule