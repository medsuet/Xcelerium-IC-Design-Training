// Author       : Zawaher Bin Asim  , UET Lahore 
// Description  : data cache test bench . It contain the main memory module to test the cache 
// Date         : 15 Aug 2024 


`include "../define/cache_defs.svh"

module cache_tb();

    logic                           clk,reset;

    // Inputs from processor to cache
    logic                           ld_req,st_req;                  //load_store_request from the processor
    logic                           dcache_flush;                   // flush the cache
    logic   [DCACHE_ADDR_WIDTH-1:0] pro2dcache_addr;
    logic   [DCACHE_DATA_WIDTH-1:0] pro2dcache_data;
    logic                           pro_ready;                     // signal tell processor is ready to take output


    // Outputs from cache to processor
    logic                           dcache2pro_ack;                 // when the hit occures
    logic   [DCACHE_DATA_WIDTH-1:0] dcache2pro_data;
    logic                           dcache_ready;                 // ready signal that shows the cache is ready for the input

    // Inputs from  memory to cache
    logic                           mem2cache_ack;                  // when data written to mem or when data is taken from the mem
    logic   [DCACHE_DATA_WIDTH-1:0] mem2dcache_data;

    // Outputs from cache to memory
    logic                           dcache2mem_req;                 // when the the data and address transfer to main mem in case of the miss + dirty 
    logic                           mem_wrb_req;                    // write in the main memory in case of the write back
    logic   [DCACHE_ADDR_WIDTH-1:0] dcache2mem_addr;
    logic   [DCACHE_DATA_WIDTH-1:0] dcache2mem_data;
    logic   [DCACHE_DATA_WIDTH-1:0] tb_main_mem_data; // Accessing main memory for test



dcache  DCACHE(

    .clk(clk),.reset(reset),

    // Inputs from processor to cache
    .ld_req(ld_req),.st_req(st_req),          
    .dcache_flush(dcache_flush),         
    .pro2dcache_addr(pro2dcache_addr),
    .pro2dcache_data(pro2dcache_data),
    .pro_ready(pro_ready),

    // Outputs from cache to processor
    .dcache2pro_ack(dcache2pro_ack),     
    .dcache2pro_data(dcache2pro_data),
    .dcache_ready(dcache_ready),

    // Inputs from  memory to cache
    .mem2cache_ack(mem2cache_ack),       
    .mem2dcache_data(mem2dcache_data),

    // Outputs from cache to memory
    .dcache2mem_req(dcache2mem_req),      
    .mem_wrb_req(mem_wrb_req),         
    .dcache2mem_addr(dcache2mem_addr),
    .dcache2mem_data(dcache2mem_data)
    
);

// Instantiate the memory module
    main_mem MAIN_MEM (
        .clk(clk), .reset(reset),
        .dcache2mem_data(dcache2mem_data),
        .dcache2mem_addr(dcache2mem_addr),
        .dcache2mem_req(dcache2mem_req),
        .mem_wrb_req(mem_wrb_req),
        .mem2dcache_data(mem2dcache_data),
        .mem2cache_ack(mem2cache_ack),
        .tb_main_mem_data(tb_main_mem_data) // Connect to the main memory output
    );
    
    initial begin
    // Clock generation
        clk <= 0;
        forever #5 clk <= ~clk;
    end

    // Reset task
    task reset_sequence();
        begin
            reset <= 1;
            @(posedge clk);
            reset <= 0;
            @(posedge clk);
            reset <= 1;
        end
    endtask

// Task to flush the cache
    task flush_cache();
        begin
            dcache_flush <= 1;
            @(posedge clk);
            dcache_flush <= 0;
            @(posedge clk);
        end
    endtask

// Task for writing data to the cache
    task write_to_cache(input logic [DCACHE_ADDR_WIDTH-1:0] addr, input logic [DCACHE_DATA_WIDTH-1:0] data);
        begin
            st_req <= 1;
            pro2dcache_addr <= addr;
            pro2dcache_data <= data;
            while (!dcache_ready)begin
                @(posedge clk);    
            end
            @(posedge clk);
            st_req <= 0;
            
        end
    endtask

    // Task for reading data from the cache
    task read_from_cache(input logic [DCACHE_ADDR_WIDTH-1:0] addr);
        begin
        
            ld_req <= 1;
            pro2dcache_addr <= addr;
            while (!dcache_ready)begin
                @(posedge clk);    
            end
            @(posedge clk);
            ld_req <= 0;
            
        end        
    endtask  

    // Initialize the signals 
    task init_signals();
        ld_req          <= 0;
        st_req          <= 0;
        dcache_flush    <= 0;
        pro2dcache_addr <= 0;
        pro2dcache_data <= 0;
        pro_ready       <= 0;
    endtask 

    task  pro_ready_for_flush();
            @(posedge clk);
            pro_ready <= 1'b1;
            while (!dcache2pro_ack)begin
                @(posedge clk);
            end
            pro_ready <= 1'b0;
            repeat(1) @(posedge clk);
    endtask 

    task monitor(input logic [DCACHE_DATA_WIDTH-1:0]expected_data);
        begin
            @(posedge clk);
            pro_ready <= 1'b1;
            while (!dcache2pro_ack)begin
                @(posedge clk);
            end
            if (dcache2pro_data == expected_data)begin
                $display ("=====================Test Passed=======================");
                $display("Output : %d",dcache2pro_data);
            end
            else begin
                $display("======================Test Failed=======================");
                $display("Expected_Data : %d   |  Actual_Data : %d ",expected_data,dcache2pro_data);    
            end

            pro_ready <= 1'b0;
            repeat(1) @(posedge clk);
        end

    endtask

    
 // Main test sequence
    initial begin
        
        init_signals();
// Perform reset
        reset_sequence();
        
        fork
          write_to_cache(32'h0000_1000, 32'hDEAD_BEEF);
          monitor(32'hDEAD_BEEF);      
        join
        fork
            flush_cache();
            pro_ready_for_flush();
        join
        
        fork
            write_to_cache(32'h0000_1000, 32'hCAFE_BEEF);
            monitor(32'hCAFE_BEEF);                
        join


        // Test Case 1: Write data to the cache
        //write_to_cache(32'h0000_0000, 32'hDEAD_BEEF);
        //write_to_cache(32'h0000_0004, 32'hCAFEBABE);

        // Test Case 2: Read data from the cache (should hit)
       // read_from_cache(32'h0000_0000, 32'hDEAD_BEEF);
        //read_from_cache(32'h0000_0004, 32'hCAFEBABE);

        // Test Case 3: Flush the cache and check the memory state
        ///flush_cache();
       // pro2dcache_addr = 32'h0000_0000;
        //read_from_cache(pro2dcache_addr, tb_main_mem_data); // Use the memory data after flush

        // Test Case 4: Access data not in the cache (should miss and then load)
        //pro2dcache_addr = 32'h0000_1000;
        //read_from_cache(pro2dcache_addr, tb_main_mem_data);

        // Test Case 5: Write data, ensure it is properly written back to memory on flush
        //write_to_cache(32'h0000_0008, 32'hABCD_EF01);
        //flush_cache();
        //pro2dcache_addr = 32'h0000_0008;
        //read_from_cache(pro2dcache_addr, tb_main_mem_data);  // Ensure it reads back correctly

        // End simulation
        //$display("All test cases passed.");
        $finish;
    end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module main_mem (
    // Inputs to the memory module
    input   logic                           clk, reset,
    input   logic   [DCACHE_DATA_WIDTH-1:0] dcache2mem_data,
    input   logic   [DCACHE_ADDR_WIDTH-1:0] dcache2mem_addr,
    input   logic                           dcache2mem_req,
    input   logic                           mem_wrb_req,

    // Outputs of the memory module
    output  logic   [DCACHE_DATA_WIDTH-1:0] mem2dcache_data,
    output  logic                           mem2cache_ack,

    // For testbench access
    output  logic   [DCACHE_DATA_WIDTH-1:0] tb_main_mem_data
);

    // #=======================Main MEMORY=====================#
    reg [DCACHE_DATA_WIDTH-1:0] main_mem[2*DCACHE_NO_OF_SETS-1:0];  // Let's make the main memory twice the size of the cache   

    assign tb_main_mem_data = main_mem[dcache2mem_addr];

    always_ff @(posedge clk or negedge reset) begin 
        if (!reset) begin
            // Initialize the main memory with arbitrary values
            int i;
            for (i = 0; i < 2*DCACHE_NO_OF_SETS; i++) begin
                main_mem[i] <= $random;  // Assign random values to memory locations
            end
            
            // Reset the output signals
            mem2dcache_data <= 'h0;
            mem2cache_ack   <= 1'b0;
        end else begin
            // Reset mem2cache_ack at the beginning of each clock cycle
            mem2cache_ack <= 1'b0;

            if (dcache2mem_req) begin
                if (mem_wrb_req) begin
                    // Write operation
                    main_mem[dcache2mem_addr] <= dcache2mem_data;
                    mem2cache_ack <= 1'b1;
                end else begin
                    // Read operation
                    mem2dcache_data <= main_mem[dcache2mem_addr];
                    mem2cache_ack   <= 1'b1;
                end
            end
        end
    end

endmodule
