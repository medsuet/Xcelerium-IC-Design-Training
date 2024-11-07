/*
    Name: cache_tb.sv
    Author: Muhammad Tayyab
    Date: 15-8-2024
    Description: Modelsim testbench for cache.sv
*/

import cache_parameters::*;
import axi4lite_parameters::type_axi4lite_master2slave_s;
import axi4lite_parameters::type_axi4lite_slave2master_s;

module cache_tb();

    parameter NUM_RANDOM_TESTS = 20;

    logic clk, reset;
    type_processor2cache_s processor2cache;
    type_cache2processor_s cache2processor;
    type_axi4lite_slave2master_s memory2cache;
    type_axi4lite_master2slave_s cache2memory;

    // Assositive array for memory
    int dummy_memory_file [int];

    // Instantiation
    cache DUT (
        .clk(clk),
        .reset(reset),
        .processor2cache(processor2cache),
        .cache2processor(cache2processor),
        .memory2cache(memory2cache),
        .cache2memory(cache2memory)
    );

    // Generate clock
    initial begin
        clk = 1; 
        forever #5 clk = ~clk;
    end

    // Tests
    initial begin
        init_sequence();
        @(posedge clk);
        reset_sequence();
        @(posedge clk);

        fork
            random_driver();
            monitor();
        join_any

        repeat(5) @(posedge clk);
        $finish();
    end

    int i;
    task random_driver();
        parameter ADDRESS_RANGE = 10;

        for (i=1; i<=NUM_RANDOM_TESTS; i++)
        begin
            if ($random() % 2)
            begin
                write($urandom % ADDRESS_RANGE, $random);
            end
            else
            begin
                read($urandom % ADDRESS_RANGE);
            end
        end
    endtask

    logic [31:0] reference_memory [0:31];
    logic [31:0] address;
    logic [31:0]a;
    assign a = reference_memory[address];
    task monitor();
        forever begin
            //@(posedge clk);
            while (!processor2cache.valid)
                @(posedge clk);
            
            address = processor2cache.address;
            if (processor2cache.operation == OPWRITE)
                reference_memory [address] = processor2cache.w_data;

            //@(posedge clk);
            while (!cache2processor.ready)
                @(posedge clk);

            if (processor2cache.operation == OPREAD) 
            begin
                //if (reference_memory.exists(address))
                begin
                    assert (reference_memory [address] === cache2processor.r_data)
                    else begin $display("\nFAIL: %d\nref: %x\ndut: %x\n", i, reference_memory[address], cache2processor.r_data); end
                end
                // else 
                // begin
                //     assert (3'bx == cache2processor.r_data)
                //     else begin $display("\nFAIL\n"); $finish(); end
                // end

            end
            @(posedge clk);
        end
    endtask
    
    // Simulate dummy memory
    initial begin
        fork
            memory_read_data();
            memory_write_data();
        join_none
    end

    // Simulate reading of data from dummy memory
    task memory_read_data();
        forever begin
            #1;
                memory2cache.rac.arready = 1;
                memory2cache.rdc.rvalid = 0;
                
                @(posedge clk);
                while (!cache2memory.rac.arvalid)
                    @(posedge clk);

                memory2cache.rac.arready = 0;
                memory2cache.rdc.rvalid = 1;

                if (dummy_memory_file.exists(cache2memory.rac.araddr))
                    memory2cache.rdc.rdata = dummy_memory_file [cache2memory.rac.araddr];
                else 
                    memory2cache.rdc.rdata = 32'bx;

                @(posedge clk);
                while (!cache2memory.rdc.rready)
                    @(posedge clk);
        end
    endtask

    // Simulate writing of data to dummy memory
    task memory_write_data();
        forever begin
            #1;
                memory2cache.wac.awready = 1;
                memory2cache.wdc.wready = 1;
                memory2cache.wrc.bvalid = 0;
                
                @(posedge clk);
                while (!(cache2memory.wac.awvalid & cache2memory.wdc.wvalid))
                    @(posedge clk);
                

                memory2cache.wac.awready = 0;
                memory2cache.wdc.wready = 0;
                memory2cache.wrc.bvalid = 1;

                dummy_memory_file [cache2memory.wac.awaddr] = cache2memory.wdc.wdata;

                @(posedge clk);
                while (!cache2memory.rdc.rready)
                    @(posedge clk);
        end
    endtask
    
    // Writes data to cache
    task write(logic [(ADDRESS_BUSWIDTH-1):0] address, logic [(DATA_BUSWIDTH-1):0] data);
        processor2cache.address = address;
        processor2cache.w_data = data;
        processor2cache.operation = OPWRITE;
        processor2cache.valid = 1;

        @(posedge clk);
        while (!cache2processor.valid)
            @(posedge clk);
        
        processor2cache.valid = 0;
        processor2cache.operation = OPNONE;
    endtask

    // Reads data from cache
    task read(logic [(ADDRESS_BUSWIDTH-1):0] address);
        processor2cache.address = address;
        processor2cache.operation = OPREAD;
        processor2cache.valid = 1;
        
        @(posedge clk);
        while (!cache2processor.valid)
            @(posedge clk);

        processor2cache.valid = 0;
        processor2cache.operation = OPNONE;
    endtask

    // Flushes cache
    task flush();
        processor2cache.operation = OPFLUSH;
        processor2cache.valid = 1;
        
        @(posedge clk);
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
        #7
        reset = 0;
        #55;
        reset = 1;
    endtask

endmodule