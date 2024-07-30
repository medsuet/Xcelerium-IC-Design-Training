module ALU(
    input logic [1:0]  alu_op,
    input logic [15:0] multiplicand_out,
    input logic [15:0] accumulator_out,
    output logic [15:0] ALU_out
);


always_comb begin 
    case(alu_op) 
        2'b00 : ALU_out = accumulator_out;
        2'b01 : ALU_out = accumulator_out + multiplicand_out;
        2'b10 : ALU_out = accumulator_out - multiplicand_out;
        default: ALU_out = accumulator_out;
    endcase
end
    
endmodule