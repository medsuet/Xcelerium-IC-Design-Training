module multiplier #(
    WIDTH = 16       // bits of the multiplier
) (
    input logic [WIDTH-1:0] a, //multiplicand
    input logic [WIDTH-1:0] b, //multiplier

    output logic [2*WIDTH-1:0] product  // answer
);

logic [WIDTH-1 : 0] pp    [WIDTH-1 : 0];        // partial product AND / NANDS
logic [WIDTH-1 : 0] carry [WIDTH-2 : 0];        // carry bits matrix
logic [WIDTH-2 : 0] sum   [WIDTH-3 : 0];        // sum bits matrix

// this block is only make all the AND / NAND of the bits
generate 
    for (genvar i=0; i < (WIDTH-1); i++) begin      // i = rows
        for (genvar j=0 ; j <= (WIDTH-2); j++) begin    // j = columns
            assign pp [i][j] = a[j] & b[i];
        end
        // last element of each row is nand
        assign pp [i][WIDTH-1] = ~(a[WIDTH-1] & b[i]);
    end
    // last row nand gates
    for (genvar k=0; k <= WIDTH-2; k++) begin
        assign pp [WIDTH-1][k] = ~(b[WIDTH-1] & a[k]);
    end
    // last and gate
    assign pp[WIDTH-1][WIDTH-1] = (a[WIDTH-1] & b[WIDTH-1]);
endgenerate

// 1st bit of product
assign product[0] = pp[0][0];

// 1st row
// (1st) 1 half adder with two inputs of AND gates (2nd bit of product)
// WIDTH-2 (i.e. 14) number of full adders with two inputs of AND gate. 14th full adder has the inputs of AND/NAND gate.
// WIDTH-1 (i.e. 15)th full adder with one input is 1 and second input is the output of NAND gate
generate
    halfAdder halfAdder1 (.a(pp[0][1]), .b(pp[1][0]), .s(product[1]), .cout(carry[0][0]) );
    
    for (genvar k=1; k < (WIDTH-1); k++) begin
        fullAdder FullAdder (.a(pp[0][k+1]), .b(pp[1][k]), .cin(carry[0][k-1]), .s(sum[0][k-1]), .cout(carry[0][k]) );
    end
    
    fullAdder FullAdder1 (.a(pp[1][WIDTH-1]), .b(1), .cin(carry[0][WIDTH-2]), .s(sum[0][WIDTH-2]), .cout(carry[0][WIDTH-1]) );
endgenerate

// 2nd row to WIDTH-2 row
// 1 half adder each row has inputs of one full adder and one AND gate 
// WIDTH-2 (i.e 14) number of full adders each row has inputs of 1 full adder and 1 AND gate. 
// 14th full adder of each row has input of 1 NAND gate and one full adder
// WIDTH-1 (i.e 15)th full adder of each has the input of one full adder carry bit and one NAND gate.
generate
    for (genvar i=1; i < WIDTH-2; i++) begin
        halfAdder halfAdder2 (.a(pp[i+1][0]), .b(sum[i-1][0]), .s(product[i+1]), .cout(carry[i][0]) );
        
        for (genvar k=1; k < (WIDTH-1); k++) begin
            fullAdder FullAdder (.a(pp[i+1][k]), .b(sum[i-1][k]), .cin(carry[i][k-1]), .s(sum[i][k-1]), .cout(carry[i][k]) );
        end
        
        fullAdder FullAdder2 (.a(pp[i+1][WIDTH-1]), .b(carry[i-1][WIDTH-1]), .cin(carry[i][WIDTH-2]), .s(sum[i][WIDTH-2]), .cout(carry[i][WIDTH-1]) );
    end
endgenerate

// Last row
// 1 half adder has the input of the NAND gate and one full adder
// WIDTH-2 (i.e 14) number of full adders has input of one full adder and one NAND gate
// 15th bit has the input of AND gate and previous full adder carry bit
// 1 additional half adder is added in the last row contains the input of 1 and previous full adder carry bit
generate
    halfAdder halfAdder (.a(pp[WIDTH-1][0]), .b(sum[WIDTH-3][0]), .s(product[WIDTH-1]), .cout(carry[WIDTH-2][0]) );

    for (genvar k=1; k < (WIDTH-1); k++) begin
        fullAdder FullAdder (.a(pp[WIDTH-1][k]), .b(sum[WIDTH-3][k]), .cin(carry[WIDTH-2][k-1]), .s(product[k+(WIDTH-1)]), .cout(carry[WIDTH-2][k]) );
    end
    
    fullAdder fullAdder (.a(pp[WIDTH-1][WIDTH-1]), .b(carry[WIDTH-3][WIDTH-1]), .cin(carry[WIDTH-2][WIDTH-2]), .s(product[2*WIDTH-2]), .cout(carry[WIDTH-2][WIDTH-1]) );
endgenerate

assign product[2*WIDTH-1] = 1 ^ (carry[WIDTH-2][WIDTH-1]);

endmodule

module fullAdder (
    input logic a,      // first input bit
    input logic b,      // second input bit
    input logic cin,    // carry in bit

    output logic s,     // sum bit 
    output logic cout   // carry out bit
);

// Combinational logic for the full adder
  assign s = a ^ b ^ cin;                         // Sum is XOR of all inputs
  assign cout = (a & b) | (b & cin) | (a & cin);    // Carry-out is determined by majority

endmodule

module halfAdder (
    input logic a,      // first input bit
    input logic b,      // second input bit

    output logic s,     // sum bit
    output logic cout   // carry out bit
);

// Combinational logic for the half adder
  assign s = a ^ b;       // Sum is XOR of the inputs
  assign cout = a & b;      // Carry-out is AND of the inputs
    
endmodule