//===================================Full Adder===================================
module fullAdder(input logic bit1, input logic bit2, input logic carry_in, output logic sum, output logic carry_out);
    assign sum = bit1 ^ bit2 ^ carry_in;
    assign carry_out = (bit1 & bit2) | (carry_in & (bit1 ^ bit2));
endmodule