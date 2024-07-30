`include "src/ALU.sv"
`include "src/Register.sv"
`include "src/Mux.sv"

module Datapath #(
    parameter WIDTH_M = 16,
    parameter WIDTH_P = 32
) (
    input logic                clk,               // Clock signal
    input logic                rst_n,             // Active-low reset signal
    input logic                start,             // Start signal
    input logic [WIDTH_M-1:0]  multiplier,        // Multiplier input
    input logic [WIDTH_M-1:0]  multiplicand,      // Multiplicand input
    input logic                en_multr,          // Enable signal for multiplier register
    input logic                en_mltd,           // Enable signal for multiplicand register
    input logic                en_count,          // Enable signal for counter
    input logic                en_ac,             // Enable signal for accumulator register
    input logic [1:0]          alu_op,            // ALU operation code
    input logic                selQ,              // Mux select for multiplier input
    input logic                selA,              // Mux select for accumulator input
    input logic                selQ_1,            // Select signal for Q_1
    input logic                en_out,            // Enable output signal
    input logic                clear,             // Clear signal

    output logic               count_done,        // Signal indicating count is done
    output logic               Q0,                // Q0 bit of the multiplier register
    output logic               Q_1,               // Q1 bit of the multiplier register
    output logic [WIDTH_P-1:0] product             // Product output
);

logic [4:0] count;                                  // 5-bit counter
logic [WIDTH_M-1:0] multiplicand_out, multiplier_out, accumulator_out, mux_out0, mux_out1, ALU_out;
logic [WIDTH_P-1:0] shifted_combined, combined;
logic mux_out3, Q_next, Q1_in;

// Register for multiplicand
Register Multiplicand_reg(
    .clk(clk),
    .rst_n(rst_n),
    .clear(clear),
    .enable(en_mltd),
    .in(multiplicand),
    .out(multiplicand_out)
);

// Mux to select between multiplier and shifted combined value
Mux mux_multiplier(
    .in0(multiplier),
    .in1(shifted_combined[WIDTH_M-1:0]),
    .sel(selQ),
    .out(mux_out0)
);

// Register for multiplier
Register Multiplier_reg(
    .clk(clk),
    .rst_n(rst_n),
    .clear(clear),
    .enable(en_multr),
    .in(mux_out0),
    .out(multiplier_out)
);

// Mux to select between 0 and shifted combined high bits
Mux mux_accumulator(
    .in0(16'b0),
    .in1(shifted_combined[WIDTH_P-1:WIDTH_M]),
    .sel(selA),
    .out(mux_out1)
);

// Register for accumulator
Register Accumulator_reg(
    .clk(clk),
    .rst_n(rst_n),
    .clear(clear),
    .enable(en_ac),
    .in(mux_out1),
    .out(accumulator_out)
);

assign Q0 = multiplier_out[0];

// Flip-Flop for Q_1
always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        Q_next <= 1'b0;
    end else if(clear) begin
        Q_next <= 1'b0;
    end else if(en_multr) begin
        Q_next <= Q1_in;
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

// Signal indicating count is done
assign count_done = (count == 16) ? 1'b1 : 1'b0;

// ALU to perform operations based on alu_op
ALU ALU(
    .alu_op(alu_op),
    .multiplicand_out(multiplicand_out),
    .accumulator_out(accumulator_out),
    .ALU_out(ALU_out)
);

// Assigning Q1_in to the 0th bit of combined
assign Q1_in = combined[0];

// Concatenating wires for shifting
assign combined = {ALU_out, multiplier_out};

// Shifting logic
assign shifted_combined = {combined[WIDTH_P-1], combined[WIDTH_P-1:1]};

// Output product logic
assign product = (en_out) ? 32'b0 : shifted_combined;

endmodule
