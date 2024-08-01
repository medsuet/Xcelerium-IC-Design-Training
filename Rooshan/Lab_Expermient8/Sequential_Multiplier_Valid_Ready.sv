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
module Sequential_Multiplier(input logic clk,input logic reset,input logic start,logic valid_src,logic ready_dst,input logic[15:0]input1,input logic input2_bit,output logic[31:0]Product,output logic End_of_Transmission);
    logic [31:0]Sign_Extended_input1;
    logic [31:0]out_MUX1;
    logic [31:0]out_MUX2;
    logic [31:0]shifted_partial_product;
    logic [32:0] _2s_complement_33_bit;
    logic [31:0] _2s_complement;
    logic Mux_Sel1,Mux_Sel2,Summer_enable;
    logic[4:0]shift_amount;
    logic ready_src,valid_dst;
    Sign_Extension SE(input1,Sign_Extended_input1);
    Mux2x1 #(32)mux1(Mux_Sel2,Sign_Extended_input1,32'b0,out_MUX1);
//    assign _2s_complement_33_bit=(~out_MUX1)+33'b1;
    assign _2s_complement=(~out_MUX1)+32'b1;
    
    Mux2x1 #(32)mux2(Mux_Sel1,out_MUX1,_2s_complement,out_MUX2);
    Controller CONTROLLER1(clk,reset,start,valid_src,ready_dst,input2_bit,Mux_Sel1,Mux_Sel2,Summer_enable,End_of_Transmission,shift_amount);
    Shift_Register #(32)SR(shift_amount,out_MUX2,shifted_partial_product);
    Summer #(32)SUMMER1(clk,reset,Summer_enable,End_of_Transmission,shifted_partial_product,Product);
endmodule

module Controller(
    input logic clk,
    input logic reset,
    input logic start,valid_src,ready_dst,
    input logic input_bit,
    output logic Mux_Sel1,Mux_Sel2,Summer_enable,End_of_Transmission,
    output logic [4:0]shift_amount);
    logic [4:0] c_state, n_state;
    parameter S0=5'd0, S1=5'd1, S2=5'd2,S3=5'd3, S4=5'd4, S5=5'd5,S6=5'd6, S7=5'd7, S8=5'd8,S9=5'd9, S10=5'd10, S11=5'd11,S12=5'd12, S13=5'd13, S14=5'd14,S15=5'd15, S16=5'd16,S17=5'd17;
    logic ready_src,valid_dst;
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
        S0: begin if (start && valid_src && ready_src) n_state = S1;
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
        S17: begin if (End_of_Transmission) n_state = S0;
        else n_state = S17;end
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
                valid_dst=0;
                End_of_Transmission=0;
                ready_src=1;          //##################
            end
            S1:begin shift_amount = 0;
                Mux_Sel1=0;
                Summer_enable=1;
                End_of_Transmission=0;
                valid_dst=0;
                ready_src=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=0;
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
                ready_src=0;
                valid_dst=1;
                if (valid_dst&&ready_dst)begin
                    End_of_Transmission=1;
                end
                else begin
                    End_of_Transmission=0;
                end
                
            end
            default:begin shift_amount = 0;
                Mux_Sel1=0;
                Mux_Sel2=1;
                Summer_enable=0;
                End_of_Transmission=0;
                ready_src=0;
            end
        endcase
    end
endmodule