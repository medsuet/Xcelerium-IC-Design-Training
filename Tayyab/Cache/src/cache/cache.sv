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

    type_axi4lite_slave2master_s memory2cache;
    type_axi4lite_master2slave_s cache2memory;
    type_cache_controller2datapath_s controller2datapath;
    type_cache_datapath2controller_s datapath2controller;

    cache_controller ctrl (
        .clk(clk),
        .reset(reset),
        .processor2cache(processor2cache),
        .cache2processor(cache2processor),
        .memory2cache(memory2cache),
        .cache2memory(cache2memory),
        .controller2datapath(controller2datapath),
        .datapath2controller(datapath2controller)
    );

    cache_datapath dp (
        .clk(clk),
        .reset(reset),
        .processor2cache(processor2cache),
        .cache2processor(cache2processor),
        .memory2cache(memory2cache),
        .cache2memory(cache2memory),
        .controller2datapath(controller2datapath),
        .datapath2controller(datapath2controller)
    );

    memory mem (
        .memory2cache(memory2cache),
        .cache2memory(cache2memory)
    );
    
endmodule