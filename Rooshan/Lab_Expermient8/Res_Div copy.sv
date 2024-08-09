`timescale 1ns / 1ps
module Mux2x1 #(parameter number_of_bits=32)(
    input logic sel,
    input logic [number_of_bits-1:0] data0,
    input logic [number_of_bits-1:0] data1,
    output logic [number_of_bits-1:0] out
);
    always_comb begin
        out = sel ? data1 : data0;
    end
endmodule

module Left_Shift_AQ #(parameter number_of_bits=31)(
    input logic clk,shift_enable,
    input logic [number_of_bits-1:0] A,
    output logic [number_of_bits-1:0]shifted_A,
    input logic [number_of_bits-2:0] Q,
    output logic [number_of_bits-2:0]shifted_Q
);
    always_ff @ (posedge clk) begin
        if(shift_enable)begin
            shifted_A = A << 1;
            shifted_A=shifted_A|{{(number_of_bits-1-1){1'b0}},{Q[number_of_bits-1-1]}};    
            shifted_Q = Q << 1;
        end
    end
endmodule

module Res_Div #(parameter number_of_bits=32)(input logic clk,input logic reset,logic valid_src,logic ready_dst,input logic [6:0]N,input logic[number_of_bits-2:0]Q_initial,input logic [number_of_bits-1:0]M,output logic [number_of_bits-1:0]Remainder,output logic [number_of_bits-2:0]Quotient,output logic ready_src,output logic valid_dst);
    logic Mux_Sel1,Mux_Sel2,Mux_Sel3;
    logic shift_enable;
    logic [number_of_bits-1:0]MUX1_OUT_A,shifted_A,Diff_A_M,MUX3_OUT_A;
    logic [number_of_bits-2:0]MUX2_OUT_Q,shifted_Q,Q_final;
    logic [6:0]count;
    Mux2x1 #(number_of_bits) MUX1(Mux_Sel1,0,MUX3_OUT_A,MUX1_OUT_A);
    Mux2x1 #(number_of_bits-1) MUX2(Mux_Sel2,Q_initial,Q_final,MUX2_OUT_Q);
    Left_Shift_AQ #(number_of_bits)LS_AQ(clk,shift_enable,MUX1_OUT_A,shifted_A,MUX2_OUT_Q,shifted_Q);
    assign Diff_A_M = shifted_A - M;
    assign Q_final={{shifted_Q[number_of_bits-2:1]},~Diff_A_M[number_of_bits-1]};
    Mux2x1 #(number_of_bits) MUX3(Mux_Sel3,shifted_A,Diff_A_M,MUX3_OUT_A);
    Controller Ctrl(clk,reset,valid_src,ready_dst,N,Diff_A_M[number_of_bits-1],Mux_Sel1,Mux_Sel2,Mux_Sel3,shift_enable,ready_src,valid_dst,count);
    always_ff @(posedge clk or negedge reset) begin
        if(!reset)begin
            Remainder=0;
            Quotient=0;
        end
        else begin
            if (count==7'b0)begin
                Remainder=Remainder;
                Quotient=Quotient;
            end
            else begin
                Remainder=MUX3_OUT_A;
                Quotient=Q_final;            
            end
        end
    end
endmodule

module Controller(
    input logic clk,
    input logic reset,
    input logic valid_src,ready_dst,
    input logic [6:0]N,
    input logic MSB_A,
    output logic Mux_Sel1,Mux_Sel2,Mux_Sel3,shift_enable,
    output logic ready_src,valid_dst,
    output logic [6:0]count);
    logic [4:0] c_state, n_state;
    logic clear,count0;
    parameter S0=5'd0, S1=5'd1, S2=5'd2,S3=5'd3, S4=5'd4, S5=5'd5,S6=5'd6, S7=5'd7, S8=5'd8,S9=5'd9, S10=5'd10, S11=5'd11,S12=5'd12, S13=5'd13, S14=5'd14,S15=5'd15, S16=5'd16,S17=5'd17;
    //state register
    always_ff @ (posedge clk or negedge reset)
    begin
    //reset is active low
    if (!reset)begin
            c_state <= S0;
            count<=N;
        end
    else begin
        c_state <= n_state;
            if (clear==1)begin
                count<=N;
            end
            else begin
                if (count0==1)begin
                    count<=0;
                end
                else begin
                    count<=count-1;
                end
            end
            
        end
    end
    //next_state always block
    always_comb
    begin
    case (c_state)
        S0: begin if (valid_src && ready_src) n_state = S1;
        else n_state = S0; end
//        S1: n_state = S1;
        S1: begin if (valid_dst&&ready_dst) n_state = S0;
        else n_state = S1;end
        default: n_state = S0;
        endcase
    end
    //output always block
    always_comb
    begin
        case (c_state)
            S0:begin shift_enable = 0;
                clear=1;
                count0=0;
                Mux_Sel1=0;
                Mux_Sel2=0;
                Mux_Sel3=0;
                shift_enable=0;
                valid_dst=0;
                ready_src=1;          //##################
            end
            S1:begin 
                if (count>0)begin
                    shift_enable = 1;
                    clear=0;
                    count0=0;
                    Mux_Sel1=1;
                    Mux_Sel2=1;
                    Mux_Sel3=~MSB_A;
                    shift_enable=1;
                    valid_dst=0;
                    ready_src=0;
                    if (count==N)begin
                        shift_enable = 1;
                        clear=0;
                        count0=0;
                        Mux_Sel1=0;
                        Mux_Sel2=0;
                        Mux_Sel3=~MSB_A;
                        shift_enable=1;
                        valid_dst=0;
                        ready_src=0;
                    end
                end
                else begin shift_enable = 0;
                    clear=1;
                    count0=1;
                    Mux_Sel1=0;
                    Mux_Sel2=0;
                    Mux_Sel3=1;
                    shift_enable=0;
                    valid_dst=1;
                    ready_src=0;
                end
            end
            default:begin shift_enable = 0;
                clear=1;
                Mux_Sel1=0;
                Mux_Sel2=0;
                Mux_Sel3=0;
                shift_enable=0;
                valid_dst=0;
                ready_src=0;
            end
        endcase
    end
endmodule