`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2024 10:47:23 AM
// Design Name: 
// Module Name: Signed_Multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Half_Adder(input logic bit1,input logic bit2,output logic Sum,output logic Carry_out
);
    always_comb begin
        if ((bit1&bit2)==1)begin
            Carry_out=1;
            Sum=0;
        end
        else begin
            Carry_out=0;
            Sum=bit1|bit2;
        end
    end
endmodule
module Full_Adder(input logic bit1,input logic bit2,input logic Carry_in,output logic Sum,output logic Carry_out
);
    always_comb begin
        if (((bit1&bit2)==1)|((bit1&Carry_in)==1)|((bit2&Carry_in)==1))begin
            Carry_out=1;
            Sum=bit1&bit2&Carry_in;
        end
        else begin
            Carry_out=0;
            Sum=bit1|bit2|Carry_in;
        end
    end
endmodule

module _32_Bit_Adder(input logic [31:0]Value1,input logic [31:0]Value2,output logic [32:0]Sum
);
    logic [32:0]Carry_out;
    Half_Adder HA0x(Value1[0],Value2[0],Sum[0],Carry_out[0]);
    Full_Adder FA1x(Value1[1],Value2[1],Carry_out[0],Sum[1],Carry_out[1]);
    Full_Adder FA2x(Value1[2],Value2[2],Carry_out[1],Sum[2],Carry_out[2]);
    Full_Adder FA3x(Value1[3],Value2[3],Carry_out[2],Sum[3],Carry_out[3]);
    Full_Adder FA4x(Value1[4],Value2[4],Carry_out[3],Sum[4],Carry_out[4]);
    Full_Adder FA5x(Value1[5],Value2[5],Carry_out[4],Sum[5],Carry_out[5]);
    Full_Adder FA6x(Value1[6],Value2[6],Carry_out[5],Sum[6],Carry_out[6]);
    Full_Adder FA7x(Value1[7],Value2[7],Carry_out[6],Sum[7],Carry_out[7]);
    Full_Adder FA8x(Value1[8],Value2[8],Carry_out[7],Sum[8],Carry_out[8]);
    Full_Adder FA9x(Value1[9],Value2[9],Carry_out[8],Sum[9],Carry_out[9]);
    Full_Adder FA10x(Value1[10],Value2[10],Carry_out[9],Sum[10],Carry_out[10]);
    Full_Adder FA11x(Value1[11],Value2[11],Carry_out[10],Sum[11],Carry_out[11]);
    Full_Adder FA12x(Value1[12],Value2[12],Carry_out[11],Sum[12],Carry_out[12]);
    Full_Adder FA13x(Value1[13],Value2[13],Carry_out[12],Sum[13],Carry_out[13]);
    Full_Adder FA14x(Value1[14],Value2[14],Carry_out[13],Sum[14],Carry_out[14]);
    Full_Adder FA15x(Value1[15],Value2[15],Carry_out[14],Sum[15],Carry_out[15]);

    Full_Adder FA16x(Value1[16],Value2[16],Carry_out[15],Sum[16],Carry_out[16]);
    Full_Adder FA17x(Value1[17],Value2[17],Carry_out[16],Sum[17],Carry_out[17]);
    Full_Adder FA18x(Value1[18],Value2[18],Carry_out[17],Sum[18],Carry_out[18]);
    Full_Adder FA19x(Value1[19],Value2[19],Carry_out[18],Sum[19],Carry_out[19]);
    Full_Adder FA20x(Value1[20],Value2[20],Carry_out[19],Sum[20],Carry_out[20]);
    Full_Adder FA21x(Value1[21],Value2[21],Carry_out[20],Sum[21],Carry_out[21]);
    Full_Adder FA22x(Value1[22],Value2[22],Carry_out[21],Sum[22],Carry_out[22]);
    Full_Adder FA23x(Value1[23],Value2[23],Carry_out[22],Sum[23],Carry_out[23]);
    Full_Adder FA24x(Value1[24],Value2[24],Carry_out[23],Sum[24],Carry_out[24]);
    Full_Adder FA25x(Value1[25],Value2[25],Carry_out[24],Sum[25],Carry_out[25]);
    Full_Adder FA26x(Value1[26],Value2[26],Carry_out[25],Sum[26],Carry_out[26]);
    Full_Adder FA27x(Value1[27],Value2[27],Carry_out[26],Sum[27],Carry_out[27]);
    Full_Adder FA28x(Value1[28],Value2[28],Carry_out[27],Sum[28],Carry_out[28]);
    Full_Adder FA29x(Value1[29],Value2[29],Carry_out[28],Sum[29],Carry_out[29]);
    Full_Adder FA30x(Value1[30],Value2[30],Carry_out[29],Sum[30],Carry_out[30]);
    Full_Adder FA31x(Value1[31],Value2[31],Carry_out[30],Sum[31],Carry_out[31]);
    assign Sum[16]=Carry_out[15];
endmodule


module Signed_Multiplier(input logic [15:0]a,input logic [15:0]b,output logic [31:0]Product
);
    logic [15:0]Sum[32:0];
    logic [15:0]Rows[31:0];
    genvar i,j;
    generate
        for (i=0;i<16;i++)begin
            assign Rows[i]=31'b0;
        end
        for (i=0;i<16;i++)begin
            assign Rows[0][i]=(a[i]&b[0]);
        end
        for (j=16;j<32;j++)begin
            assign Rows[0][j]=(a[15]&b[0]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[1][i+1]=(a[i]&b[1]);
        end
        for (j=16;j<31;j++)begin
            assign Rows[1][j+1]=(a[15]&b[1]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[2][i+2]=(a[i]&b[2]);
        end
        for (j=16;j<30;j++)begin
            assign Rows[2][j+2]=(a[15]&b[2]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[3][i+3]=(a[i]&b[3]);
        end
        for (j=16;j<29;j++)begin
            assign Rows[3][j+3]=(a[15]&b[3]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[4][i+4]=(a[i]&b[4]);
        end
        for (j=16;j<28;j++)begin
            assign Rows[4][j+4]=(a[15]&b[4]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[5][i+5]=(a[i]&b[5]);
        end
        for (j=16;j<27;j++)begin
            assign Rows[5][j+5]=(a[15]&b[5]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[6][i+6]=(a[i]&b[6]);
        end
        for (j=16;j<26;j++)begin
            assign Rows[6][j+6]=(a[15]&b[6]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[7][i+7]=(a[i]&b[7]);
        end
        for (j=16;j<25;j++)begin
            assign Rows[7][j+7]=(a[15]&b[7]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[8][i+8]=(a[i]&b[8]);
        end
        for (j=16;j<24;j++)begin
            assign Rows[8][j+8]=(a[15]&b[8]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[9][i+9]=(a[i]&b[9]);
        end
        for (j=16;j<23;j++)begin
            assign Rows[9][j+9]=(a[15]&b[9]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[10][i+10]=(a[i]&b[10]);
        end
        for (j=16;j<22;j++)begin
            assign Rows[10][j+10]=(a[15]&b[10]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[11][i+11]=(a[i]&b[11]);
        end
        for (j=16;j<21;j++)begin
            assign Rows[11][j+11]=(a[15]&b[11]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[12][i+12]=(a[i]&b[12]);
        end
        for (j=16;j<20;j++)begin
            assign Rows[12][j+12]=(a[15]&b[12]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[13][i+13]=(a[i]&b[13]);
        end
        for (j=16;j<19;j++)begin
            assign Rows[13][j+13]=(a[15]&b[13]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[14][i+14]=(a[i]&b[14]);
        end
        for (j=16;j<18;j++)begin
            assign Rows[14][j+14]=(a[15]&b[14]);
        end
        for (i=0;i<16;i++)begin
            assign Rows[15][i+15]=(a[i]&b[15]);
        end
        for (j=16;j<17;j++)begin
            assign Rows[15][j+15]=(a[15]&b[15]);
        end
        assign Rows[15]=~Rows[15];
        _32_Bit_Adder _32BA0(Rows[15],32'b1,Sum[15]);
        assign Rows[15]=Sum[15][31:0];
        _32_Bit_Adder _32BA1(Rows[0],Rows[1],Sum[1]);
        _32_Bit_Adder _32BA2(Rows[2],Sum[1][31:0],Sum[2]);
        _32_Bit_Adder _32BA3(Rows[3],Sum[2][31:0],Sum[3]);
        _32_Bit_Adder _32BA4(Rows[4],Sum[3][31:0],Sum[4]);
        _32_Bit_Adder _32BA5(Rows[5],Sum[4][31:0],Sum[5]);
        _32_Bit_Adder _32BA6(Rows[6],Sum[5][31:0],Sum[6]);
        _32_Bit_Adder _32BA7(Rows[7],Sum[6][31:0],Sum[7]);
        _32_Bit_Adder _32BA8(Rows[8],Sum[7][31:0],Sum[8]);
        _32_Bit_Adder _32BA9(Rows[9],Sum[8][31:0],Sum[9]);
        _32_Bit_Adder _32BA10(Rows[10],Sum[9][31:0],Sum[10]);
        _32_Bit_Adder _32BA11(Rows[11],Sum[10][31:0],Sum[11]);
        _32_Bit_Adder _32BA12(Rows[12],Sum[11][31:0],Sum[12]);
        _32_Bit_Adder _32BA13(Rows[13],Sum[12][31:0],Sum[13]);
        _32_Bit_Adder _32BA14(Rows[14],Sum[13][31:0],Sum[14]);
        _32_Bit_Adder _32BA15(Rows[15],Sum[14][31:0],Sum[15]);
        
        _32_Bit_Adder _32BA16(Rows[8],Sum[7][31:0],Sum[8]);
        assign Product=Sum[15][31:0];
    endgenerate
    
endmodule
