module full_adder(
    input logic a,b,
    input logic cin,
    output logic sum,cout
);
    assign sum=  a ^ b ^ cin;                                       //Sum is XOR of a and b and carry
    assign cout = (a & b) | (cin & (a^b)) ;            //Carry is AND of a or b or c 

endmodule 


