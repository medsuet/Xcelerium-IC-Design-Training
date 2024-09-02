module pop_quiz_tb(
    `ifdef VERILATOR
    input logic clk
    `endif
);

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in time units

    // Testbench signals
    `ifndef VERILATOR
    logic clk;
    `endif
    logic reset;
    logic D;
    logic A;

    // Instantiate the pop_quiz module
    pop_quiz uut (
        .clk(clk),
        .reset(reset),
        .d_in(D),
        .a(A)
    );

    // Clock generation
    `ifndef VERILATOR
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk; // Clock period of 10 time units
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
        // Initialize signals
        reset = 0;
        D = 0;

        // Apply reset
        assert_reset;

        // Apply test vectors
        @(posedge clk);
        D = 1; // Set D to 1
        repeat(2)@(posedge clk);
        @(posedge clk);
        D = 0; // Set D to 0
        @(posedge clk);
        @(posedge clk);
        D = 1; // Set D to 1
        @(posedge clk);
        @(posedge clk);
        D = 0; // Set D to 0

        // Finish simulation after some time
        repeat (10) @(posedge clk);
        $finish;
    end

    // Monitor outputs
    initial begin
        $display("Time\tReset\tD\tA");
        $monitor("%0t\t%b\t%b\t%b", $time, reset, D, A);
    end

    // Generate waveform Dump for visualization
    initial begin
        $dumpfile("pop_quiz.vcd");
        $dumpvars(0);
    end

endmodule
