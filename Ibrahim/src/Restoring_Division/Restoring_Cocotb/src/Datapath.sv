/* verilator lint_off WIDTHTRUNC */

module Datapath #(
    parameter WIDTH_M = 16  // Width of the inputs and outputs
) (
    input logic                clk,               // Clock signal
    input logic                rst_n,             // Active-low reset signal
    input logic [WIDTH_M-1:0]  dividend,          // Dividend input for division
    input logic [WIDTH_M-1:0]  divisor,           // Divisor input for division
    input logic                en_Q,              // Enable signal for dividend register
    input logic                en_M,              // Enable signal for divisor register
    input logic                en_A,              // Enable signal for remainder register
    input logic                en_count,          // Enable signal for counter
    input logic                alu_op,            // ALU operation code
    input logic                sel_Q,             // Select signal for dividend mux
    input logic                sel_A,             // Select signal for remainder mux
    input logic                en_out,            // Enable signal to output quotient and remainder
    input logic                en_final,          // Enable signal to provide final quotient and remainder
    input logic                clear,             // Clear signal

    output logic               count_done,        // Signal indicating the counter has completed
    output logic               sub_msb,           // Most significant bit of the subtraction result (A-M)
    output logic [WIDTH_M-1:0] quotient,          // Output quotient
    output logic [WIDTH_M-1:0] remainder          // Output remainder
);

// Internal signals
logic [4:0] count;                                             // 5-bit counter for the number of iterations
logic [WIDTH_M-1:0] divisor_out, remainder_given, remainder_out; // Internal registers for divisor, dividend, and remainder
logic [WIDTH_M-1:0] dividend_out, mux_Q, Q_out, mux_A, A_out, quotient_given;
logic [WIDTH_M:0]  new_A, partial_diff;
logic [(2*WIDTH_M):0] shifted_combined, combined;

// Register for divisor
Register #(
    .WIDTH(WIDTH_M)
) Divisor_reg(
    .clk(clk),
    .rst_n(rst_n),
    .clear(clear),
    .enable(en_M),
    .in(divisor),
    .out(divisor_out)
);

// Mux to select between dividend and Q_out from the ALU
Mux #(
    .WIDTH(WIDTH_M)
) mux_dividend(
    .in0(dividend),
    .in1(Q_out),
    .sel(sel_Q),
    .out(mux_Q)
);

// Register for dividend
Register #(
    .WIDTH(WIDTH_M)
) Dividend_reg(
    .clk(clk),
    .rst_n(rst_n),
    .clear(clear),
    .enable(en_Q),
    .in(mux_Q),
    .out(dividend_out)
);

// Mux to select between zero and A_out from ALU
Mux #(
    .WIDTH(WIDTH_M)
) mux_remainder(
    .in0({WIDTH_M{1'b0}}),  // Zero
    .in1(A_out),
    .sel(sel_A),
    .out(mux_A)
);

// Register for remainder
Register #(
    .WIDTH(WIDTH_M)
) Remainder_reg(
    .clk(clk),
    .rst_n(rst_n),
    .clear(clear),
    .enable(en_A),
    .in(mux_A),
    .out(remainder_out)
);

// Counter to keep track of iterations
always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        count <= #1 'b0;  // Reset counter
    end else if(clear) begin
        count <= #1 'b0;  // Clear counter
    end else if(en_count) begin
        count <= #1 count + 1;  // Increment counter
    end 
end

// Signal indicating count is done when counter reaches WIDTH_M
assign count_done = (count == WIDTH_M) ? 1'b1 : 1'b0;

// Concatenate remainder and dividend for shifting
assign combined = {remainder_out, dividend_out};

// Shifting logic to prepare for the next iteration
assign shifted_combined = {combined[(2*WIDTH_M)-2:0], 1'b0};

// Compute new remainder and partial difference
assign new_A = shifted_combined[(2*WIDTH_M):WIDTH_M];
assign partial_diff = new_A - divisor_out;

// Determine the most significant bit of the partial difference
assign sub_msb = partial_diff[WIDTH_M];

// ALU to perform operations based on alu_op
ALU #(
    .WIDTH(WIDTH_M)
) ALU(
    .alu_op(alu_op),
    .divisor_out(divisor_out),
    .remainder(partial_diff),
    .quotient(shifted_combined[WIDTH_M-1:0]),
    .A_out(A_out),
    .Q_out(Q_out)
);

// Store the quotient and remainder when en_out is high
always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        remainder_given <= '0;
        quotient_given  <= '0;
    end else if(en_out) begin
        remainder_given <= A_out;
        quotient_given  <= Q_out;
    end
end

// Output the quotient and remainder when en_final is high (When Handshake is Complete)
assign quotient  = (!en_final) ? {WIDTH_M{1'b0}} : quotient_given;
assign remainder = (!en_final) ? {WIDTH_M{1'b0}} : remainder_given;

endmodule

/* verilator lint_on WIDTHTRUNC */