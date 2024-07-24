module half_adder(
    input  logic a,       // First input bit
    input  logic b,       // Second input bit
    output logic sum,     // Sum output
    output logic carry    // Carry output
);
    // Sum is the XOR of the two input bits
    assign sum = a ^ b;

    // Carry is the AND of the two input bits
    assign carry = a & b;
endmodule

module full_adder(
    input  logic a,       // First input bit
    input  logic b,       // Second input bit
    input  logic carry_in, // Carry-in from the previous stage
    output logic sum,     // Sum output
    output logic carry_out // Carry-out to the next stage
);
    // Intermediate results for sum and carry
    logic sum1, carry1, carry2;

    // First half-adder to handle the addition of `a` and `b`
    half_adder ha1(
        .a(a),
        .b(b),
        .sum(sum1),
        .carry(carry1)
    );

    // Second half-adder to add the result of the first half-adder with `carry_in`
    half_adder ha2(
        .a(sum1),
        .b(carry_in),
        .sum(sum),
        .carry(carry2)
    );

    // Final carry-out is the OR of the carry outputs from both half-adders
    assign carry_out = carry1 | carry2;
endmodule

module signed_comb_multiplier #(
  parameter WIDTH_M = 16,
  parameter WIDTH_P = 32
) ( 
    input logic [WIDTH_M-1:0] multiplicand, // 16-bit inputs
    input logic [WIDTH_M-1:0] multiplier, 

    output logic [WIDTH_P-1:0] product // 32-bit product output
);

logic [WIDTH_M-1:0] sum [WIDTH_M-1:0]; // Intermediate sums for each level
logic [WIDTH_M-1:0] carry [WIDTH_M-1:0]; // Intermediate carries for each level
logic [WIDTH_M-1:0] partial_products[WIDTH_M-1:0]; // Partial products for each bit

// Generate block for creating partial products
generate
    genvar i, j;
    for (i = 0; i < WIDTH_M; i++) begin
        for (j = 0; j < WIDTH_M; j++) begin
            // Performing AND and NAND operations for each level
            if ((i == WIDTH_M-1 || j == WIDTH_M-1) && ~(i == WIDTH_M-1 && j == WIDTH_M-1)) begin
                assign partial_products[i][j] = ~(multiplicand[i] & multiplier[j]);
            end else begin
                assign partial_products[i][j] = (multiplicand[i] & multiplier[j]);
            end
        end
    end
endgenerate

// Generate block for addition stages
generate
    genvar level, n;
    for (level = 0; level < WIDTH_M-1; level++) begin
        if (level == 0) begin
            // Handle the first level of addition
            half_adder ha0(.a(partial_products[0][1]), .b(partial_products[1][0]), .sum(sum[0][0]), .carry(carry[0][0]));
            
            // iterate the loop 14 times(from 1 to WIDTH_M-1) as each level has 15 full adders and last full adder has different input from these 14 
            for (n = 1; n < WIDTH_M-1; n++) begin
                full_adder fa(.a(partial_products[0][n+1]), .b(partial_products[1][n]), .carry_in(carry[0][n-1]), .sum(sum[0][n]), .carry_out(carry[0][n]));
            end

            // Final full adder for the first level
            full_adder fa0(.a(1'b1), .b(partial_products[1][WIDTH_M-1]), .carry_in(carry[0][WIDTH_M-2]), .sum(sum[0][WIDTH_M-1]), .carry_out(carry[0][WIDTH_M-1]));
        
        end else if (level == WIDTH_M-2) begin
            // Handle the last level of addition
            half_adder ha_fin(.a(partial_products[level+1][0]), .b(sum[level-1][1]), .sum(sum[level][0]), .carry(carry[level][0]));
            
            // iterate the loop 14 times(from 1 to WIDTH_M-1) as each level has 15 full adders and last full adder has different input from these 14 
            for (n = 1; n < WIDTH_M-1; n++) begin
                full_adder fa_fin(.a(sum[level-1][n+1]), .b(partial_products[level+1][n]), .carry_in(carry[level][n-1]), .sum(sum[level][n]), .carry_out(carry[level][n]));
            end

            // Final full adder and half adder for the last level
            full_adder fa_fin_last(.a(carry[level-1][WIDTH_M-1]), .b(partial_products[level+1][WIDTH_M-1]), .carry_in(carry[level][WIDTH_M-2]), .sum(sum[level][WIDTH_M-1]), .carry_out(carry[level][WIDTH_M-1]));
            half_adder ha_fin_last(.a(carry[level][WIDTH_M-1]), .b(1'b1), .sum(sum[level+1][WIDTH_M-1]), .carry(carry[level+1][WIDTH_M-1]));
        
        end else begin
            // Handle general levels of addition
            half_adder ha_inst(.a(partial_products[level+1][0]), .b(sum[level-1][1]), .sum(sum[level][0]), .carry(carry[level][0]));
            
            // iterate the loop 14 times(from 1 to WIDTH_M-1) as each level has 15 full adders and last full adder has different input from these 14 
            for (n = 1; n < WIDTH_M-1; n++) begin
                full_adder fa_inst(.a(sum[level-1][n+1]), .b(partial_products[level+1][n]), .carry_in(carry[level][n-1]), .sum(sum[level][n]), .carry_out(carry[level][n]));
            end

            // Final full adder for general levels
            full_adder fa_inst_last(.a(carry[level-1][WIDTH_M-1]), .b(partial_products[level+1][WIDTH_M-1]), .carry_in(carry[level][WIDTH_M-2]), .sum(sum[level][WIDTH_M-1]), .carry_out(carry[level][WIDTH_M-1]));
        
        end
    end
endgenerate

// Generate block for assigning final product bits
generate
    genvar x, y;
    // Set the least significant bit of the product
    assign product[0] = partial_products[0][0]; // LSB
    
    // Assign bits from the sum array for lower part of the product
    for (x = 1; x < WIDTH_M; x++) begin
        assign product[x] = sum[x-1][0];
    end

    // Assign bits from the sum array for upper part of the product
    for (y = 1; y < WIDTH_M; y++) begin
        assign product[y+15] = sum[WIDTH_M-2][y];
    end
    // Set the most significant bit of the product
    assign product[WIDTH_P-1] = sum[WIDTH_M-1][WIDTH_M-1];
endgenerate

endmodule
