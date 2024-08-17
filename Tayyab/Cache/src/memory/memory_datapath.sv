/*
    Name: memory.sv
    Author: Muhammad Tayyab
    Date: 13-8-2024
    Description: Dummy memory for cache. Interface using AXI4Lite bus.
*/

import axi4lite_parameters::type_axi4lite_master2slave_s;
import axi4lite_parameters::type_axi4lite_slave2master_s;
import memory_parameters::*;

module memory_datapath
(
    input type_axi4lite_master2slave_s cache2memory,
    output type_axi4lite_slave2master_s memory2cache,
    output type_mem_datapath2controller_s datapath2controller,
    input type_mem_controller2datapath_s controller2datapath
);
    logic [(DATA_BUSWIDTH-1):0] memory_file [0:((MEMORY_SIZE/DATA_BUSWIDTH)-1)];
    logic [(ADDRESS_BUSWIDTH-1):0] address;

    logic clk, reset;
    logic rdata_done, wdata_done;

    assign clk = cache2memory.aclk;
    assign reset = cache2memory.aresetn;

    assign datapath2controller.rdata_done = rdata_done;
    assign datapath2controller.wdata_done = wdata_done;
    
    assign address = (controller2datapath.wr_en) ? cache2memory.wac.awaddr : cache2memory.rac.araddr;

    always_comb begin
        memory2cache.rdc.rdata = memory_file[address];
        rdata_done  = 1;
    end

    always_ff @(posedge clk) begin
        if (controller2datapath.wr_en) begin
            memory_file[address] <= cache2memory.wdc.wdata;
            wdata_done <= 1;
        end
        else
            wdata_done <= 0;
    end

endmodule
