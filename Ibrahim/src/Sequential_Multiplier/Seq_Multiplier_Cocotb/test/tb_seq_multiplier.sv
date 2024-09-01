module tb_seq_multiplier #(
    parameter WIDTH = 16  // Parameter for width of input and output signals
);

    // Inputs
    logic clk;
    logic rst;
    logic start;
    logic signed [WIDTH-1:0] Multiplicand;
    logic signed [WIDTH-1:0] Multiplier;

    // Reference model output
    logic signed [(2*WIDTH)-1:0] exp;

    // Outputs
    logic ready;
    logic signed [(2*WIDTH)-1:0] Product;

    // Instantiate the Unit Under Test (UUT)
    seq_multiplier uut (
        .multiplicand(Multiplicand),
        .multiplier(Multiplier),
        .clk(clk),
        .rst_n(rst),
        .start(start),
        .ready(ready),
        .product(Product)
    );

    initial begin
        $dumpfile("multiplier_tb.vcd");
        $dumpvars;
    end

endmodule

