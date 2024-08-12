/* verilator lint_off NULLPORT */

module flip_flop_chain_tb(
    `ifdef VERILATOR
    input logic clk,
    `endif
);

    // Testbench signals
    `ifndef VERILATOR
    logic clk;
    `endif
    logic reset;
    logic D;
    logic A;

    // Instantiate the flip_flop_chain module
    flip_flop_chain uut (
        .clk(clk),
        .reset(reset),
        .D(D),
        .A(A)
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
        repeat(10) @(posedge clk);  // Hold reset for 10 time units
        reset = 0; // Deassert reset
    endtask

    // Test sequence with input D changes on clock edges
    initial begin
        D = 0; // Initialize D to 0
        // Apply reset using the task
        apply_reset;

        @(posedge clk);

        @(posedge clk);
        D = 1; 

        @(posedge clk);
        @(posedge clk);
        D = 0; 

        @(posedge clk);
        @(posedge clk);
        D = 1; 

        // End simulation after a few more clock cycles
        repeat (5) @(posedge clk);
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0t, clk = %b, reset = %b, D = %b, A = %b", $time, clk, reset, D, A);
    end

    initial begin
        // Create VCD file
        $dumpfile("flip_flop_chain_tb.vcd"); // Output file name
        $dumpvars(0, flip_flop_chain_tb);    // Dump all signals in the testbench
    end

endmodule

/* verilator lint_on NULLPORT */
