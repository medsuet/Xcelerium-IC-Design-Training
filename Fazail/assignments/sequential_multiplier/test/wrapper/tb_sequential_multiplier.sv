module tb_sequential_multiplier (

    input logic signed [WIDTH-1:0] multiplier,
    input logic signed [WIDTH-1:0] multiplicand,

    input logic start,

    input logic clk,
    input logic n_rst,

    output logic ready,
    output logic signed [2*WIDTH-1:0] product
     
);

localparam WIDTH = 16;

sequential_multiplier dut (
    .multiplier (multiplier), .multiplicand(multiplicand),
    .start(start), .clk(clk), .n_rst(n_rst), .product(product),
    .ready(ready)
    ); 

initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
end

endmodule