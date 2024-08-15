/*
    Name: cache_tb.sv
    Author: Muhammad Tayyab
    Date: 15-8-2024
    Description: Modelsim testbench for cache.sv
*/

import cache_parameters::*;

module cache_tb();

    logic clk, reset;
    type_processor2cache_s processor2cache;
    type_cache2processor_s cache2processor;

    cache DUT (
        .clk(clk),
        .reset(reset),
        .processor2cache(processor2cache),
        .cache2processor(cache2processor)
    );

    initial begin
        clk = 1; 
        forever #5 clk = ~clk;
    end

    initial begin
        init_sequence();
        @(posedge clk);
        reset_sequence();

        write(32'h1, 32'h2021EE83);


        $finish();
    end

/*    
    typedef struct {
        logic [1:0] operation;
        type_address_ps address;
        logic [(DATA_BUSWIDTH-1):0] data;
        logic valid;
        logic ready;
    } type_processor2cache_s;

    typedef struct {
        logic [(DATA_BUSWIDTH-1):0] data;
        logic valid;
        logic ready;
    } type_cache2processor_s;
*/
    // Writes data to cache/memory
    task write(logic [(ADDRESS_BUSWIDTH-1):0] address, logic [(DATA_BUSWIDTH-1):0] data);
        @(posedge clk)
        processor2cache.address = address;
        processor2cache.data = data;
        processor2cache.operation = OPWRITE;
        processor2cache.valid = 1;

        while (!cache2processor.valid)
            @(posedge clk);
        
        processor2cache.valid = 0;
        processor2cache.operation = OPNONE;
    endtask

    // Reads data from cache/memory
    task read(logic [(ADDRESS_BUSWIDTH-1):0] address);
        @(posedge clk)
        processor2cache.address = address;
        processor2cache.operation = OPREAD;
        processor2cache.valid = 1;

        while (!cache2processor.valid)
            @(posedge clk);

        processor2cache.valid = 0;
        processor2cache.operation = OPNONE;
    endtask


    task init_sequence();
        reset = 1;
        processor2cache.valid = 0;
        processor2cache.ready = 1;
        processor2cache.operation = OPNONE;
    endtask
    
    task reset_sequence();
        reset = 0;
        #30;
        reset = 1;
    endtask

endmodule