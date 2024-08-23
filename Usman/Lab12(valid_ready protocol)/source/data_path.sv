module data_path(input logic [15:0]A,B,input logic clk,reset,enA,enB,M4_sel,
                 src_ready,output logic [31:0]out1,output logic cmp);
logic BS_out;
logic [31:0]rs,out;
logic [4:0] count_out;
logic [15:0] regB_out,M2_out;
logic [31:0] extA_out,extB_out,M1_out,regA_out,muxx_out,M3_out, M4_out;

Extender       extA(A,extA_out);
mux21          M1(regA_out<<1,extA_out,src_ready,M1_out);
register32     regA(clk,reset,M1_out,enA,regA_out);
mux21          muxx(32'b0,regA_out,BS_out,muxx_out);
mux21          M3(muxx_out,-muxx_out,cmp,M3_out);
mux21          M4(M3_out+out,32'b0,M4_sel,M4_out);
register32     regproduct(clk,reset,M4_out,1'b1,out); 
assign out1 = M4_out;
 
mux21_16bit   M2(regB_out>>1,B,src_ready,M2_out);   
register16    regB(clk,reset,M2_out,enB,regB_out);
bitsel        BS(regB_out,BS_out);
counter       count(clk,reset,count_out);

assign cmp = (count_out == 5'd15) ? 1:0;

endmodule