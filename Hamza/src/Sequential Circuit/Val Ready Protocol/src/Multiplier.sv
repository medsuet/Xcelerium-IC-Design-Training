module Multiplier(
    input logic [15:0] Multiplicand,Multiplier,
    input logic clk,rst, src_valid, dest_ready,
    output logic [31:0] Product,
    output logic  dest_valid,   
    output logic  src_ready
);

logic QR_sel,clear,count_comp;
logic [1:0] in;
logic [1:0] data_sel;

Datapath DP(.Multiplicand(Multiplicand),
            .Multiplier(Multiplier),
            .clk(clk),
            .rst(rst),
            .Product(Product),
            .in(in),
            .QR_sel(QR_sel),
            .data_sel(data_sel),
            .clear(clear),
            .count_comp(count_comp));

Controller   CTRL(.clk(clk),
                .rst(rst),
                .clear(clear),
                .count_comp(count_comp),
                .in(in),
                .QR_sel(QR_sel),
                .src_ready(src_ready),
                .dest_valid(dest_valid),
                .src_valid(src_valid),
                .dest_ready(dest_ready),  
                .data_sel(data_sel));


endmodule