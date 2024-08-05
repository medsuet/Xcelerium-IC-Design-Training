module seqMul(input logic [15:0]A, B,input logic clk,reset,start,src_valid,dst_ready, output logic src_ready,dst_valid, output logic [31:0] out);
logic enA,anAA,enBB,M1_sel,M3_sel,enP,cmp,rst;


data_path  DP(A,B,clk,reset,start,enA,enB,enAA,enBB,M1_sel,M2_sel,M3_sel,enP,out,cmp);
controller Cntrl(clk,reset,start,src_valid,dst_ready,cmp,rst,enA, enB, enAA, enBB,M1_sel,M2_sel,M3_sel,enP,src_ready,dst_valid);

endmodule