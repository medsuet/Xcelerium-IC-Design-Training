module multiplier #(
    WIDTH = 4,       // bits of the multiplier
    DEPTH = 4
) (
    input logic [WIDTH-1:0] a, //multiplicand,
    input logic [WIDTH-1:0] b, //multiplier,

    output logic [2*WIDTH-1:0] product
    //output logic [WIDTH-1 : 0] pp [WIDTH-1 : 0] 
);

// partial product
logic [WIDTH-1 : 0] pp [WIDTH-1 : 0];

logic [WIDTH-1 : 0] carry1;
logic [WIDTH-2 : 0] sum1;

logic [WIDTH-1 : 0] carry2;
logic [WIDTH-2 : 0] sum2;

logic [WIDTH-1 : 0] carry3;
logic [WIDTH-2 : 0] sum3;

genvar i, j, k;
// i = rows
// j = columns
generate
    for ( i=0; i < (WIDTH-2); i++) begin
        for ( j=0 ; j < (DEPTH-2); j++) begin
            assign pp [i][j] = a[j] & b[i];
        end
        // last element of each row nand
        assign pp [i][WIDTH-1] = ~(a[WIDTH-1] & b[i]);
    end
    // last row nand gates
    for (k=0; k<DEPTH-2; k++) begin
        assign pp [WIDTH-1][i] = ~(b[WIDTH-1] & a[k]);
    end
    // last and gate
    assign pp[WIDTH-1][WIDTH-1] = (a[WIDTH-1] & b[WIDTH-1]);
endgenerate

assign product[0] = pp[0][0];

// 1st row
halfAdder halfAdder1 (.a(pp[0][1]), .b(pp[1][0]), .s(product[1]), .cout(carry1[0]) );

generate
    for ( k=1; k < (WIDTH-1); k++) begin
        fullAdder FullAdder[i] (.a(pp[0][k+1]), .b(pp[1][k]), .cin(carry1[k-1]), .s(sum1[k-1]), .cout(carry1[k]) );
    end
endgenerate

fullAdder FullAdder1 (.a(pp[1][WIDTH-1]), .b(1), .cin(carry1[WIDTH-2]), .s(sum1[WIDTH-2]), .cout(carry1[WIDTH-1]) );

// 2nd row
halfAdder halfAdder2 (.a(pp[2][0]), .b(sum1[0]), .s(product[2]), .cout(carry2[0]) );

generate
    for ( k=1; k < (WIDTH-2); k++) begin
        fullAdder FullAdder[k+i] (.a(pp[2][k]), .b(sum1[k]), .cin(carry2[k-1]), .s(sum2[k]), .cout(carry2[k]) );
    end
endgenerate

fullAdder FullAdder2 (.a(pp[2][WIDTH-1]), .b(carry1[WIDTH-1]), .cin(carry2[WIDTH-2]), .s(sum2[WIDTH-2]), .cout(carry2[WIDTH-1]) );

// 3rd row
halfAdder halfAdder (.a(pp[3][0]), .b(sum2[0]), .s(product[3]), .cout(carry3[0]) );    

generate
    for ( k=1; k < (WIDTH-2); k++) begin
        fullAdder FullAdder[k+k+i] (.a(pp[3][k]), .b(sum2[k]), .cin(carry3[k-1]), .s(product[k+3]), .cout(carry3[k]) );
    end
endgenerate

fullAdder fullAdder (.a(pp[3][WIDTH-1]), .b(carry3[WIDTH-1]), .cin(carry3[WIDTH-2]), .s(product[2*WIDTH-2]), .cout(carry3[WIDTH-1]) );
assign product[7] = 1 ^ (carry3[WIDTH-1]);

endmodule

module fullAdder (
    input logic a,      // first input bit
    input logic b,      // second input bit
    input logic cin,    // carry in bit

    output logic s,   // sum bit 
    output logic cout   // carry out bit
);

// Combinational logic for the full adder
  assign s = a ^ b ^ cin;                         // Sum is XOR of all inputs
  assign cout = (a & b) | (b & cin) | (a & cin);    // Carry-out is determined by majority

endmodule

module halfAdder (
    input logic a,
    input logic b,

    output logic s,     // sum bit
    output logic cout
);

// Combinational logic for the half adder
  assign s = a ^ b;       // Sum is XOR of the inputs
  assign cout = a & b;      // Carry-out is AND of the inputs
    
endmodule