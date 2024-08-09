module tb_flip_flop();

    // Testbench signals
    logic d;
    logic clk;
    logic reset;
    logic q1, q2, q3;

    // Instantiate the flip_flop module
    flip_flop UUT (
        .d(d),
        .clk(clk),
        .reset(reset),
        .q1(q1),
        .q2(q2),
        .q3(q3)
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; 
    end

    // Test sequence
    initial begin
        reset = 1;
        @(posedge clk);
        #10; // Wait for some time (10 time units)

        // Deassert reset and start the test
        reset = 0;
        // Apply input stimulus
        d = 1;
        reset = 0;
        @(posedge clk) d = 1;
        repeat(2) @(posedge clk) d = 0;
        repeat(2) @(posedge clk) d = 1;
        repeat(2) @(posedge clk) d = 0;
        
        // End simulation
        $stop;
    end

endmodule
