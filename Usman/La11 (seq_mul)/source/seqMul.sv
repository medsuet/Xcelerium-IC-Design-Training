module seqMul(input logic [15:0]A, B,input logic clk,reset,start, output logic ready, output logic [31:0] out);
logic enA,anAA,enBB,M1_sel,M3_sel,enP,cmp,rst,End;
//logic[31:0] A1,B1; 
//A1 = (A<0) ? -A:A;
//B1 = (B<0) ? -A:A;

data_path  DP(A,B,clk,reset,start,enA,enB,enAA,enBB,M1_sel,M2_sel,M3_sel,enP,out,cmp,End);
controller Cntrl(clk,reset,start,cmp,rst,enA, enB, enAA, enBB,M1_sel,M2_sel,M3_sel,enP,ready);

endmodule