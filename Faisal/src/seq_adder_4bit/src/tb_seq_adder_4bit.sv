module tb_seq_adder_4bit;
 // define inputs and outputs
    logic clk;
    logic reset;
    logic [3:0] num;
    logic out;

    // Instantiation
    seq_adder_4bit uut (
        .clk(clk),
        .reset(reset),
        .number(num),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        num = 4'b0000;

        // Apply reset
        #10 reset = 0;

        // Apply test vectors
        #5 num = 4'b1010;
        #40 num = 4'b1101;
        #40 num = 4'b0111;
        #40 num = 4'b0001;

        // Finish simulation
        #40 $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t clk=%b reset=%b num=%b out=%b", $time, clk, reset, num, out);
    end

    // Dump waveform data
    initial begin
        $dumpfile("seq_adder_4bit.vcd");
        $dumpvars(0, tb_seq_adder_4bit);
    end

endmodule
