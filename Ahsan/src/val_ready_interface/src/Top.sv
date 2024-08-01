
module Seq_Mul_top(Multiplicand,Multiplier,clk,rst,src_val,src_ready,dest_val,dest_ready,Product);
input logic [15:0] Multiplicand,Multiplier;
input logic clk,rst,src_val,dest_ready;
output logic src_ready,dest_val;
output logic [31:0] Product;

//
logic mux_sel_Mul,clear,count_comp,pro_en;
logic [1:0] Qo_Q1;
logic [1:0] mux_sel_Shift;

Datapath DP(.Multiplicand(Multiplicand),
            .Multiplier(Multiplier),
            .clk(clk),
            .rst(rst),
            .Product(Product),
            .Qo_Q1(Qo_Q1),
            .mux_sel_Mul(mux_sel_Mul),
            .mux_sel_Shift(mux_sel_Shift),
            .clear(clear),
            .count_comp(count_comp),
            .pro_en(pro_en));

controller   CU(.clk(clk),
                .rst(rst),
                .src_ready(src_ready),
                .src_val(src_val),
                .dest_ready(dest_ready),
                .dest_val(dest_val),
                .pro_en(pro_en),
                .clear(clear),
                .count_comp(count_comp),
                .Qo_Q1(Qo_Q1),
                .mux_sel_Mul(mux_sel_Mul),
                .mux_sel_Shift(mux_sel_Shift));


endmodule