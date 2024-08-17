/*
    Name: cache_datapath.sv
    Author: Muhammad Tayyab
    Date: 12-8-2024
    Description: Datapath for cache
*/

import cache_parameters::*;
import axi4lite_parameters::type_axi4lite_master2slave_s;
import axi4lite_parameters::type_axi4lite_slave2master_s;

module cache_datapath
(
    input logic clk, reset,
    input type_processor2cache_s processor2cache,
    output type_cache2processor_s cache2processor,

    input type_axi4lite_slave2master_s memory2cache,
    output type_axi4lite_master2slave_s cache2memory,

    input type_cache_controller2datapath_s controller2datapath,
    output type_cache_datapath2controller_s datapath2controller
);

    logic [((DATA_BUSWIDTH)-1):0] cache_mem [0:(NUM_LINES-1)];
    logic [(TAG_WIDTH-1):0] cache_tag_feild [0:(NUM_LINES-1)];
    logic [(NUM_LINES-1):0] cache_valid_feild;
    logic [(NUM_LINES-1):0] cache_dirty_feild;

    //logic [(OFFSET_WIDTH-1):0] offset;
    logic [(INDEX_WIDTH-1):0] index;
    logic [(TAG_WIDTH-1):0] tag;
    logic [(INDEX_WIDTH-1):0] cache_index_counter;

    // link memory, cache
    assign cache2memory.rac.araddr = processor2cache.address;
    assign cache2memory.wac.awaddr = processor2cache.address;
    assign cache2memory.wdc.wdata = processor2cache.w_data;

    // get info signals
    assign index = (controller2datapath.cache_flush) ? cache_index_counter : processor2cache.address.index;
    assign tag = processor2cache.address.tag;
    //assign offset = processor2cache.address.offset;
    assign datapath2controller.tag_match = tag === cache_tag_feild[index];
    assign datapath2controller.is_valid = cache_valid_feild[index];
    assign datapath2controller.is_dirty = cache_dirty_feild[index];

    // Index counter for cache flush
    always_ff @(posedge clk, negedge reset) begin
        if (!reset)
            cache_index_counter <= 0;
        else if (controller2datapath.cache_index_counter_clear)
            cache_index_counter <= 0;
        else if (controller2datapath.cache_index_counter_wr)
            cache_index_counter <= cache_index_counter + 1;
    end
    assign datapath2controller.cache_flush_done = cache_index_counter === ((2**INDEX_WIDTH)-1);

    logic [31:0]a;
    always_comb a = cache_mem[index];
    
    // read data
    always_comb begin
        // cache line size = 1
        cache2processor.r_data = cache_mem[index];
    end

    // write data
    always @(posedge clk, negedge reset) begin
        if (!reset) begin
            cache_valid_feild <= 0;
            cache_dirty_feild <= 0;
        end
        if (controller2datapath.wr_en) begin
            if(controller2datapath.wr_sel === MEMORY_WRITE)
            begin
                //cache_mem [index] <= memory2cache.rdc.rdata;
                cache_mem [index] <= processor2cache.w_data;
            end
            else
            begin
                cache_mem [index] <= processor2cache.w_data;
            end
            
            cache_tag_feild [index] <= tag;
            cache_valid_feild [index] <= controller2datapath.set_valid;
            cache_dirty_feild [index] <= controller2datapath.set_valid;
        end

    end

    
    


endmodule