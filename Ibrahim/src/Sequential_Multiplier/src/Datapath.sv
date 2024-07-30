`include "ALU.sv"
`include "Register.sv"
`include "Mux.sv"

module Datapath #(
    parameter WIDTH_M = 16,
    parameter WIDTH_P = 32
) (
    input logic                clk,
    input logic                rst_n,
    input logic                start,
    input logic [WIDTH_M-1:0]  multiplier,
    input logic [WIDTH_M-1:0]  multiplicand,
    input logic [WIDTH_M-1:0]  accumulator,
    input logic                en_multr,
    input logic                en_mltd,
    input logic                en_count,
    input logic                en_ac,
    input logic [1:0]          alu_op,
    input logic                selQ,
    input logic                selA,
    input logic                selQ_1,
    input logic                en_out,
    input logic                clear,

    output logic               count_done,
    output logic               Q0,
    output logic               Q_1,
    output logic [WIDTH_P-1:0] product
);

// logic mux_out0, mux_out1;
logic mux_out3, Q_next;
logic [4:0] count;
logic [15:0] multiplicand_out, multiplier_out, accumulator_out, mux_out0, mux_out1, ALU_out;
logic [31:0] shifted_combined, combined;


Register Multiplicand_reg(
    .clk(clk),
    .rst_n(rst_n),
    .clear(clear),
    .enable(en_mltd),
    .in(multiplicand),
    .out(multiplicand_out)
);

Mux mux_multiplier(
    .in0(multiplier),
    .in1(shifted_combined[15:0]),
    .sel(selQ),
    .out(mux_out0)
);

Register Multiplier_reg(
    .clk(clk),
    .rst_n(rst_n),
    .clear(clear),
    .enable(en_multr),
    .in(mux_out0),
    .out(multiplier_out)
);

Mux mux_accumulator(
    .in0(accumulator),
    .in1(shifted_combined[31:16]),
    .sel(selA),
    .out(mux_out1)
);

Register Accumulator_reg(
    .clk(clk),
    .rst_n(rst_n),
    .clear(clear),
    .enable(en_ac),
    .in(mux_out1),
    .out(accumulator_out)
);

assign Q0 = multiplier_out[0];

// //assigning Q1 in to 0th bit shifted
// assign Q1_in = combined[0];

always_comb begin
    if(selQ_1) begin
        mux_out3 = Q0;
    end else begin
        mux_out3 = 1'b0;
    end
end
// FlipFlop for Q_1
always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        Q_next <= 1'b0;
    end else if(clear) begin
        Q_next <= 1'b0;
    end else if(en_multr) begin
        Q_next <= mux_out3;
    end
end

assign Q_1 = Q_next;


// Counter
always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        count <= 1'b0;
    end else if(clear) begin
        count <= 1'b0;
    end else if(en_count) begin
        count <= count + 1;
    end 
end

//output signal for counting
assign count_done = (count == 16) ? 1'b1 : 1'b0;

// ALU for calculating A - M or A + M or A
ALU ALU(
    .alu_op(alu_op),
    .multiplicand_out(multiplicand_out),
    .accumulator_out(accumulator_out),
    .ALU_out(ALU_out)
);

//concatinating wires for shifting
assign combined = {ALU_out, multiplier_out};

//now shifting right
assign shifted_combined = {combined[31],combined[31:1]};


always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        product <= 1'b0;
    end else if(clear) begin
        product <= 1'b0;
    end else if(!en_out) begin
        product <= shifted_combined;
    end else begin
        product <= 32'b0;
    end
end 

endmodule
