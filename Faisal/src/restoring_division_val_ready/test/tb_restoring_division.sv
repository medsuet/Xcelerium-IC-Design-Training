module tb_restoring_division;
    // Parameter definition with default value
    parameter WIDTH = 16;  // Width of data signals
    parameter MAXNUM = 56535; // max number of 16bit
    parameter CYCLE = 10; 

    // Inputs
    logic [WIDTH-1:0] dividend; // Input for dividend
    logic [WIDTH-1:0] divisor;  // Input for divisor
    logic clk;                  // Clock signal
    logic reset;                // Reset signal (active-low)
    logic src_valid;            // Source valid signal
    logic dest_ready;           // Destination ready signal

    // Outputs
    logic [WIDTH-1:0] quotient;    // Output quotient
    logic [WIDTH-1:0] remainder;   // Output remainder
    logic src_ready, dest_valid;   // Handshake signals

    // Expected outputs for verification
    logic [WIDTH-1:0] expected_quotient;
    logic [WIDTH-1:0] expected_remainder;
    integer passed;
    integer failed;

    // Instantiate the Unit Under Test (UUT)
    restoring_division #(.WIDTH(WIDTH)) uut (
        .dividend(dividend),
        .divisor(divisor),
        .clk(clk),
        .reset(reset),
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
        forever #(CYCLE / 2) clk = ~clk; // 10 ns period clock
    end

    // Dump file for waveform
    initial begin
        $dumpfile("restoring_division.vcd");
        $dumpvars(0,tb_restoring_division);
    end

    // Task for reset sequence
    task reset_sequence();
        begin
            @(posedge clk);
            reset = 0;           // Assert reset signal
            @(posedge clk);  // Wait for 200 clock cycles
            reset = 1;           // Deassert reset signal
        end
    endtask

    // Task to initialize the signals
    task init_sequence();
        begin
            dividend = 0;        // Initialize dividend to 0
            divisor = 0;         // Initialize divisor to 0
            passed = 0;
            failed = 0;
            src_valid = 0;       // Initialize src_valid to 0
            dest_ready = 0;      // Initialize dest_ready to 0
            reset = 1;           // Initialize reset signal (active-low)
        end
    endtask

    // Task for driving inputs
    task drive_inputs(input logic [WIDTH-1:0] input1, input logic [WIDTH-1:0] input2);
        begin
            dividend = input1;         // Assign input to dividend
            divisor = input2;          // Assign input to divisor
            src_valid = 1;          // Assert src_valid signal

            @(posedge clk);
            while (!src_ready) @(posedge clk);  // Wait for src_ready signal
            src_valid = 0;          // Deassert src_valid signal

            while (!dest_valid) @(posedge clk);  // Wait for dest_valid signal
            dest_ready = 1;        // Assert dest_ready signal
            
            @(posedge clk);
            dest_ready = 0;        // Deassert dest_ready signal
        end
    endtask

    // Task for monitoring outputs
    task monitor_outputs;
        begin
            @(posedge dest_ready) expected_quotient = dividend / divisor; 
            expected_remainder = dividend % divisor;
            @(posedge clk);
            if ((expected_quotient == quotient) && (expected_remainder == remainder)) 
            begin
                passed += 1;
                $display("Pass: dividend = %0d, divisor = %0d, Q = %0d, Expected_Q = %0d, R = %0d, Expected_R = %0d", dividend, divisor, quotient, expected_quotient, remainder, expected_remainder);
            end 
            else 
            begin
                failed += 1;
                $display("Fail: dividend = %0d, divisor = %0d, Q = %0d, Expected_Q = %0d, R = %0d, Expected_R = %0d", dividend, divisor, quotient, expected_quotient, remainder, expected_remainder);
            end
        end
    endtask

    // Task to pass inputs and monitor outputs
    task pass_inputs(input logic [WIDTH-1:0] input1, input logic [WIDTH-1:0] input2);
        begin
            fork
                drive_inputs(input1, input2);  // Drive inputs and perform handshake
                monitor_outputs();       // Monitor the outputs
            join
            
        end
    endtask

    // Stimulus process
    initial begin
        // Initialize signals
        init_sequence();
        // Apply reset  
        reset_sequence(); 
        fork
            begin
                // Directed tests with delays
                pass_inputs(0, 1000);   // Test with dividend 0
                pass_inputs(MAXNUM, 1);  // Test with maximum dividend and divisor 1
                pass_inputs(32767, 1);  // Test with half of the maximum dividend and divisor 1
                pass_inputs(1, MAXNUM);  // Test with dividend 1 and maximum divisor  

                // Random Testing with delays
                for (int i = 0; i < 500; i++) begin
                    dividend = $random  % MAXNUM;  // Generate random dividend
                    divisor = $random % MAXNUM;   // Generate random divisor
                    if (divisor == '0) begin
                        divisor += 1;   // Avoid division by zero
                    end
                    pass_inputs(dividend, divisor);  // Test with random values
                end
                // Display final results
                $display("Total Pass: %0d and Total Fail: %0d", passed, failed);  
            end
        join
        $finish;  // End simulation
    end
endmodule
