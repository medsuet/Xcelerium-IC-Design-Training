module tb_restoring_division;
    // Parameter definition with default value
    parameter WIDTH = 16;

    // Inputs
    logic [WIDTH-1:0]dividend; // Input fordividend
    logic [WIDTH-1:0] divisor;   // Input for divisor
    logic clk;                             // Clock signal
    logic rst_n;                             // Reset signal
    logic src_valid;                       // Source valid signal
    logic dest_ready;                      // Destination ready signal

    // Expected product for verification
    logic [WIDTH-1:0] expected_quotient;
    logic [WIDTH-1:0] expected_remainder;

    logic [WIDTH-1:0] rand_dividend;
    logic [WIDTH-2:0] rand_divisor;

    // Outputs
    logic [WIDTH-1:0] quotient;  // Output product
    logic [WIDTH-1:0] remainder;
    logic src_ready, dest_valid;           // Handshake signals

    // Pass and fail counters
    integer pass_count = 0;
    integer fail_count = 0;

    // Instantiate the Unit Under Test (UUT)
    restoring_division #(.WIDTH(WIDTH)) uut (
        .dividend(dividend),
        .divisor(divisor),
        .clk(clk),
        .rst_n(rst_n),
        .src_valid(src_valid),
        .dest_ready(dest_ready),
        .dest_valid(dest_valid),
        .src_ready(src_ready),
        .quotient(quotient),
        .remainder(remainder)
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; // 10 ns period clock
    end

    // Dump file for waveform
    initial begin
        $dumpfile("restoring.vcd");
        $dumpvars(0);
    end

    // Task for driving inputs
    task drive_inputs(input logic [WIDTH-1:0] in1, input logic [WIDTH-1:0] in2);
        begin
           dividend = in1;            // Assign input todividend
            divisor = in2;              // Assign input to divisor
            src_valid = 1;                 // Assert src_valid signal

            @(posedge clk);
            while (!src_ready) @(posedge clk); // Wait for src_ready signal
            $display("\nHandshake 1 complete:dividend = %0d, divisor = %0d",dividend, divisor);
            src_valid = 0;                       // Deassert src_valid signal

            while (!dest_valid) @(posedge clk);  // Wait for dest_valid signal
            dest_ready = 1;                      // Assert dest_ready signal
            
            @(posedge clk);
            dest_ready = 0;                      // Deassert dest_ready signal
        end
    endtask

    // Task for monitoring outputs
    task monitor_outputs;
        begin
            @(posedge dest_ready) expected_quotient = dividend / divisor; 
            expected_remainder = dividend % divisor;
            @(posedge clk);
            $display("'dest_ready' is 1, Handshake 2 Initiated: Waiting for product");
            if ((expected_quotient == quotient ) && (expected_remainder == remainder)) begin
                pass_count += 1;
                $display("PASS: time = %0t,dividend = %0d, divisor = %0d, quotient = %0d, Expected = %0d, remainder = %0d, Expected = %0d", $time,dividend, divisor, quotient, expected_quotient, remainder, expected_remainder);
            end  else begin
                fail_count += 1;
                $display("FAIL: time = %0t,dividend = %0d, divisor = %0d, quotient = %0d, Expected = %0d, remainder = %0d, Expected = %0d", $time,dividend, divisor, quotient, expected_quotient, remainder, expected_remainder);
            end
        end
    endtask

    // Task for reset sequence
    task reset_sequence();
        begin
            @(posedge clk);
            rst_n = 0;                       // Assert reset signal
            repeat(200) @(posedge clk);
            rst_n = 1;                       // Deassert reset signal
        end
    endtask

    // Task to initialize the signals
    task init_sequence();
        begin
            // Initialize Inputs
            dividend = 0;              // Initializedividend to 0
            divisor = 0;                // Initialize divisor to 0
            src_valid = 0;                 // Initialize src_valid to 0
            dest_ready = 0;                // Initialize dest_ready to 0
            rst_n = 1;                       // Initialize rst_n to 1
        end
    endtask

    // Task for generating random delay
    // Random delay between tests will ensure that even if src_ready is 1, if src_valid is not 1 handshake won't occur
    task random_delay();
        begin
            repeat(($random % 10)) @(posedge clk);
        end
    endtask

    task pass_inputs(input logic [WIDTH-1:0] in1, input logic [WIDTH-1:0] in2);
        begin
            fork
                drive_inputs(in1, in2);
                monitor_outputs();
            join
            // Random delay between tests will ensure that even if src_ready is 1, if src_valid is not 1 handshake won't occur
            random_delay();
        end
    endtask

    // Stimulus process
    initial begin
        // Initialize Inputs
        init_sequence();
        
        reset_sequence();

        // Directed tests with delays

        // Division by 1
        pass_inputs(65535,1);
        pass_inputs(32767,1);

        // Random Testing with delays
        for(int i = 0; i < 100000; i++) begin
            // Generate random inputs for dividend
            rand_dividend = $random;
            // Generate random inputs for divisor within range 1 to 32768
            rand_divisor = $random;
            if(rand_divisor == '0) begin
                rand_divisor += 1;
            end
            pass_inputs(rand_dividend, rand_divisor);
        end

        // Display final results
        $display("\nTotal PASS count: %0d", pass_count);
        $display("Total FAIL count: %0d\n", fail_count);

        $finish;
    end

endmodule
