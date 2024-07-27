//===================================Half Adder===================================
module halfAdder(input logic bit1, input logic bit2, output logic sum, output logic carry);
    assign sum = bit1 ^ bit2;
    assign carry = bit1 & bit2;
endmodule
