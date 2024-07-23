module tb_comb_16bit_mul;

 // define inputs and output
    logic [15:0] multiplicand, multiplier;
    logic [31:0] product;

   
// instantiation
    comb_16bit_mul UUT (
        .input1(multiplicand),
        .input2(multiplier),
        .product(product)
    );

// Test cases    
    initial begin
        // Test cases -5 * 3
        multiplicand = -16'd5; multiplier = 16'd3; // Expected output: input1 = fffb, input2 = 0003, Product = fffffff1
        #10;
        // Test case -16 * -73
        multiplicand = -16'd230; multiplier = -16'd73; // Expected output: input1 = ff1a, input2 = ffb7, Product = 00004196
        #10;
        // Test case 67 * -16
        multiplicand = 16'd67; multiplier = -16'd799; // Expected output: input1 = 0043, input2 = fce1, Product = ffff2ee3
        #10;
        // Test case 5123 * 3678
        multiplicand = 16'd5123; multiplier = 16'd3678; // Expected output: input1 = 1403, input2 = 0e5e, Product = 011f831a
        #10;
        // Test case -12345 * 12345
        multiplicand = -16'd12345; multiplier = 16'd12345; 
        #10;
        $finish;
    end

     // Result will be in hexadecimal
    initial begin
        $monitor("input1 = %h, input2 = %h, Product = %h", multiplicand, multiplier, product);
    end

endmodule
