module pop_quiz_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock perioD in time units

    // Testbench signals
    logic clk;
    logic reset;
    logic D;
    logic A;

    // Instantiate the pop_quiz moDule
    pop_quiz uut (
        .clk(clk),
        .reset(reset),
        .d_in(D),
        .a(A)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk; // Clock perioD of 10 time units
    end

    // Task to assert anD De-assert reset
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
        $dumpvars(0, pop_quiz_tb);
    end

endmodule
