module data_path(input logic [15:0]A,B,input logic clk,reset,start,enA,enB,
                 src_valid,output logic [31:0]out,output logic cmp);
logic BS_out;
logic [31:0]rs;
logic [4:0] count_out;
logic [31:0] regA_out,regB_out;
logic [31:0] extA_out,extB_out,M1_out,regA_out,regB_out,muxx_out,M3_out,M2_out, M4_out;

Extender       extA(A,extA_out);
mux21          M1(regA_out<<1,extA_out,src_valid,M1_out);
register32     regA(clk,reset,M1_out,enA,regA_out);
mux21          muxx(32'b0,regA_out,BS_out,muxx_out);
mux21          M3(muxx_out,-muxx_out,cmp,M3_out);
mux21          M4(32'b0,M3_out,src_valid,M4_out);
register32     regproduct(clk,reset,out+M4_out,1'b1,out); 

 
mux21         M2(regB_out>>1,B,src_valid,M2_out);   
register32    regB(clk,reset,M2_out,enB,regB_out);
bitsel        BS(regBB_out,BS_out);
counter       count(clk,reset,count_out);

assign cmp = (count_out == 4'd15) ? 1:0;

endmodule