localparam WIDTH = 16;

module seq_multiplier_tb (
    input logic clk, n_rst,
    input logic [WIDTH-1:0] multiplier,
    input logic [WIDTH-1:0] multiplicand,
    input logic start,

    output logic ready,
    output logic [2*WIDTH-1:0] product
);

sequential_multiplier UUT (
    .A(multiplier), .B(multiplicand),
    .START(start), .CLK(clk), .RST(n_rst), .PRODUCT(product),
    .READYO(ready)
    );

//initial begin
//    $dumpfile("sequential_multiplier.vcd");
//    $dumpvars(0, seq_multiplier_tb);
//end

endmodule