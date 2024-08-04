module sequential_multiplier_tb;

    // Inputs
    logic signed [15:0] multiplicand;
    logic signed [15:0] multiplier;
    logic clk;
    logic reset;
    logic src_valid;
    logic dest_ready;
    logic src_ready;
    logic dest_valid;

    logic [31:0] count_tests;
    logic [31:0] failed;
    logic [31:0] passed;
    // Reference model output
    logic signed [31:0] expected;

    // Outputs
    logic signed [31:0] product;

    // Instantiation
   sequential_multiplier uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .clk(clk),
        .reset(reset),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_ready(dest_ready),
        .dest_valid(dest_valid),
        .product(product)
    );

    // Clock generation
    initial begin
        clk = #1 1;
        forever #5 clk = ~clk; // 10 ns period clock
    end


    // Dump file for waveform
    initial begin
        $dumpfile("valid_ready_signed_multiplier.vcd");
        $dumpvars(0, sequential_multiplier_tb);
    end

    task init_sequence; 
        begin
            // Initialize Inputs
            multiplicand = 0;
            multiplier = 0;
            src_valid = 0;
            src_ready = 0;
        end
    endtask

    task reset_sequence; 
        begin
            // first reset apply acychronus reset
            reset = #1 0;
            // start = #1 0;
            // @(posedge clk);
            #10 reset = #1 1;
        end
    endtask

    // Task for driving inputs
    task driver(input logic signed [15:0] input1, input logic signed [15:0] input2);
        begin
            multiplicand = input1;
            multiplier = input2;
            src_valid = 1'b1;
            check_dest_ready();
            // // start = 1;
            // @(posedge clk);
            // start = 0;
        end
    endtask

    // Define a task to check the condition and exit the loop
    task check_dest_ready;
        begin
            while (!dest_ready) begin
                @(posedge clk);
            end
        end
    endtask

    // Task for monitoring outputs
    task monitor;
        begin
            // wait (dest_valid == 1);
            check_dest_valid();
            repeat(5)@(posedge clk);
            src_ready = 1'b1;
            @(posedge clk)
            src_ready = 1'b0;
            expected = multiplicand * multiplier;
            #10;
            count_tests++;
            if (expected != product) begin
                failed++;
                $display("Test %0d failed: M = %0d, Q = %0d, product = %0d, Expected = %0d", count_tests ,multiplicand, multiplier, product, expected);
            end else begin
                passed++;
                $display("Test %0d passed: M = %0d, Q = %0d, product = %0d, Expected = %0d", count_tests,multiplicand, multiplier, product, expected);
            end
        end
    endtask

    task check_dest_valid;
        begin
            while(!dest_valid) begin
                @(posedge clk);
            end
        end
    endtask

    // Directed test cases using fork-join for edge cases
    initial begin
        init_sequence();
        reset_sequence();
        // #10 src_valid = 1'b1;
        count_tests = 32'b0;
        failed = 32'b0;
        passed = 32'b0;
        // Fork-join for parallel test execution
        fork
            begin
                // directed tests
                driver(12345,-1);   
                monitor();

                @(posedge clk);
                src_valid = 1'b1;

                driver(12345, 0);   
                monitor();

                @(posedge clk);
                src_valid = 1'b1;

                driver(0, 0);   
                monitor();

                @(posedge clk);
                src_valid = 1'b1;

                driver(12345, -1); 
                monitor();

                @(posedge clk);
                src_valid = 1'b1;
                
                driver(-1, 1); 
                monitor();

                @(posedge clk);
                src_valid = 1'b1;
                
                // Random testing loop
                for (int i = 0; i < 2000; i++) begin
                    logic signed [15:0] rand_multiplicand, rand_multiplier;
                    
                    // Generate random numbers
                    rand_multiplicand = $random % 65536; 
                    rand_multiplier = $random % 65536;  
                    // @(posedge clk);

                    // Drive random inputs and check output
                    driver(rand_multiplicand, rand_multiplier);
                    monitor();  
                    @(posedge clk); // Synchronize with the clock
                    src_valid = 1'b1;
                end
            $display("%0d Tests failed", failed);
            $display("%0d Tests passed", passed); 
            end

        join

        $finish;
    end
endmodule