/*
    Name: SequentialSignedMultiplier.sv
    Author: Muhammad Tayyab
    Date: 30-7-2024
    Description: Testbench for SequentialSignedMultiplier.sv
*/

module SequentialSignedMultiplier_tb();
    parameter NUMTESTS = 1e1;
    parameter NUMBITS = 16;

    logic clk, reset;
    logic [(NUMBITS-1):0] num_a, num_b, monitor_num_a, monitor_num_b;
    logic [((2*NUMBITS)-1):0] test_result, ref_result;
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

        $display("\n\nDirected tests:");
        
        directed_test(-2,1);
        directed_test(0,0);
        directed_test(3,2);
        directed_test(2,-3);
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

    task directed_test(shortint a, shortint b, int d1=0, int d2=0, int d3=0, int d4=0);
        num_a = a;
        num_b = b;

        @(posedge clk);
        valid_src_1(d1);
        valid_src_0(d2);
        @(valid_dst);
        ready_dst_1(d3);  
        ready_dst_0(d4);
    endtask

    task driver();
        for (int i=0; i<NUMTESTS; i++)
        begin
            num_a = $random();
            num_b = $random();
            
            valid_src_1($random() % 3);
            valid_src_0($random() % 3);
            @(valid_dst);
            ready_dst_1($random() % 3);
            ready_dst_0($random() % 3);
        end
    endtask

    task monitor();
        @(negedge reset);
        @(posedge reset);
        forever begin
            @(posedge valid_src);
            monitor_num_a = num_a;
            monitor_num_b = num_b;

            ref_result = $signed(int'($signed(monitor_num_a)) * int'($signed(monitor_num_b)));
            
            @(posedge valid_dst);
            
            // $display("\nTest_result = h'%x", test_result);
            // $display("Correct_result = h'%x\n\n", ref_result);

            if (ref_result !== test_result) begin
                $display("\n\nTest failed.\n");
                $display("%x, %x", monitor_num_a, monitor_num_b);
                $display("\nTest_result = h'%x", test_result);
                $display("Correct_result = h'%x\n\n", ref_result);
                $stop();
            end
        end
    endtask

    task init_sequence();
        valid_src=0;
        ready_dst=0;
        reset=1;
    endtask

    task reset_sequence();
        reset = 1;
        #3 reset = 0;
        #14 reset = 1;
    endtask

    task valid_src_1(int delay=1);
        repeat(delay) @(posedge clk);
        valid_src = 1;
        @(posedge clk);
    endtask

    task ready_dst_1(int delay=1);
        repeat(delay) @(posedge clk);
        ready_dst = 1;
        @(posedge clk);
    endtask

    task valid_src_0(int delay=1);
        repeat(delay) @(posedge clk);
        valid_src = 0;
        @(posedge clk);
    endtask

    task ready_dst_0(int delay=1);
        repeat(delay) @(posedge clk);
        ready_dst = 0;
        @(posedge clk);
    endtask

endmodule
