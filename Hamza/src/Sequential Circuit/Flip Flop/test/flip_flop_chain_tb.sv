module tb_flip_flop_chain;

    // Testbench signals
    logic clk;
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

    // Clock generation
    initial begin
        clk = 0; // Initialize clock to 0
        forever #10 clk = ~clk; // Toggle clock every 5 time units
    end

    task apply_reset;
        reset = 1; // Assert reset
        #50;       // Hold reset for 10 time units
        reset = 0; // Deassert reset
    endtask

    // Test sequence with input D changes on clock edges
    initial begin
        D = 0; // Initialize D to 0
        // Apply reset using the task
        apply_reset;

        @(posedge clk);

        @(posedge clk);
        D = #1 1; 

        @(posedge clk);
        @(posedge clk);
        D = #1 0; 

        @(posedge clk);
        @(posedge clk);
        D = #1 1; 

        // End simulation after a few more clock cycles
        repeat (5) @(posedge clk);
        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0t, clk = %b, reset = %b, D = %b, A = %b", $time, clk, reset, D, A);
    end

endmodule
