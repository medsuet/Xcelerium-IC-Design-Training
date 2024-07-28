module combinational_multiplier_tb();
    logic [15:0] a;
    logic [15:0] b;
    logic  [31:0] product;

    combinational_multiplier uut (
        .a(a),
        .b(b),
        .product(product)
    );

    initial begin
        // Test case 1
        a = -3;
        b = 3;
        #10;
        
        // Test case 2
        a = 4;
        b = 5;
        #10;
//
        // Test case 3
        a = -5;
        b = -2;
        #10;
//
        // Test case 4
        a = 3;
        b = -3;
        #10;
        // Test case 5
        a = 8;
        b = -2;
        #10;
        for(i = 0;i<200;i=(i+1)) begin
            a = $random;
            b = $random;
            #10;
        end
        $finish;
    end
endmodule