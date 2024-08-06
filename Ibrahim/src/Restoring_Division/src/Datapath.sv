`include "src/ALU.sv"
`include "src/Register.sv"
`include "src/Mux.sv"

module Datapath #(
    parameter WIDTH_M = 16
) (
    input logic                clk,               // Clock signal
    input logic                rst_n,             // Active-low reset signal
    input logic [WIDTH_M-1:0]  dividend,        
    input logic [WIDTH_M-1:0]  divisor,     
    input logic                en_Q,          
    input logic                en_M,           
    input logic                en_A,   
    input logic                en_count,                   
    input logic                alu_op,            // ALU operation code
    input logic                sel_Q,              // 
    input logic                sel_A,              // 
    input logic                en_out,            // Enable output signal
    input logic                en_final,          // Enable to assign product to when destination handshake is complete
    input logic                clear,             // Clear signal

    output logic               count_done,        // Signal indicating count is done
    output logic               sub_msb,                
    output logic [WIDTH_M-1:0] quotient,          
    output logic [WIDTH_M-1:0] remainder
);

logic [4:0] count;                                  // 5-bit counter
logic [WIDTH_M-1:0] divisor_out, dividend_out, remainder_out;
logic [WIDTH_M-1:0] mux_Q, mux_A, A_out, Q_out, remainder_given, new_A;
logic [(2*WIDTH_M)-1:0] shifted_combined, combined, quotient_given, partial_diff;

// always_comb begin
//     if(divisor == '0) begin
//         divisor = {{WIDTH_M-2{1'b0}}, 1'b1};
//     end
// end

// Register for multiplicand
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

Mux #(
    .WIDTH(WIDTH_M)
) mux_dividend(
    .in0(dividend),
    .in1(Q_out),
    .sel(sel_Q),
    .out(mux_Q)
);

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

Mux #(
    .WIDTH(WIDTH_M)
) mux_remainder(
    .in0({WIDTH_M{1'b0}}),  // Zero
    .in1(A_out),
    .sel(sel_A),
    .out(mux_A)
);

Register #(
    .WIDTH(WIDTH_M)
) Accumulator_reg(
    .clk(clk),
    .rst_n(rst_n),
    .clear(clear),
    .enable(en_A),
    .in(mux_A),
    .out(remainder_out)
);


// Counter
always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        count <= #1 'b0;
    end else if(clear) begin
        count <= #1 'b0;
    end else if(en_count) begin
        count <= #1 count + 1;
    end 
end

// Signal indicating count is done
assign count_done = (count == 16) ?  1'b1 :  1'b0;

// Concatenating wires for shifting
assign combined = {remainder_out, dividend_out};


// Shifting logic
assign shifted_combined = {combined[(2*WIDTH_M)-2:0], 1'b0};

assign new_A = shifted_combined[(2*WIDTH_M)-1:WIDTH_M];
assign partial_diff = new_A - divisor_out;

always_comb begin
    sub_msb = partial_diff[15];
end


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


// Store the quotient and remainder calculated in these registers 
always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        remainder_given <= '0;
        quotient_given  <= '0;
    end  else if(en_out) begin
        remainder_given <= A_out;
        quotient_given  <= Q_out;
    end
end

// Output these quotient and remainder when destination handshake is complete
assign quotient = (!en_final) ? {WIDTH_M{1'b0}} : quotient_given;

assign remainder = (!en_final) ? {WIDTH_M{1'b0}} : remainder_given;

endmodule