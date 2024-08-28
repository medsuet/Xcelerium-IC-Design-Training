/*
    Name: axi4lite_controller_tb.sv
    Author: Muhammad Tayyab
    Date: 19-8-2024
    Description: Modelsim testbench for axi4lite_controller.sv
*/

module axi4lite_controller_tb();

    parameter NUM_RANDOM_TESTS = 20;
    parameter RAND_DELAY = 5;
    parameter RANDOM_SEED = 24;

    logic clk, reset;
    logic mem_wr_req, axi_valid;
    logic axi_ready;
    logic arready, rvalid, awready, wready, bvalid;
    logic arvalid, rready, awvalid, wvalid, bready;
    
    // Instantiation
    axi4lite_controller DUT (
        .clk(clk),
        .reset(reset),
        
        // Signals with cache
        .mem_wr_req(mem_wr_req),
        .axi_valid(axi_valid),
        .axi_ready(axi_ready),

        // Signals with memory (AXI4-lite)
        .arready(arready),
        .rvalid(rvalid),
        .awready(awready),
        .wready(wready),
        .bvalid(bvalid),

        .arvalid(arvalid),
        .rready(rready),
        .awvalid(awvalid),
        .wvalid(wvalid),
        .bready(bready)
    );

    // Generate clock
    initial begin
        clk = 1; 
        forever #5 clk = ~clk;
    end

    // Tests
    initial begin
        init_sequence();
        reset_sequence();
        @(posedge clk);

        $urandom(RANDOM_SEED);

        $display("\n\nTests starting.\n");

        fork
            processor_driver();
            memory_arready_driver();
            memory_rvalid_driver();
            memory_awready_wready_driver();
            memory_bvalid_driver();
        join_any

        // If signals are not coming as intended, processor_driver gets stuck (and does not exit)
        // and this $display won't be exceuted.
        $display("Tests passed.\n\n");


        repeat(5) @(posedge clk);
        $finish();
    end

    int i;
    task processor_driver();
        for (i=0; i<NUM_RANDOM_TESTS; i++) begin
            // keep axi_valid = 0 for random delay
            repeat($urandom % RAND_DELAY) @(posedge clk);

            // apply random read/write operation
            mem_wr_req = $urandom;
            axi_valid = 1;

            // wait for axi_ready
            @(posedge clk)
            while (!axi_ready)
                @(posedge clk);
            
            axi_valid = 0;
        end
    endtask

    task memory_arready_driver();
        forever begin
            @(posedge clk)
            while (!arvalid)
                @(posedge clk);

            repeat($urandom % RAND_DELAY) @(posedge clk);
            arready = 1;

            @(posedge clk)
            arready = 0;
        end
    endtask

    task memory_rvalid_driver();
        forever begin
            @(posedge clk)
            while (!rready)
                @(posedge clk);

            repeat($urandom % RAND_DELAY) @(posedge clk);
            rvalid = 1;

            @(posedge clk)
            rvalid = 0;
        end
    endtask

    task memory_awready_wready_driver();
        forever begin
            @(posedge clk)
            while (!(awvalid & wvalid))
                @(posedge clk);

            repeat($urandom % RAND_DELAY) @(posedge clk);
            awready = 1;
            wready = 1;

            @(posedge clk)
            awready = 0;
            wready = 0;
        end
    endtask

    task memory_bvalid_driver();
        forever begin
            @(posedge clk)
            while (!bready)
                @(posedge clk);

            repeat($urandom % RAND_DELAY) @(posedge clk);
            bvalid = 1;

            @(posedge clk)
            bvalid = 0;
        end
    endtask

    task init_sequence();
        reset = 1;
        axi_valid = 0;
        mem_wr_req = 0;
        arready = 0;
        rvalid = 0;
        awready = 0;
        wready = 0;
        bvalid = 0;
        @(posedge clk);
    endtask
    
    task reset_sequence();
        #7
        reset = 0;
        #55;
        reset = 1;
    endtask

endmodule
