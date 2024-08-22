`timescale 1ns / 1ps
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

module _32_Bit_Adder(input logic [31:0]Value1,input logic [31:0]Value2,output logic [31:0]Sum
);
    logic [31:0]Carry_out;
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
endmodule

module Signed_Multiplier(input logic [15:0]a,input logic [15:0]b,output logic [31:0]Product
);
    logic [31:0]Sum[15:0];
    logic [31:0]Rows[15:0];
    genvar i,j,k,l,m,p,z;
    generate
        for (l=0;l<32;l++)begin
            assign Rows[l]=31'b0;
            assign Sum[l]=31'b0;
        end
        for (i=0;i<16;i++)begin
            for (j=0;j<16;j++)begin
                assign Rows[i][j+i]=a[j]&b[i];
            end
            for (k=i+16;k<32;k++)begin
                assign Rows[i][k]=a[15]&b[i];
            end
        end
        for (p=0;p<32;p++)begin
            assign Rows[15][p]=~Rows[15][p];
        end
        for (m=0;m<15;m++)begin
            if(m==0)begin
                assign Sum[0]=Rows[0];
            end
            _32_Bit_Adder x(Rows[m+1],Sum[m],Sum[m+1]);
//            assign Sum[m+1]=Sum[m]+Rows[m+1];
        end
        _32_Bit_Adder x(Sum[15][31:0],1,Product);
//        assign Product=Sum[15][31:0]+1;
    endgenerate
endmodule
