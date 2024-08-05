module data_path(input logic [15:0]A,B,input logic clk,reset,start,enA,enB,enAA,enBB,
                 M1_sel,M2_sel,M3_sel,enP,output logic [31:0]out,output logic cmp);
logic BS_out;
logic [31:0]rs;
logic [4:0] count_out;
logic [15:0] regA_out,regB_out;
logic [31:0] extA_out,extB_out,M1_out,regAA_out,regBB_out,muxx_out,M3_out,M2_out, M4_out;
register16     regA(clk,reset,A,enA,regA_out);
Extender       extA(regA_out,extA_out);
mux21            M1(regAA_out<<1,extA_out,M1_sel,M1_out);
register32     regAA(clk,reset,M1_out,enAA,regAA_out);
mux21            muxx(32'b0,regAA_out,BS_out,muxx_out);
mux21            M3(muxx_out,-muxx_out,M3_sel,M3_out);
mux21            M4(M3_out,32'b0,start,M4_out);
register32     regproduct(clk,reset,out+M4_out,enP,out); 

register16    regB(clk,reset,B,enB,regB_out);
Extender      extB(regB_out,extB_out); 

mux21         M2(regBB_out>>1,extB_out,M2_sel,M2_out);   
register32    regBB(clk,reset,M2_out,enBB,regBB_out);
bitsel        BS(regBB_out,BS_out);
counter       count(clk,reset,count_out);

assign cmp = (count_out == 4'd15) ? 1:0;
assign End = (count_out==4'd1 && M4_out==out) ? 1:0;
endmodule