module cocotb();

    reg clk;
    reg reset;
    reg signed [width-1:0] multiplier, multiplicand;
    reg valid_src, dst_ready;
    wire signed [result_width-1:0] product;
    wire src_ready, dst_valid;

    array_multiplier DUT (
        .clk(clk), .reset(reset),
        .multiplicand(multiplicand), .multiplier(multiplier),
        .valid_src(valid_src), .dst_ready(dst_ready),
        .product(product),
        .src_ready(src_ready), .dst_valid(dst_valid)
    );

initial begin
        // Open a VCD file to write the simulation results
        $dumpfile("array_multiplier.vcd");
        $dumpvars(0,cocotb); // Dump all variables in the array_multiplier_tb module
    end


endmodule