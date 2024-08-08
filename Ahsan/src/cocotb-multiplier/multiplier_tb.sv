
module multiplier_tb;

    // Inputs
    logic signed [15:0] Multiplicand;
    logic signed [15:0] Multiplier;
    logic clk;
    logic rst;
    logic start;

    //refernce model output
    logic signed [31:0] exp;

    // Outputs
    logic ready;
    logic signed [31:0] Product;

    // Instantiate the Unit Under Test (UUT)
    Seq_Mul_top uut (
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
        $dumpvars(0);
    end
endmodule
