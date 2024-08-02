
/*
============================================================================
 * Filename:    test_bench.sv
 * Description: Contain the functionality of 
                - Random testing
                - Driver for direct testcases
                - Monitor for monitoring.
                - with the advancement of valid-ready protocol 
 * Author:      Hira Firdous
 * Date:        02/08/2024
 ===========================================================================
*/
module tb_top_multiplier;

    // Signals
    logic               clk;
    logic               rst;
    logic               input_ready;
    logic signed [15:0] A;
    logic signed [15:0] B;
    logic signed [31:0] product;
    logic               output_ready;
    logic               output_valid;
    logic               input_valid;
    logic signed [31:0] ref_product;
    int                 num_tests = 100; // Number of random testcases to be generate


    // Instantiate the top multiplier module
    top_multiplier dut (
        .clk(clk),
        .rst(rst),
        .start(input_ready),
        .in_valid(input_valid),
        .A(A),
        .B(B),
        .product(product),
        .output_valid(output_valid),                //this was originally done
        .output_ready(output_ready)                                 
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Monitor task
    task monitor_output;
        /* This task is use to monitor the output at any points
        */
        begin
            //First wait for the input to be valid
            @(negedge input_valid);
            @(posedge clk);
            @(posedge input_valid);
            //storing original test
            ref_product = A * B;
           // waiting for the output is ready
            @(negedge output_ready);
            @(posedge output_valid);
            if (product == ref_product) begin
                $display("Passes: A = %d, B = %d, Product = %d", A, B, product);
            end else begin
                $display("Test failed: A = %d, B = %d, Expected Product = %d, Got Product = %d", A, B, ref_product, product);
            end
            //wait for the signal to end
            @(negedge output_valid);
            //then wait for one clock cycle
            @(posedge clk);

            
        end
    endtask

    // for testing on random testcases
    task random();
        /* This task run the random testcases depending on the 
            value of num_tests
        */
        begin
            //First reset the signals
            rst = 1;
            @(posedge clk);
            rst = 0;
            @(posedge clk);
            
            //This signal is set one because now the source is ready 
            //to send the data to destination.
            input_ready = 1;
            repeat (num_tests) begin
                //This signal is that it should load the data now it is valid
                input_valid=0;
                @(posedge clk);
                A = $random;
                B = $random;
                input_valid = 1;
                @(posedge clk);
                ref_product = A * B;
                //Wait until the output is being processed
                @(negedge output_ready);
                //wait for output valid signal so we can fetch the data from destination
                @(posedge output_valid);
                /*
                wait (output_ready);                  
                wait (output_valid);
                */
                //$display("Passes: A = %d, B = %d, Product = %d", A, B, product);
                @(negedge output_valid);
                @(posedge clk);
            end
            input_ready = 0;
        end
    endtask

    // A driver for testcases
    task driver(input logic signed [15:0] A_in, input logic signed [15:0] B_in);
    //This block is same as random loop iterate only once, so same logic as random
        begin
            rst = 1;
            @(posedge clk);
            rst = 0;
            @(posedge clk);
           
            //negative edge
            input_ready = 1;
            input_valid = 0;
            @(posedge clk);

            A = A_in;
            B = B_in;

            input_valid=1;
            @(posedge clk);
            ref_product = A * B;


            @(negedge output_ready);
            @(posedge output_valid);
            //$display(" passed: A=%0d, B=%0d, Product=%0d", A, B, product);
            @(negedge output_valid);
            //#10;
             @(posedge clk);
            input_ready = 0;
            //#10;
        end
    endtask

    // Sample testbench
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



