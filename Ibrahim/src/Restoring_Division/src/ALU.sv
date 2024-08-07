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

// Combinational logic to perform ALU operations based on alu_op
always_comb begin 
    case(alu_op)
        1'b0: begin
            // When alu_op is 0, perform addition and clear LSB of quotient
            A_out = remainder + divisor_out;
            Q_out = quotient & 16'hFFFE;
        end
        1'b1: begin
            // When alu_op is 1, retain remainder and set LSB of quotient
            A_out = remainder;
            Q_out = quotient | 16'h0001;
        end
        default: begin
            // Default case: pass through remainder and quotient without modification
            A_out = remainder;
            Q_out = quotient;
        end
    endcase
end

endmodule
