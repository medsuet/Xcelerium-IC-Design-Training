`timescale 1ns / 1ps
module Mux2x1 #(parameter number_of_bits=4)(
    input logic sel,
    input logic [number_of_bits-1:0] data0,
    input logic [number_of_bits-1:0] data1,
    output logic [number_of_bits-1:0]out
);
    always_comb begin
        out = sel ? data1 : data0;
    end
endmodule
module Comparator #(parameter number_of_bits=4)
(
    input logic [number_of_bits-1:0] data0,
    input logic [number_of_bits-1:0] data1,
    output logic Mux_Sel
);
    logic Mux_Sel_x;
    always_comb begin
        if (data0==data1)begin
            Mux_Sel_x=1;
        end
        else begin
            Mux_Sel_x=0;
        end
        assign Mux_Sel=Mux_Sel_x;
    end
endmodule
module Increment #(parameter number_of_bits=4)(input logic clk,input logic reset,input logic[number_of_bits-1:0]counter_in,output logic[number_of_bits-1:0]counter_out
);
    logic [number_of_bits-1:0]next_counter;
    always_ff @(posedge clk or negedge reset)begin
        if (reset)begin
            next_counter<=0;      
        end else begin
            next_counter<=counter_in+1;
        end
    end
    assign counter_out=next_counter;
endmodule

module Counter_0_to_x #(parameter number_of_bits=4)(input logic clk,input logic reset,input logic[number_of_bits-1:0]counter_in,output logic[number_of_bits-1:0]counter_out
);
    logic [number_of_bits-1:0]out;
    logic Mux_Sel;
    Comparator Comp(counter_out,13,Mux_Sel);
    Mux2x1 mux1(Mux_Sel,counter_out,0,out);
    Increment increment1(clk,reset,out,counter_out);
endmodule