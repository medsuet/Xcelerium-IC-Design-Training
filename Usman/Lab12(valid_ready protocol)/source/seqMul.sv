module seqMul(input logic [15:0]A, B,input logic clk,reset,src_valid,dst_ready, output logic src_ready,dst_valid, output logic [31:0] out);
logic enA,enB,cmp,rst,M4_sel;


data_path  DP(A,B,clk,reset,enA,enB,M4_sel,src_ready,out,cmp);
controller Cntrl(clk,reset,src_valid,dst_ready,cmp,rst,enA, enB,M4_sel,src_ready,dst_valid);

endmodule
