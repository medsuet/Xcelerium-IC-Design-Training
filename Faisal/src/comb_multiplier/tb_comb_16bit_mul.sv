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
        // Range of signed 16bit -32768 ---> 32767

        // Test MAX_Neg * Max_Neg
        multiplicand = -16'd32768; multiplier = -16'd32768; // Expected output: input1 = fffb, input2 = 0003, Product = fffffff1
        #10;

        // Test MAX_Neg * Max_Pos
        multiplicand = -16'd32768; multiplier = 16'd32767; // Expected output: input1 = 8000, input2 = 8000, Product = 40000000
        #10;

        // Test MAX_Pos * Max_Neg
        multiplicand = 16'd32767; multiplier = -16'd32768; // Expected output: input1 = 7fff, input2 = 8000, Product = c0008000
        #10;

        // Test MAX_Pos * Max_Pos
        multiplicand = 16'd32767; multiplier = 16'd32767; // Expected output: input1 = 7fff, input2 = 7fff, Product = 3fff0001
        #10;

        // Test MAX_Neg * zero
        multiplicand = -16'd32768; multiplier = 16'd0; // Expected output: input1 = 8000, input2 = 0000, Product = 0000000001
        #10;
         
        // Test MAX_Neg * 1
        multiplicand = -16'd32768; multiplier = 16'd1; // Expected output: input1 = 8000, input2 = 0001, Product = ffff8000
        #10; 

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
