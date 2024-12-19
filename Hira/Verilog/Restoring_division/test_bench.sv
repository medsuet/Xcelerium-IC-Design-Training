module tb_top_module;

    // Testbench signals
    logic clk;
    logic rst;
    logic src_valid;
    logic dd_ready;
    logic [31:0] dividend;
    logic [31:0] divisor;
    logic [31:0] quotient;
    logic [31:0] remainder;
    logic dd_valid;
    logic src_ready;
    int         num_test=1;


    // Instantiate the top_module
    top_module dut (
        .clk(clk),
        .rst(rst),
        .src_valid(src_valid),
        .dd_ready(dd_ready),
        .dividend(dividend),
        .divisor(divisor),
        .quotient(quotient),
        .remainder(remainder),
        .dd_valid(dd_valid),
        .src_ready(src_ready)
    );

    // Clock generation
    always #5 clk = ~clk;
task random();
    // Logic for random test case generation
    logic signed [31:0] ref_quotient, ref_remainder;
    
    clk = 0;
    rst = 0;
    src_valid = 0;
    dd_ready = 0;
    dividend = 32'd0;
    divisor = 32'd0;
    @(posedge clk);

    // Apply reset
    rst = 1;
    @(posedge clk);
    rst = 0;
    @(posedge clk);

    for (int i = 0; i < num_test; i++) begin
        // Generate random dividend and divisor
        dividend = $random;
        divisor = $random;
        
        // Ensure divisor is not zero to avoid division by zero
        if (divisor == 0) begin
            divisor = $random;
        end
        
        // Set source valid and destination ready signals
        src_valid = 1;
        dd_ready = 1;

        // Calculate reference values for quotient and remainder
        ref_quotient = dividend / divisor;
        ref_remainder = dividend % divisor;

        // Wait for src_ready signal
        wait(src_ready);
        @(posedge clk);
        src_valid = 0;

        // Wait for dd_valid signal indicating completion
        wait(dd_valid);

        // Check results: pass or fail
        if (quotient == ref_quotient && remainder == ref_remainder) begin
            $display("Test %0d: PASS - Dividend: %0d, Divisor: %0d, Quotient: %0d, Remainder: %0d",
                     i, dividend, divisor, quotient, remainder);
        end else begin
            $display("Test %0d: FAIL - Dividend: %0d, Divisor: %0d, Expected Quotient: %0d, Actual Quotient: %0d, Expected Remainder: %0d, Actual Remainder: %0d",
                     i, dividend, divisor, ref_quotient, quotient, ref_remainder, remainder);
        end

        // Prepare for next test
        @(posedge clk);
        end
    endtask



    initial begin
        //random();
        //random();


        // Initialize signals
        clk = 0;
        rst = 0;
        src_valid = 0;
        dd_ready = 0;
        dividend = 32'd0;
        divisor = 32'd0;
        @(posedge clk);

        // Apply reset
        rst = 1;
        @(posedge clk);
        rst = 0;
        @(posedge clk);

        // Testcase 1: 100 divided by 3
        dividend = 32'd11;
        divisor = 32'd3;
        src_valid = 1;
        dd_ready = 1;

        // Wait for src_ready signal
        wait(src_ready);
        @(posedge clk);
        src_valid = 0;

        // Wait for dd_valid signal indicating completion
        wait(dd_valid);

        // Check results
        //$display("Testcase 1: 100 / 3");
        $display("Quotient: %0d, Expected: 3", quotient);
        $display("Remainder: %0d, Expected: 2", remainder);

        // Finish simulation
        @(posedge clk);
        
        $finish;
    end

    initial 
    begin
        $dumpfile("division.vcd");
        $dumpvars(0, dut);
    end

endmodule
