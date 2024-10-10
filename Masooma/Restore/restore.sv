`include "restore_dp.sv"
`include "restore_ctrl.sv"
module restore(input logic clk, input logic rst, input logic [31:0] dd, input logic [31:0] ds, input logic src_valid, dest_ready
, output logic [31:0] quo, output logic [31:0] rem, output logic src_ready, output logic dest_valid);
logic [31:0] A_shift_opr;
logic en_A, en_dd, en_ct, A_sel, dd_sel, MSB_set, clear;


restore_dp datapath(.clk(clk), .rst(rst), .dd(dd),.ds(ds),.quo(quo),.rem(rem),
.A_sel(A_sel), .dd_sel(dd_sel), .en_A(en_A), .en_dd(en_dd), .en_ds(en_ds), .MSB_set(MSB_set),
.en_ct(en_ct), .clear(clear),.A_shift_opr(A_shift_opr));



restore_ctrl controller(.clk(clk), .rst(rst), .clear(clear), .A_shift_opr(A_shift_opr), .src_valid(src_valid), 
.dest_ready(dest_ready), .src_ready(src_ready), .dest_valid(dest_valid),
.en_A(en_A), .en_dd(en_dd), .en_ds(en_ds), .en_ct(en_ct), .A_sel(A_sel), .dd_sel(dd_sel), .MSB_set(MSB_set));
initial begin
    $dumpfile("restore.vcd");
    $dumpvars(0,restore);
end
endmodule