module seq_multiplier(
    input logic [15:0] Multiplicand,Multiplier,
    input logic clk,rst,start,
    output logic ready,
    output logic [31:0] Product
);

logic QR_sel; // 2x1_mux for multiplier selector (initialized or updated)
logic clear; // 1 bit for clearing 
logic count_comp; // check the counter reach its limit 16 or not
logic [1:0] in;       // 2 bits for Qn and Qn+1 (00-->notthing,01--->add,10--->sub,11--->nothing)
logic [1:0] data_sel; // 4x1_mux for data selection 

Datapath datapath_ins(.Multiplicand(Multiplicand),
            .Multiplier(Multiplier),
            .clk(clk),
            .rst(rst),
            .Product(Product),
            .in(in),
            .QR_sel(QR_sel),
            .data_sel(data_sel),
            .clear(clear),
            .count_comp(count_comp));

Controller controller_ins(.clk(clk),
                .rst(rst),
                .ready(ready),
                .start(start),
                .clear(clear),
                .count_comp(count_comp),
                .in(in),
                .QR_sel(QR_sel),
                .data_sel(data_sel));


endmodule