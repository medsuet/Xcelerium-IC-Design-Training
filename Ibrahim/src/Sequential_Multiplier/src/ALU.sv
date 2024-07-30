module ALU(
    input logic [1:0]  alu_op,            // ALU operation code
    input logic [15:0] multiplicand_out,  // Output from the multiplicand register
    input logic [15:0] accumulator_out,   // Output from the accumulator register
    output logic [15:0] ALU_out           // Output of the ALU
);

// Combinational logic to perform ALU operations based on alu_op
always_comb begin 
    case(alu_op)
        2'b00 : ALU_out = accumulator_out;                 // No operation, pass accumulator output
        2'b10 : ALU_out = accumulator_out + multiplicand_out; // Add accumulator and multiplicand
        2'b01 : ALU_out = accumulator_out - multiplicand_out; // Subtract multiplicand from accumulator
        default: ALU_out = accumulator_out;                 // Default to passing accumulator output
    endcase
end

endmodule
