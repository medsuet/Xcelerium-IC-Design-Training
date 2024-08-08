module tb;
    logic clk, rst, src_valid, src_ready, dest_valid, dest_ready;
    logic signed [15:0] multiplicand, multiplier;
    logic signed [31:0] product, exp_product;

    sequential_multiplier dut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .clk(clk),
        .rst(rst),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_valid(dest_valid),
        .dest_ready(dest_ready),
        .product(product)
    );
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end

endmodule

