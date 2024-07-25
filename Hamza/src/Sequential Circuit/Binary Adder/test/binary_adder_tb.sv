module binary_adder_tb;

    // Declare testbench signals
    logic clk;
    logic reset;
    logic increment;
    logic [3:0] counts;

    // Instantiate the binary_adder module
    binary_adder uut (
        .clk(clk),
        .reset(reset),
        .increment(increment),
        .count(counts)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // 10 ns clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        increment = 0;
        reset = 0;

        // Apply reset
        reset = 1;
        #10;
        reset = 0;
        #10;

        // Check result for initial value 6
        increment = 1;
        #10;
        increment = 0;
        #10;

        #10;
        counts = 4'b0111;

        // Apply reset again
        #10;
        reset = 1;
        #10;
        reset = 0;
        #10;


        increment = 1;
        #10;
        increment = 0;
        #10;

        #10;
        counts = 4'b1111;

        // End simulation
        #10;
        $finish;
    end

endmodule
