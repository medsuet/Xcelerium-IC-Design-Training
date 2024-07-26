`timescale 1ns / 1ps

`include "sig_mul.svh"

module signed_multiplier(
    input logic signed [width-1:0] multiplicand,
    input logic signed [width-1:0] multiplier,
    output logic signed [result_width-1:0] result
);
    logic msb_bit,msb_carry; 
    logic [result_width-1:0]product;                       //The 
    logic [width-1:0][width-1:0] partial_product;
    logic [width-1:0][width-1:0] carry;
    logic [width-1:0][width-1:0] sum;

// Generate Block for Partial Product
    generate
        genvar i, j;
        for (i = 0; i < width; i++) begin
            for (j = 0; j < width; j++) begin
                if (j < width - 1) begin
                   assign  partial_product[i][j] = (multiplier[i] & multiplicand[j]);
                end else begin
                   assign partial_product[i][j] = ~(multiplier[i] & multiplicand[j]);
                end
            end
        end
    endgenerate
    
    generate 
        genvar k;
        for (k = 0; k < width - 1; k++) begin
           assign partial_product[width - 1][k] = ~(multiplier[width - 1] & multiplicand[k]);
        end
           assign partial_product[width - 1][width - 1] = (multiplier[width - 1] & multiplicand[width - 1]);
    endgenerate

    // Set the value of the sum and the carry for the first row of the partial products
    generate
        genvar p;
        for (p = 0; p < width; p++) begin
           assign sum[0][p] = partial_product[0][p];
           assign carry[0][p] = 0;
        end
    endgenerate

   // This Generate block calculates the value of sum and the carry and calculates the product of the rows

    generate
        genvar q, r;
        for (q = 1; q < width; q++) begin
            for (r = 0; r < width; r++) begin
                if (r == 0) begin
                    half_adder HA(
                        .a(sum[q-1][r+1]),
                        .b(partial_product[q][r]),
                        .s(sum[q][r]),
                        .c(carry[q][r])
                    );
                end
                else if (q == 1 && r == width-1) begin
                    full_adder FA(
                        .a(1'b1),
                        .b(partial_product[q][r]),
                        .cin(carry[q][r-1]),
                        .sum(sum[q][r]),
                        .carry(carry[q][r])
                    );
                end
                else if (r == width-1) begin
                    full_adder FA(
                        .a(carry[q-1][r]),
                        .b(partial_product[q][r]),
                        .cin(carry[q][r-1]),
                        .sum(sum[q][r]),
                        .carry(carry[q][r])
                    );
                end
                else begin
                    full_adder FA(
                        .a(sum[q-1][r+1]),
                        .b(partial_product[q][r]),
                        .cin(carry[q][r-1]),
                        .sum(sum[q][r]),
                        .carry(carry[q][r])
                    );
                end
            end
        end
    endgenerate


half_adder final_HA (
                        .a(1'b1),
                        .b(carry[width-1][width-1]),
                        .s(msb_bit),
                        .c(msb_carry)
                    );
    // Final summation to form the product
    always_comb begin
        product = 'h0; //Initialize the product to zero
        for (int m = 0; m < result_width-1; m++)begin
            if ( m < (width) )begin

                product |=  sum[m][0] << m ;

            end
            else begin
                product |= sum[width-1][m-(width-1)] << m;

            end
        end
        product |= msb_bit << (result_width-1) ;

        result = product;       
        
    end
endmodule

// HALF ADDER Module
module half_adder (
    input logic a,    // Input 'a'
    input logic b,    // Input 'b'
    output logic s,   // Output 's' (Sum)
    output logic c    // Output 'c' (Carry)
);
    assign s = a ^ b;  // XOR operation for sum
    assign c = a & b;  // AND operation for carry
endmodule

// FULL ADDER Module 
module full_adder (
    input logic a,
    input logic b,
    input logic cin,
    output logic sum,
    output logic carry
);
    assign sum = a ^ b ^ cin;
    assign carry = (a & b) | (b & cin) | (cin & a);
endmodule
