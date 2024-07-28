module half_adder(
    input logic a,
    input logic b,
    output logic sum,
    output logic cout
);
    assign sum=  a ^ b;     //Sum is XOR of a and b 
    assign cout = a & b ;  //Carry is AND of a and b 
endmodule 
