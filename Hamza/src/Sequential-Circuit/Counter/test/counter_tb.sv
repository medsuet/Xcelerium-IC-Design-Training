/* verilator lint_off NULLPORT */

module counter_tb(
    `ifdef VERILATOR
    input logic clk,
    `endif
);

    `ifndef VERILATOR
    logic clk;
    `endif
    logic reset;
    logic [3:0] count;

    // Instantiate the counter_4bit module
    counter uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    `ifndef VERILATOR
    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;  // Clock period of 5 time units
    end
    `endif
    
    task apply_reset;
        reset = 1; // Assert reset
        repeat(10) @(posedge clk);
        reset = 0; // Deassert reset
    endtask

    // Test sequence
    initial begin
        // Initialize signals
        apply_reset;

        // Wait for a few clock cycles and observe count value
        @(posedge clk);

        // Apply a few clock cycles
        $display("Starting clock cycles...");
        repeat (20) @(posedge clk); // Run for 20 clock cycles

        // Run for a few more clock cycles and observe count value
        repeat(4) @(posedge clk);

        // End simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0t, reset = %b, count = %b", $time, reset, count);
    end

    initial begin
        // Create VCD file
        $dumpfile("counter_tb.vcd"); // Output file name
        $dumpvars(0, counter_tb);    // Dump all signals in the testbench
    end

endmodule

/* verilator lint_on NULLPORT */