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

    type_mem_datapath2controller_s datapath2controller;
    type_mem_controller2datapath_s controller2datapath;

    memory_datapath mem_dp(cache2memory, memory2cache, datapath2controller, controller2datapath);
    memory_controller mem_ctrl(cache2memory, memory2cache, datapath2controller, controller2datapath);

endmodule
