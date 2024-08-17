/*
    Name: cache.sv
    Author: Muhammad Tayyab
    Date: 12-8-2024
    Description: 
*/

import cache_parameters::*;
import axi4lite_parameters::type_axi4lite_master2slave_s;
import axi4lite_parameters::type_axi4lite_slave2master_s;

module cache
(
    input logic clk, reset,
    input type_processor2cache_s processor2cache,
    output type_cache2processor_s cache2processor
);

    type_cache2processor_s cache2processor_ctrl, cache2processor_dp;
    type_axi4lite_slave2master_s memory2cache;
    type_axi4lite_master2slave_s cache2memory, cache2memory_ctrl, cache2memory_dp;
    type_cache_controller2datapath_s controller2datapath;
    type_cache_datapath2controller_s datapath2controller;

    cache_controller ctrl (
        .clk(clk),
        .reset(reset),
        .processor2cache(processor2cache),
        .cache2processor(cache2processor_ctrl),
        .memory2cache(memory2cache),
        .cache2memory(cache2memory_ctrl),
        .controller2datapath(controller2datapath),
        .datapath2controller(datapath2controller)
    );

    cache_datapath dp (
        .clk(clk),
        .reset(reset),
        .processor2cache(processor2cache),
        .cache2processor(cache2processor_dp),
        .memory2cache(memory2cache),
        .cache2memory(cache2memory_dp),
        .controller2datapath(controller2datapath),
        .datapath2controller(datapath2controller)
    );

    memory mem (
        .memory2cache(memory2cache),
        .cache2memory(cache2memory)
    );

    // Link cache controller, datapath signals with external signals

    // Memory
    assign cache2memory.aclk = clk;
    assign cache2memory.aresetn = reset;
    assign cache2memory.rac.araddr = cache2memory_dp.rac.araddr;
    assign cache2memory.rac.arvalid = cache2memory_ctrl.rac.arvalid;
    assign cache2memory.rdc.rready = cache2memory_ctrl.rdc.rready;
    assign cache2memory.wac.awaddr = cache2memory_dp.wac.awaddr;
    assign cache2memory.wac.awvalid = cache2memory_ctrl.wac.awvalid;
    assign cache2memory.wdc.wdata = cache2memory_dp.wdc.wdata;
    assign cache2memory.wdc.wvalid = cache2memory_ctrl.wdc.wvalid;
    assign cache2memory.wrc.bready = cache2memory_ctrl.wrc.bready;

    // Processor
    assign cache2processor.valid = cache2processor_ctrl.valid;
    assign cache2processor.ready = cache2processor_ctrl.ready;
    assign cache2processor.r_data = cache2processor_dp.r_data;
    
endmodule
