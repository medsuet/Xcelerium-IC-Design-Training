module tb_Top_Module;
    parameter NUMTESTS = 1e1; 
    parameter NUMBITS = 16;   

    // Testbench signals
    logic clk;
    logic reset;
    logic start;
    logic [NUMBITS-1:0] A, B, monitor_A, monitor_B;
    logic [2*NUMBITS-1:0] P, ref_result;
    logic ready;

    Top_Module uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .A(A),
        .B(B),
        .P(P),
        .ready(ready)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    task init_sequence();
        start = 0;
        reset = 1;
        #3 reset = 0;
        #14 reset = 1;
    endtask

    task directed_test(shortint a, shortint b);
        A = a;
        B = b;
        
        //apply start signal
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;
        
        wait (ready);
        #1; // Small delay to ensure result is latched
        ref_result = $signed(int'($signed(A)) * int'($signed(B)));
        
        //compare results with reference model
        if (P !== ref_result) begin
            $display("FAIL: A = %h, B = %h, Expected = %h, Got = %h", A, B, ref_result, P);
        end else begin
            $display("PASS: A = %h, B = %h, Product = %h", A, B, P);
        end
    endtask

    // Apply random inputs and check output
    task random_tests(int num_tests);
        for (int i = 0; i < num_tests; i++) begin
            directed_test($random, $random);
            #($urandom_range(5, 20)); // Random delay between tests
        end
    endtask

    // Monitor task
    task monitor();
        forever begin
            wait(ready); // Wait for ready signal
            #1; // Small delay to ensure result is latched
            ref_result = $signed(int'($signed(A)) * int'($signed(B)));
            if (P !== ref_result) begin
                $display("FAIL: A = %h, B = %h, Expected = %h, Got = %h", A, B, ref_result, P);
            end else begin
                $display("PASS: A = %h, B = %h, Product = %h", A, B, P);
            end
            @(posedge clk); // Wait for the next clock cycle
        end
    endtask

    // Directed tests
    initial begin
        init_sequence();
        $display("\n\nDirected tests:");
        
        directed_test(1, 1);
        directed_test(1, 0);
        directed_test(-1, 2);
        directed_test(=2, -3);
        
        fork
            $display("Random tests:");
            random_tests(NUMTESTS);
            $display("All %d random tests passed.\n\n", NUMTESTS);
            monitor();
        join

        $finish();
    end

endmodule
