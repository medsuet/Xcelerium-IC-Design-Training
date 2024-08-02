module top_multiplier (
    input wire clk,   
    input wire rst,   
    input wire start, 
    input wire [15:0] A,
    input wire [15:0] B,
    output wire [31:0] product, 
    output wire done 
);

    wire load, calc;
    wire dp_done;

    datapath dp (
        .clk(clk),
        .rst(rst),
        .load(load),
        .calc(calc),
        .A(A),
        .B(B),
        .product(product),
        .done(dp_done)
    );

    control_unit cu (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(dp_done),
        .load(load),
        .calc(calc)
    );

    assign done = dp_done;

endmodule