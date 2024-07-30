`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/29/2024 12:33:01 PM
// Design Name: 
// Module Name: Sequential_Multiplier
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

module Mux2x1 #(parameter number_of_bits=16)(
    input logic sel,
    input logic [number_of_bits-1:0] data0,
    input logic [number_of_bits-1:0] data1,
    output logic [number_of_bits-1:0]out
);
    always_comb begin
        out = sel ? data1 : data0;
    end
endmodule

module Shift_Register #(parameter number_of_bits=32)(
    input logic [4:0]shift_amount,
    input logic [number_of_bits-1:0] input_value,
    output logic [number_of_bits-1:0]output_value
);
    assign output_value=input_value<<shift_amount;
endmodule

module Summer #(parameter number_of_bits=32)(
    input logic clk,reset,Summer_enable,End_of_Transmission,
    input logic [number_of_bits-1:0] input_value,
    output logic [number_of_bits-1:0]output_value
);
    logic [31:0]Sum;
    always_ff @ (posedge clk or negedge reset)
        begin
        //reset is active low
        if ((!reset)|End_of_Transmission)begin
        Sum <= 0;
        end
        else if (Summer_enable) begin
        Sum <= Sum+input_value;
        end
    end
    assign output_value=Sum;
endmodule

module Sign_Extension(input logic [15:0]input1,output logic [31:0]output1);
    assign output1={{16{input1[15]}},input1[15:0]};
endmodule
module Sequential_Multiplier(input logic clk,input logic reset,input logic start,input logic[15:0]input1,input logic input2_bit,output logic[31:0]Product);
    logic [31:0]Sign_Extended_input1;
    logic [31:0]out_MUX1;
    logic [31:0]out_MUX2;
    logic End_of_Transmission;
    logic [31:0]shifted_partial_product;
    logic [32:0] _2s_complement_33_bit;
    logic [31:0] _2s_complement;
    logic Mux_Sel1,Mux_Sel2,Summer_enable;
    logic[4:0]shift_amount;
    Sign_Extension SE(input1,Sign_Extended_input1);
    Mux2x1 #(32)mux1(Mux_Sel2,Sign_Extended_input1,32'b0,out_MUX1);
//    assign _2s_complement_33_bit=(~out_MUX1)+33'b1;
    assign _2s_complement=(~out_MUX1)+32'b1;
    
    Mux2x1 #(32)mux2(Mux_Sel1,out_MUX1,_2s_complement,out_MUX2);
    Controller CONTROLLER1(clk,reset,start,input2_bit,Mux_Sel1,Mux_Sel2,Summer_enable,End_of_Transmission,shift_amount);
    Shift_Register #(32)SR(shift_amount,out_MUX2,shifted_partial_product);
    Summer #(32)SUMMER1(clk,reset,Summer_enable,End_of_Transmission,shifted_partial_product,Product);
endmodule

module Controller(
    input logic clk,
    input logic reset,
    input logic start,
    input logic input_bit,
    output logic Mux_Sel1,Mux_Sel2,Summer_enable,End_of_Transmission,
    output logic [4:0]shift_amount);
    logic [4:0] c_state, n_state;
    parameter S0=5'd0, S1=5'd1, S2=5'd2,S3=5'd3, S4=5'd4, S5=5'd5,S6=5'd6, S7=5'd7, S8=5'd8,S9=5'd9, S10=5'd10, S11=5'd11,S12=5'd12, S13=5'd13, S14=5'd14,S15=5'd15, S16=5'd16,S17=5'd17;
    //state register
    always_ff @ (posedge clk or negedge reset)
    begin
    //reset is active low
    if (!reset)
    c_state <= S0;
    else
    c_state <= n_state;
    end
    //next_state always block
    always_comb
    begin
    case (c_state)
        S0: begin if (start) n_state = S1;
        else n_state = S0; end
        S1: n_state = S2;
        S2: n_state = S3;
        S3: n_state = S4;
        S4: n_state = S5;
        S5: n_state = S6;
        S6: n_state = S7;
        S7: n_state = S8;
        S8: n_state = S9;
        S9: n_state = S10;
        S10: n_state = S11;
        S11: n_state = S12;
        S12: n_state = S13;
        S13: n_state = S14;
        S14: n_state = S15;
        S15: n_state = S16;
        S16: n_state = S17;
        S17: n_state = S0;
        default: n_state = S0;
        endcase
    end
    //output always block
    always_comb
    begin
        case (c_state)
                S0:begin shift_amount = 0;
                    Mux_Sel1=0;
                    Mux_Sel2=1;
                    Summer_enable=0;
                    End_of_Transmission=0;
                end
            S1:begin shift_amount = 0;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S2:begin shift_amount = 1;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S3:begin shift_amount = 2;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end            
            S4:begin shift_amount = 3;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S5:begin shift_amount = 4;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S6:begin shift_amount = 5;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S7:begin shift_amount = 6;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end            
            S8:begin shift_amount = 7;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S9:begin shift_amount = 8;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S10:begin shift_amount = 9;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S11:begin shift_amount = 10;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end            
            S12:begin shift_amount = 11;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S13:begin shift_amount = 12;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S14:begin shift_amount = 13;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S15:begin shift_amount = 14;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end            
            S16:begin shift_amount = 15;
                Mux_Sel1=1;
                Summer_enable=1;
                End_of_Transmission=0;
                if (input_bit)begin
                    Mux_Sel2=0;
                end
                else begin
                    Mux_Sel2=1;
                end
            end
            S17:begin shift_amount = 0;
                Mux_Sel1=0;
                Mux_Sel2=1;
                Summer_enable=0;
                End_of_Transmission=1;
            end
            default:begin shift_amount = 0;
                Mux_Sel1=0;
                Mux_Sel2=1;
                Summer_enable=0;
                End_of_Transmission=0;
            end
        endcase
    end
endmodule

//module Half_Adder(input logic bit1,input logic bit2,output logic Sum,output logic Carry_out
//);
//    always_comb begin
//        if ((bit1&bit2)==1)begin
//            Carry_out=1;
//            Sum=0;
//        end
//        else begin
//            Carry_out=0;
//            Sum=bit1|bit2;
//        end
//    end
//endmodule
//module Full_Adder(input logic bit1,input logic bit2,input logic Carry_in,output logic Sum,output logic Carry_out
//);
//    always_comb begin
//        if (((bit1&bit2)==1)|((bit1&Carry_in)==1)|((bit2&Carry_in)==1))begin
//            Carry_out=1;
//            Sum=bit1&bit2&Carry_in;
//        end
//        else begin
//            Carry_out=0;
//            Sum=bit1|bit2|Carry_in;
//        end
//    end
//endmodule

//module _32_Bit_Adder(input logic [15:0]Value1,input logic [15:0]Value2,output logic [15:0]Sum
//);
//    logic [15:0]Carry_out;
//    Half_Adder HA0x(Value1[0],Value2[0],Sum[0],Carry_out[0]);
//    Full_Adder FA1x(Value1[1],Value2[1],Carry_out[0],Sum[1],Carry_out[1]);
//    Full_Adder FA2x(Value1[2],Value2[2],Carry_out[1],Sum[2],Carry_out[2]);
//    Full_Adder FA3x(Value1[3],Value2[3],Carry_out[2],Sum[3],Carry_out[3]);
//    Full_Adder FA4x(Value1[4],Value2[4],Carry_out[3],Sum[4],Carry_out[4]);
//    Full_Adder FA5x(Value1[5],Value2[5],Carry_out[4],Sum[5],Carry_out[5]);
//    Full_Adder FA6x(Value1[6],Value2[6],Carry_out[5],Sum[6],Carry_out[6]);
//    Full_Adder FA7x(Value1[7],Value2[7],Carry_out[6],Sum[7],Carry_out[7]);
//    Full_Adder FA8x(Value1[8],Value2[8],Carry_out[7],Sum[8],Carry_out[8]);
//    Full_Adder FA9x(Value1[9],Value2[9],Carry_out[8],Sum[9],Carry_out[9]);
//    Full_Adder FA10x(Value1[10],Value2[10],Carry_out[9],Sum[10],Carry_out[10]);
//    Full_Adder FA11x(Value1[11],Value2[11],Carry_out[10],Sum[11],Carry_out[11]);
//    Full_Adder FA12x(Value1[12],Value2[12],Carry_out[11],Sum[12],Carry_out[12]);
//    Full_Adder FA13x(Value1[13],Value2[13],Carry_out[12],Sum[13],Carry_out[13]);
//    Full_Adder FA14x(Value1[14],Value2[14],Carry_out[13],Sum[14],Carry_out[14]);
//    Full_Adder FA15x(Value1[15],Value2[15],Carry_out[14],Sum[15],Carry_out[15]);

//endmodule