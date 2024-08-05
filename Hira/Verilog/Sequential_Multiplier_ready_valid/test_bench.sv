
/*
============================================================================
 * Filename:    test_bench.sv
 * Description: Contain the functionality of 
                - Random testing
                - Driver for direct testcases
                - Monitor for monitoring.
 * Author:      Hira Firdous
 * Date:        05/08/2024
 ===========================================================================
*/
module tb_top_multiplier;

    logic               clk;
    logic               rst;
    logic               Src_valid;                             
    logic               dd_ready;                               
    logic signed [15:0] A;
    logic signed [15:0] B;
    logic signed [31:0] product; 
    logic               Src_ready;                             
    logic               dd_valid;   
    int                 num_testcases=100;  
    logic signed [31:0] expected_product;     
                           

    top_multiplier dut (  // Instance of top_multiplier
        .clk(clk),   
        .rst(rst),   
        .Src_valid(Src_valid), 
        .dd_ready(dd_ready),  
        .A(A),
        .B(B),
        .product(product), 
        .Src_ready(Src_ready),               
        .dd_valid(dd_valid)
    );

    // Clock 
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

    // Reset task
    task reset();
        begin
            rst = 1; 
            @(posedge clk);
            rst = 0;
        end
    endtask

    task monitor_output();
    //To monitor the output
    begin
        @(posedge Src_valid);
        @(posedge clk);
        
        //wait for destination ready
        while(!dd_ready) begin 
                @(posedge clk);
        end

        //wait for destination valid 
        while(!dd_valid) begin 
                @(posedge clk);
        end 
        expected_product = A * B;
        if (product !== expected_product) begin
                $display(" A= %d, B=%d ,Failed",A,B);
        end else begin
                $display("A=%d, B=%d,Passed",A,B);
        end
        @(posedge clk);
    end
    endtask

    // Random test task
    task random_test();
        int i;
        logic signed [15:0] rand_A, rand_B;

        for (i = 0; i < num_testcases; i++) begin
            // Generate random inputs
            rand_A = $random;
            rand_B = $random;
            expected_product = rand_A * rand_B;

            // Apply inputs
            Src_valid = 1;
            @(posedge clk);
            A = rand_A;
            B = rand_B;
            dd_ready = 1;
            @(posedge clk);
            Src_valid = 0; 

            // checking the value at every iteration
            while(!dd_valid) begin 
                @(posedge clk);
            end 
            
            @(posedge clk);
        end
    endtask


    task driver(input int num_A, input int num_B);
            //$display("driver");
            Src_valid = 1;
            @(posedge clk);
            A = num_A;
            B = num_B;
            dd_ready = 1;
            @(posedge clk);
            Src_valid = 0;  // Deassert Src_valid after one cycle

            expected_product=  A*B;
            // checking the value at every iteration
            while(!dd_valid) begin 
                @(posedge clk);
            end 

            
            
            @(posedge clk);
    endtask

    initial begin
        $dumpfile("sequential.vcd");
        $dumpvars(0, dut);
        reset();

        fork
            forever monitor_output();
            begin
                //Some random testcases
                random_test(); 
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

/*
    // Test scenarios
    initial begin
        // Reset the system
        reset();


        // Call the random test task with a specific number of tests
        @(posedge clk);
        random_test();  // Run 10 random tests

        driver(1,3);

        #50 $finish;
    end
    */

endmodule


/*
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
*/