/*
    Name: FullAdder.sv
    Author: Muhammad Tayyab
    Date: 23-7-2024
    Description: Adds two input bits and one input carry bit.
                 Outputs one sum bit and one carry bit.

*/
module FullAdder (
    input logic bit1, bit2, Cin,
    output logic sum, Cout
);

    always_comb begin
        case ({bit1,bit2,Cin})
            3'b000: begin Cout = 1'b0; sum = 1'b0; end
            3'b001: begin Cout = 1'b0; sum = 1'b1; end
            3'b010: begin Cout = 1'b0; sum = 1'b1; end
            3'b011: begin Cout = 1'b1; sum = 1'b0; end
            3'b100: begin Cout = 1'b0; sum = 1'b1; end
            3'b101: begin Cout = 1'b1; sum = 1'b0; end
            3'b110: begin Cout = 1'b1; sum = 1'b0; end
            3'b111: begin Cout = 1'b1; sum = 1'b1; end
        endcase
    end
    
endmodule