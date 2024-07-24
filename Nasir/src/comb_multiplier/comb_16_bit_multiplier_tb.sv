module comb_16_bit_multiplier_tb;

    logic [15:0] multiplicand1, multiplier1;
    logic [31:0] product1;

    localparam period = 10;

    comb_16_bit_multiplier UUT (
        .multiplicand(multiplicand1),
        .multiplier(multiplier1),
        .product(product1)
    );

    initial begin
        // Test cases
        multiplicand1 = -16'd5; multiplier1 = 16'd3;
        #period;
        multiplicand1 = -16'd230; multiplier1 = -16'd73;
        #period;
        multiplicand1 = 16'd67; multiplier1 = -16'd799;
        #period;
        multiplicand1 = 16'd5123; multiplier1 = 16'd3678;
        #period;
        multiplicand1 = 16'hffff; multiplier1 = 16'hffff;
        #period;
        $finish;
    end
    
    initial begin
        $monitor("multiplicand = %h, multiplier = %h, product = %h", multiplicand1, multiplier1, product1);
    end

endmodule
