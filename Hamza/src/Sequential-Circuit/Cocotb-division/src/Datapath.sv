module Datapath #(
    parameter WIDTH_M = 16  // Width of the inputs and outputs
) (
    input logic                clk,             
    input logic                reset,           
    input logic [WIDTH_M-1:0]  dividend,        
    input logic [WIDTH_M-1:0]  divisor,         
    input logic                en_Q,            
    input logic                en_M,            
    input logic                en_A,            
    input logic                en_count,        
    input logic                alu_op,          
    input logic                sel_Q,           
    input logic                sel_A,           
    input logic                en_out,          
    input logic                en_final,        
    input logic                clear,           

    output logic               count_comp,      
    output logic               sub_msb,         
    output logic [WIDTH_M-1:0] quotient,        
    output logic [WIDTH_M-1:0] remainder    
);

// Internal signals
logic [4:0] count;                                             // 5-bit counter for the number of iterations
logic [WIDTH_M:0] divisor_out, remainder_given, remainder_out; // Internal registers for divisor, dividend, and remainder
logic [WIDTH_M-1:0] dividend_out;
logic [WIDTH_M:0] mux_Q, mux_A, new_A, partial_diff, A_out, Q_out;
logic [(2*WIDTH_M):0] shifted_combined, combined;
logic [(2*WIDTH_M)-1:0] quotient_given;

// Register for divisor
always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        divisor_out <= {WIDTH_M{1'b0}};
    end else if (clear) begin
        divisor_out <= {WIDTH_M{1'b0}};
    end else if (en_M) begin
        divisor_out <= divisor;
    end
end

// Mux to select between dividend and Q_out from the ALU
always_comb begin
    if (sel_Q) begin
        mux_Q = Q_out;
    end else begin
        mux_Q = dividend;
    end
end

// Register for dividend
always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        dividend_out <= {WIDTH_M{1'b0}};
    end else if (clear) begin
        dividend_out <= {WIDTH_M{1'b0}};
    end else if (en_Q) begin
        dividend_out <= mux_Q;
    end
end

// Mux to select between zero and A_out from ALU
always_comb begin
    if (sel_A) begin
        mux_A = A_out;
    end else begin
        mux_A = {WIDTH_M{1'b0}}; 
    end
end

// Register for remainder
always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        remainder_out <= {WIDTH_M{1'b0}};
    end else if (clear) begin
        remainder_out <= {WIDTH_M{1'b0}};
    end else if (en_A) begin
        remainder_out <= mux_A;
    end
end

// Counter to keep track of iterations
always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        count <= #1 'b0;  // Reset counter
    end else if (clear) begin
        count <= #1 'b0;  // Clear counter
    end else if (en_count) begin
        count <= #1 count + 1;  // Increment counter
    end 
end

always_comb begin
    // Determine if the count has completed
    count_comp = (count == WIDTH_M) ? 1'b1 : 1'b0;

    // Concatenate remainder and dividend
    combined = {remainder_out, dividend_out};

    // Shifting logic to prepare for the next iteration
    shifted_combined = {combined[(2*WIDTH_M)-2:0], 1'b0};

    // Compute new remainder
    new_A = shifted_combined[(2*WIDTH_M):WIDTH_M];

    // Compute partial difference
    partial_diff = new_A - divisor_out;

    // Determine the MSB of the partial difference
    sub_msb = partial_diff[WIDTH_M];
end


// ALU operations based on alu_op
always_comb begin 
    case (alu_op)
        1'b0: begin
            // When alu_op is 0, perform addition and clear LSB of quotient
            A_out = partial_diff + divisor_out;
            Q_out = shifted_combined[WIDTH_M-1:0] & 16'hFFFE;
        end
        1'b1: begin
            // When alu_op is 1, retain remainder and set LSB of quotient
            A_out = partial_diff;
            Q_out = shifted_combined[WIDTH_M-1:0] | 16'h0001;
        end
        default: begin
            // Default case: pass through remainder and quotient without modification
            A_out = partial_diff;
            Q_out = shifted_combined[WIDTH_M-1:0];
        end
    endcase
end

// Store the quotient and remainder when en_out is high
always_ff @(posedge clk or negedge reset) begin
    if (!reset) begin
        remainder_given <= '0;
        quotient_given  <= '0;
    end else if (en_out) begin
        remainder_given <= A_out;
        quotient_given  <= Q_out;
    end
end

// Output the quotient and remainder when en_final is high
assign quotient  = (!en_final) ? {WIDTH_M{1'b0}} : quotient_given;
assign remainder = (!en_final) ? {WIDTH_M{1'b0}} : remainder_given;

endmodule
