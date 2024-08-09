module multiplier_tb #(
    parameter WIDTH = 16  // Parameter for width of input and output signals
);

    // Inputs
    logic clk;
    logic rst;
    logic start;
    logic signed [WIDTH-1:0] Multiplicand, m_in;
    logic signed [WIDTH-1:0] Multiplier, m_in2;

    // Reference model output
    logic signed [(2*WIDTH)-1:0] exp;

    // Outputs
    logic ready;
    logic signed [(2*WIDTH)-1:0] Product;

    // Instantiate the Unit Under Test (UUT)
    Multiplier uut (
        .Multiplicand(Multiplicand),
        .Multiplier(Multiplier),
        .clk(clk),
        .rst(rst),
        .start(start),
        .ready(ready),
        .Product(Product)
    );

    // Dump file for waveform
    initial begin
        $dumpfile("multiplier_tb.vcd");
        $dumpvars(0, multiplier_tb);
    end

endmodule

