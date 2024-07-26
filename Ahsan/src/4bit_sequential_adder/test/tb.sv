module tb_serial_adder;
    logic clk;
    logic reset;
    logic start;
    logic [3:0] A;
    logic [3:0] B;
    logic [3:0] sum;
    logic done;

    
    serial_adder uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .A(A),
        .B(B),
        .sum(sum),
        .done(done)
    );

    // Clock generation
    always #5 clk = ~clk; 

    // Test sequence
    initial begin
        $dumpfile("tb_serial_adder.vcd");
        $dumpvars(0, tb_serial_adder);

        // Initialize signals
        clk = 0;
        reset = 1;
        start = 0;
        A = 4'b0001; // Adding 1 to each value of B
        B = 4'b0000;

        // Release reset
        @(posedge clk) reset = 0;

        // Test each value of B from 0 to 15
        for (int i = 0; i < 16; i++) begin
            B = i;
            start = 1;
            @(posedge clk) start = 0; // Start the addition
            // Wait for the done signal
            wait (done == 1);
            @(posedge clk);
            $display("B = %d, Sum = %d", B, sum);

            // Check the result
            if (sum !== (B + 1)) begin
                $display("Test failed for B = %d: expected %d, got %d", B, B + 1, sum);
            end

            // Wait a bit before the next test
            repeat(2)@(posedge clk);
        end

        $display("All tests passed.");
        $finish;
    end
endmodule
