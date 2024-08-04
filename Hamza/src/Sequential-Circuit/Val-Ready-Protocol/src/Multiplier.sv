module Multiplier #(
    parameter WIDTH = 16  // Default width parameter for inputs and outputs
)(
    input logic [WIDTH-1:0] Multiplicand, Multiplier, // Operands
    input logic clk, rst, src_valid, dest_ready,
    output logic [(2*WIDTH)-1:0] Product, // Output product based on width
    output logic dest_valid,   
    output logic src_ready
);

logic QR_sel, clear, count_comp;
logic [1:0] in;
logic [1:0] data_sel;

// Instantiate Datapath with parameter WIDTH
Datapath DP (
    .Multiplicand(Multiplicand),
    .Multiplier(Multiplier),
    .clk(clk),
    .rst(rst),
    .Product(Product),
    .in(in),
    .QR_sel(QR_sel),
    .data_sel(data_sel),
    .clear(clear),
    .count_comp(count_comp)
);

// Instantiate Controller, assuming no width dependence
Controller CTRL (
    .clk(clk),
    .rst(rst),
    .clear(clear),
    .count_comp(count_comp),
    .in(in),
    .QR_sel(QR_sel),
    .src_ready(src_ready),
    .dest_valid(dest_valid),
    .src_valid(src_valid),
    .dest_ready(dest_ready),  
    .data_sel(data_sel)
);

endmodule
