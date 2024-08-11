module combinational_multiplier(
    input logic [15:0] a,
    input logic [15:0] b,
    output logic [31:0] product
);
    // Define an array of wires to hold partial products
    // Here, partial is an array with 16 elements, each element being a signed 32-bit vector
    wire signed [31:0] partial [15:0];
    genvar i; // Generate variable i
    
    generate // Generate block for a for loop
        for (i = 0; i < 16; i = i + 1) begin : gen_partial
            // Calculate partial products
            // If a[i] is 1, sign-extend b to 32 bits, shift left by i, else assign zero
            assign partial[i] = a[i] ? {{16{b[15]}}, b} << i : 32'b0;
        end
    endgenerate

    // Sum up all partial products to get the final product
    // Handle the 2's complement of partial[15] and add it to the result
    assign product = partial[0]  + partial[1]  + partial[2]  + partial[3] + 
                     partial[4]  + partial[5]  + partial[6]  + partial[7] + 
                     partial[8]  + partial[9]  + partial[10] + partial[11] + 
                     partial[12] + partial[13] + partial[14] + (~partial[15] + 1); // Apply 2's complement to partial[15]

endmodule
