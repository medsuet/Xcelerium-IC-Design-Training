module ALU #(
    parameter WIDTH = 16     // Width of the inputs and output
) (
    input logic              alu_op,            // ALU operation code
    input logic [WIDTH-1:0]  divisor_out,  
    input logic [WIDTH-1:0]  remainder,   
    input logic [WIDTH-1:0]  quotient,
    output logic [WIDTH-1:0] A_out,
    output logic [WIDTH-1:0] Q_out          
);

// Combinational logic to perform ALU operations based on alu_op
always_comb begin 
    case(alu_op)
        1'b0: begin
            A_out = remainder + divisor_out;
            Q_out = quotient & 16'hFFFE;
        end
        1'b1: begin
            A_out = remainder;
            Q_out = quotient | 16'h0001;
        end
        default: begin
            A_out = remainder;
            Q_out = quotient;
        end
    endcase
end

endmodule
