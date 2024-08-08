module datapath #(
    parameter WIDTH_M = 16  // Width of the inputs and outputs
) (
    input logic                clk,               // Clock signal
    input logic                reset,             // Active-low reset signal
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

    output logic               count_comp,        // Signal indicating the counter has completed
    output logic               sub_msb,           // Most significant bit of the subtraction result (A-M)
    output logic [WIDTH_M-1:0] quotient,          // Output quotient
    output logic [WIDTH_M-1:0] remainder          // Output remainder
);

// Internal signals
logic [4:0] count;                                             // 5-bit counter for the number of iterations
logic [WIDTH_M:0] divisor_out, remainder_given, remainder_out; // Internal registers for divisor, dividend, and remainder
logic [WIDTH_M-1:0] dividend_out;
logic [WIDTH_M:0] mux_Q, mux_A, new_A, partial_diff, A_out, Q_out;
logic [(2*WIDTH_M):0] shifted_combined, combined;
logic [(2*WIDTH_M)-1:0] quotient_given;

// Register for divisor
Register #(
    .WIDTH(WIDTH_M)
) Divisor_reg(
    .clk(clk),
    .reset(reset),
    .clear(clear),
    .enable(en_M),
    .in(divisor),
    .out(divisor_out)
);

// Mux to select between dividend and Q_out from the ALU
Mux #(
    .WIDTH(WIDTH_M)
) mux_dividend(
    .input0(dividend),
    .input1(Q_out),
    .sel(sel_Q),
    .out(mux_Q)
);

// Register for dividend
Register #(
    .WIDTH(WIDTH_M)
) Dividend_reg(
    .clk(clk),
    .reset(reset),
    .clear(clear),
    .enable(en_Q),
    .in(mux_Q),
    .out(dividend_out)
);

// Mux to select between zero and A_out from ALU
Mux #(
    .WIDTH(WIDTH_M)
) mux_remainder(
    .input0({WIDTH_M{1'b0}}),  // Zero
    .input1(A_out),
    .sel(sel_A),
    .out(mux_A)
);

// Register for remainder
Register #(
    .WIDTH(WIDTH_M)
) Remainder_reg(
    .clk(clk),
    .reset(reset),
    .clear(clear),
    .enable(en_A),
    .in(mux_A),
    .out(remainder_out)
);

// Counter to keep track of iterations
always_ff @(posedge clk or negedge reset) begin
    if(!reset) begin
        count <= #1 'b0;  // Reset counter
    end else if(clear) begin
        count <= #1 'b0;  // Clear counter
    end else if(en_count) begin
        count <= #1 count + 1;  // Increment counter
    end 
end


assign count_comp = (count == WIDTH_M) ? 1'b1 : 1'b0; // count_comp is done when counter reaches 16
assign combined = {remainder_out, dividend_out}; // Concatenate remainder and dividend
assign shifted_combined = {combined[(2*WIDTH_M)-2:0], 1'b0}; // Shifting logic to prepare for the next iteration
assign new_A = shifted_combined[(2*WIDTH_M):WIDTH_M]; // Compute new remainder
assign partial_diff = new_A - divisor_out; // Compute partial difference
assign sub_msb = partial_diff[WIDTH_M]; // Determine the MSB of the partial difference

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
always_ff @(posedge clk or negedge reset) begin
    if(!reset) begin
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

// module for mux
module Mux #(
    parameter WIDTH = 16    // Width of the inputs and output
) (
    input logic [WIDTH-1:0]  input0,  // Input 0
    input logic [WIDTH-1:0]  input1,  // Input 1
    input logic              sel,  // Select signal
    output logic [WIDTH-1:0] out   // Output
);
    always_comb 
    begin
        if (sel)begin
            out = input1;
        end
        else begin
            out = input0;
        end
    end
endmodule

// module for different registers
module Register #(
    parameter WIDTH = 16  // Width of the register
) (
    input logic               clk,        // Clock signal
    input logic               reset,      // Active-low reset signal
    input logic               clear,      // Clear signal
    input logic               enable,     // Enable signal
    input logic [WIDTH-1:0]   in,         // Data input
    output logic [WIDTH-1:0]  out         // Data output
);

always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        // Asynchronous reset: clear the register on reset
        out <= #1 {WIDTH{1'b0}};
    end else if (clear) begin
        // Synchronous clear: set the register to zero
        out <= #1 {WIDTH{1'b0}};
    end else if (enable) begin
        // Load new data into the register when enabled
        out <= #1 in;
    end
end
endmodule

// ALU module
module ALU #(
    parameter WIDTH = 16     // Width of the inputs and output
) (
    input logic              alu_op,            // ALU operation code
    input logic [WIDTH-1:0]  divisor_out,       // Output from the divisor register
    input logic [WIDTH-1:0]  remainder,         // Current remainder
    input logic [WIDTH-1:0]  quotient,          // Current quotient
    output logic [WIDTH-1:0] A_out,             // Output to the A register
    output logic [WIDTH-1:0] Q_out              // Output to the Q register
);

always_comb begin 
    case(alu_op)
        1'b0: 
        begin
            // When alu_op is 0, perform addition and clear LSB of quotient
            A_out = remainder + divisor_out;
            Q_out = quotient & 16'hFFFE;
        end
        1'b1: 
        begin
            // When alu_op is 1, retain remainder and set LSB of quotient
            A_out = remainder;
            Q_out = quotient | 16'h0001;
        end
        default: 
        begin
            // Default case: pass through remainder and quotient without modification
            A_out = remainder;
            Q_out = quotient;
        end
    endcase
end
endmodule

