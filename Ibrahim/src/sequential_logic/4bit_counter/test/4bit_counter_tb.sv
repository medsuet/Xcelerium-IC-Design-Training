/* verilator lint_off NULLPORT */

module counter_tb(
    `ifdef VERILATOR
    input logic clk
    `endif
);
    parameter WIDTH_C = 4;  // Testbench parameter for the counter width
    parameter MAX_COUNT = 13;

    `ifndef VERILATOR
    logic clk;
    `endif
    logic reset;
    logic [WIDTH_C-1:0] reg_out;

    // Instantiate the reg_outer with the testbench parameter
    counter #(
        .WIDTH_C(WIDTH_C),
        .MAX_COUNT(MAX_COUNT)
    ) uut (
        .clk(clk),
        .reset(reset),
        .reg_out(reg_out)
    );

    `ifndef VERILATOR
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    `endif

    // Task to assert and de-assert reset
    task assert_reset;
        begin
            @(posedge clk);
            reset = 1;
            @(posedge clk);
            reset = 0;
        end
    endtask

    // Test sequence
    initial begin
        // Initialization
        reset = 0;
        // Call the reset task
        assert_reset;

        // Run the reg_outer for some more time
        repeat(15) @(posedge clk);

        // Call the reset task again
        assert_reset;
        
        // Again run the reg_outer for 15 cycles to see if it gets 0 after reg_out is 13
        repeat(15) @(posedge clk);
        
        // Finish simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $display("Time\tReset\treg_out");
        $monitor("%0t\t%b\t%0d", $time, reset, reg_out);
    end

    // Generate waveform dump for visualization
    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0);
    end

endmodule

/* verilator lint_on NULLPORT */
