module restoring_division(input logic clk,reset,enQ,enM,M1_sel,M2sel,input logic [32:0]Q,M,output logic out,cmp);
logic [31:0] RegQ_out,RegA_out,RegM_out;MA,MQ
mux32       M1(A,MA,M1_sel);
register32  RegQ(clk,reset,Q,enQ,RegQ_out);
register32  RegA(clk,reset,A,1'b1,RegA_out);
register32  RegM(clk,reset,M,enM,RegM_out);
SL          shift_left(clk,RegA_out,RegQ_out,MA,MQ);

endmodule