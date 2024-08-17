/*
    Name: memory.sv
    Author: Muhammad Tayyab
    Date: 13-8-2024
    Description: Dummy memory for cache. Interface using AXI4Lite bus.
*/

import axi4lite_parameters::type_axi4lite_master2slave_s;
import axi4lite_parameters::type_axi4lite_slave2master_s;
import memory_parameters::*;

module memory #(parameter MEMORY_SIZE = 2048)
(
    input type_axi4lite_master2slave_s cache2memory,
    output type_axi4lite_slave2master_s memory2cache
);

    type_axi4lite_slave2master_s memory2cache_dp, memory2cache_ctrl;
    type_mem_datapath2controller_s datapath2controller;
    type_mem_controller2datapath_s controller2datapath;

    memory_datapath mem_dp(cache2memory, memory2cache_dp, datapath2controller, controller2datapath);
    memory_controller mem_ctrl(cache2memory, memory2cache_ctrl, datapath2controller, controller2datapath);

    // Link cache controller, datapath signals with external signals
    assign memory2cache.rac.arready = memory2cache_ctrl.rac.arready;
    assign memory2cache.rdc.rdata = memory2cache_dp.rdc.rdata;
    assign memory2cache.rdc.rvalid = memory2cache_ctrl.rdc.rvalid;
    assign memory2cache.wac.awready = memory2cache_ctrl.wac.awready;
    assign memory2cache.wdc.wready = memory2cache_ctrl.wdc.wready;
    assign memory2cache.wrc.bvalid = memory2cache_ctrl.wrc.bvalid;


endmodule
