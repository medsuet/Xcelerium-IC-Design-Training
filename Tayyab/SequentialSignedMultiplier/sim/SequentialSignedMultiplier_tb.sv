/*
    Name: SequentialSignedMultiplier.sv
    Author: Muhammad Tayyab
    Date: 30-7-2024
    Description: Testbench for SequentialSignedMultiplier.sv
*/

module SequentialSignedMultiplier_tb();
    parameter NUMTESTS = 1e1;                   // Number of rndom tests to run
    parameter NUMBITS = 16;                     // Number of bits of multiplier and multiplicand
    parameter MAX_RAND_DELAY = 10;              // Max random delay (in clock cycles) to be inserted before valid_src and ready_dst signals.

    logic clk, reset;
    logic signed [(NUMBITS-1):0] num_a, num_b, monitor_num_a, monitor_num_b;
    logic signed [((2*NUMBITS)-1):0] test_result, ref_result;
    logic valid_src, valid_dst, ready_src, ready_dst;

    SequentialSignedMultiplier #(NUMBITS) ssm
    (
        clk, reset,
        num_a, num_b,
        test_result,
        valid_src, ready_dst,
        valid_dst, ready_src
    );

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    // Directed tests
    initial begin
        init_sequence();
        reset_sequence();
        @(posedge clk);
        $display("\n\nDirected tests:");

        directed_test(0,0);
        directed_test(-2,1);
        //directed_test(0,0);
        directed_test(3,2);
        directed_test(-2,3);
        directed_test(-1,-1);
        directed_test(16'h7FFF,16'h7FFF);

        $display("All directed tests passed\n");

        // Random tests
        $display("Random tests:");
        driver();
        $display("All %d random tests passed.\n\n", NUMTESTS);

        $finish();
    end

    // Monitor
    initial begin
        monitor();
    end

    task directed_test(shortint a, shortint b, int d1=0, int d2=0);
        // Set multiplier and multiplicand signals to input
        num_a = a;
        num_b = b;

        // Assert valid_src signal, wait for ready_scr signal before deasserting it.
        // $random() % 3 :delay of a random number of clock cycles (less than 3) before setting value.
        valid_src_1();
        wait_ready_src();
        valid_src_0();
        @(posedge clk);
    endtask

    task driver();
        // Random tests
        for (int i=0; i<NUMTESTS; i++)
        begin
            // Set multiplier and multiplicand signals to random values
            num_a = $random();
            num_b = $random();
            
            // Assert valid_src signal, wait for ready_scr signal, then deassert it.
            // $random() % 3 :delay of a random number of clock cycles (less than 3) before asserting.
            repeat($random() % MAX_RAND_DELAY) @(posedge clk);
            valid_src_1();
            wait_ready_src();
            valid_src_0();
        end
    endtask

    task monitor();
        @(negedge reset);
        @(posedge reset);
        forever begin
            wait_valid_src();

            monitor_num_a = num_a;
            monitor_num_b = num_b;

            //ref_result = $signed(int'($signed(monitor_num_a)) * int'($signed(monitor_num_b)));
            ref_result = monitor_num_a * monitor_num_b;

            wait_valid_dst();
                        
            // $display("\nTest_result = h'%x", test_result);
            // $display("Correct_result = h'%x\n\n", ref_result);

            if (ref_result !== test_result) begin
                $display("\n\nTest failed.\n");
                $display("%x, %x", monitor_num_a, monitor_num_b);
                $display("\nTest_result = h'%x", test_result);
                $display("Correct_result = h'%x\n\n", ref_result);
                $stop();
            end

            // assert and deassert ready_dst signal with random delay before asserting.
            //repeat($random() % MAX_RAND_DELAY) @(posedge clk);
            @(posedge clk);
            ready_dst_1();
            ready_dst_0();

        end
    endtask

    task init_sequence();
        // Initial values for all signals
        num_a=0;
        num_b=0;
        valid_src=0;
        ready_dst=0;
        reset=1;
        monitor_num_a=0;
        monitor_num_b=0;
        ref_result=0;
    endtask

    task reset_sequence();
        // Reset UUT
        reset = 1;
        #3 reset = 0;
        #50 reset = 1;
    endtask
    
    task valid_src_1();
        // Set valid_scr signal to 1
        // Wait for 1 clock edge after setting it.
        valid_src = 1;
        @(posedge clk);
    endtask

    task valid_src_0();
        // Set valid_scr signal to 0
        // Wait for 1 clock edges before and after setting it.
        @(posedge clk);
        valid_src = 0;
        @(posedge clk);
    endtask

    task ready_dst_1(int delay=0);
        // Set ready_dst signal to 1
        // Wait for 1 clock cycle after setting it.
        ready_dst = 1;
        @(posedge clk);
    endtask

    task ready_dst_0();
        // Set ready_dst signal to 0
        // Wait for 1 clock cycle after setting it.
        ready_dst = 0;
        @(posedge clk);
    endtask

    task wait_valid_src();
        // Wait for valid_src signal to be 1, checking at clk edges
        while (valid_src==0)
            @(posedge clk);
    endtask

    task wait_ready_src();
        // Wait for ready_src signal to be 1, checking at clk edges
        while (ready_src==0)
            @(posedge clk);
    endtask

    task wait_valid_dst();
        // Wait for valid_dst signal to be 1, checking at clk edges
        while (valid_dst==0)
            @(posedge clk);
    endtask

endmodule
