
/*
============================================================================
 * Filename:    test_bench.sv
 * Description: Contain the functionality of 
                - Random testing
                - Driver for direct testcases
                - Monitor for monitoring.
 * Author:      Hira Firdous
 * Date:        30/07/2024
 ===========================================================================
*/
module tb_top_multiplier;

    // Signals
    logic               clk;
    logic               rst;
    logic               start;
    logic signed [15:0] A;
    logic signed [15:0] B;
    logic signed [31:0] product;
    logic               done;

    logic signed [31:0] ref_product;
    int                 num_tests = 100; // Number of random testcases to be generate

    // Instantiate the top multiplier module
    top_multiplier dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .product(product),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Monitor task
    task monitor_output;
        begin
            // Wait for the signals to be stable before checking
            wait (rst);
            wait (start); 
            //storing original test
            ref_product = A * B;
            wait(done); // Wait for done signal
            if (product === ref_product) begin
                $display("Passes: A = %d, B = %d, Product = %d", A, B, product);
            end else begin
                $display("Test failed: A = %d, B = %d, Expected Product = %d, Got Product = %d", A, B, ref_product, product);
            end
        end
    endtask

    // for testing on random testcases
    task random();
        begin
            repeat (num_tests) begin
                rst = 1;
                #10;
                rst = 0;
                #10;
                A = $random;
                B = $random;
                start = 1;
                ref_product = A * B;
                #10;
                start = 0;
                wait (done);
                #10; // Delay between tests
            end
        end
    endtask

    // A driver for testcases
    task driver(input logic signed [15:0] A_in, input logic signed [15:0] B_in);
        begin
            rst = 1;
            #10;
            rst = 0;
            #10;

            A = A_in;
            B = B_in;
            start = 1;
            ref_product = A * B;
            #10;
            start = 0;
            wait (done);
            #10; // Delay between tests
        end
    endtask

    // Test procedure
    initial begin
        $dumpfile("sequential.vcd");
        $dumpvars(0, dut);

        fork
            forever monitor_output();
            begin
                //Some random testcases
                random(); 
                
                /*
                Some directed testing with
                 edge testcases
                */

                // when both inputs are zero
                driver(0, 0); 

                // when one input is one
                driver(1, 3);

                //when one output is negative one
                driver(3, -1);

                //when both are maximum numbers
                driver(32767, 32767);

                //when both are maximum negative numbers
                driver(-32768, -32768);
                
                $finish;
            end
        join
    end

endmodule
