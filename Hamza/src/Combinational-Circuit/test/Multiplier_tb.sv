`timescale 1ns/1ps

module signed_16bit_multiplier_tb();

    // Inputs
    logic signed [15:0] multiplier, multiplicand;
    // Output
    logic signed [31:0] product;
    
    logic signed [31:0] expected_product;
    
    // Instantiation
    signed_16bit_multiplier uut (
        .A(multiplicand),
        .B(multiplier),
        .product(product)
    );

    // Dump variables for GTKWave
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, signed_16bit_multiplier_tb);
    end

    initial begin
        // Test case: Both positive
        multiplier = 16'd1000;
        multiplicand = 16'd2000;
        expected_product = multiplicand * multiplier;
        #10;
        if (product !== expected_product) begin
            $display("Mismatch: multiplicand=%d, multiplier=%d, expected=%d, got=%d",
                     multiplicand, multiplier, expected_product, product);
        end else begin
            $display("Match: multiplicand=%d, multiplier=%d, product=%d",
                     multiplicand, multiplier, product);
        end

        // Test case: First negative
        multiplier = -16'd1000;
        multiplicand = 16'd2000;
        expected_product = multiplicand * multiplier;
        #10;
        if (product !== expected_product) begin
            $display("Mismatch: multiplicand=%d, multiplier=%d, expected=%d, got=%d",
                     multiplicand, multiplier, expected_product, product);
        end else begin
            $display("Match: multiplicand=%d, multiplier=%d, product=%d",
                     multiplicand, multiplier, product);
        end

        // Test case: Second negative
        multiplier = 16'd1000;
        multiplicand = -16'd2000;
        expected_product = multiplicand * multiplier;
        #10;
        if (product !== expected_product) begin
            $display("Mismatch: multiplicand=%d, multiplier=%d, expected=%d, got=%d",
                     multiplicand, multiplier, expected_product, product);
        end else begin
            $display("Match: multiplicand=%d, multiplier=%d, product=%d",
                     multiplicand, multiplier, product);
        end

        // Test case: Both negative
        multiplier = -16'd1000;
        multiplicand = -16'd2000;
        expected_product = multiplicand * multiplier;
        #10;
        if (product !== expected_product) begin
            $display("Mismatch: multiplicand=%d, multiplier=%d, expected=%d, got=%d",
                     multiplicand, multiplier, expected_product, product);
        end else begin
            $display("Match: multiplicand=%d, multiplier=%d, product=%d",
                     multiplicand, multiplier, product);
        end

        // Test case: Zero multiplicand
        multiplier = 16'd0;
        multiplicand = -16'd500;
        expected_product = multiplicand * multiplier;
        #10;
        if (product !== expected_product) begin
            $display("Mismatch: multiplicand=%d, multiplier=%d, expected=%d, got=%d",
                     multiplicand, multiplier, expected_product, product);
        end else begin
            $display("Match: multiplicand=%d, multiplier=%d, product=%d",
                     multiplicand, multiplier, product);
        end

        // Test case: Zero multiplier
        multiplier = -16'd500;
        multiplicand = 16'd0;
        expected_product = multiplicand * multiplier;
        #10;
        if (product !== expected_product) begin
            $display("Mismatch: multiplicand=%d, multiplier=%d, expected=%d, got=%d",
                     multiplicand, multiplier, expected_product, product);
        end else begin
            $display("Match: multiplicand=%d, multiplier=%d, product=%d",
                     multiplicand, multiplier, product);
        end

        // Edge case: Largest positive numbers
        multiplier = 16'd32767;
        multiplicand = 16'd32767;
        expected_product = multiplicand * multiplier;
        #10;
        if (product !== expected_product) begin
            $display("Mismatch: multiplicand=%d, multiplier=%d, expected=%d, got=%d",
                     multiplicand, multiplier, expected_product, product);
        end else begin
            $display("Match: multiplicand=%d, multiplier=%d, product=%d",
                     multiplicand, multiplier, product);
        end

        // Edge case: Largest negative and positive
        multiplier = -16'd32768;
        multiplicand = 16'd32767;
        expected_product = multiplicand * multiplier;
        #10;
        if (product !== expected_product) begin
            $display("Mismatch: multiplicand=%d, multiplier=%d, expected=%d, got=%d",
                     multiplicand, multiplier, expected_product, product);
        end else begin
            $display("Match: multiplicand=%d, multiplier=%d, product=%d",
                     multiplicand, multiplier, product);
        end

        // Edge case: Largest negative numbers
        multiplier = -16'd32768;
        multiplicand = -16'd32768;
        expected_product = multiplicand * multiplier;
        #10;
        if (product !== expected_product) begin
            $display("Mismatch: multiplicand=%d, multiplier=%d, expected=%d, got=%d",
                     multiplicand, multiplier, expected_product, product);
        end else begin
            $display("Match: multiplicand=%d, multiplier=%d, product=%d",
                     multiplicand, multiplier, product);
        end

        for (int i = 0; i < 10; i++) begin
            multiplier = $random;
            multiplicand = $random;
            expected_product = multiplicand * multiplier;
            #10;
            if (product !== expected_product) begin
                $display("Mismatch: multiplicand=%d, multiplier=%d, expected=%d, got=%d",
                         multiplicand, multiplier, expected_product, product);
            end else begin
                $display("Match: multiplicand=%d, multiplier=%d, product=%d",
                         multiplicand, multiplier, product);
            end
        end

        // Ending the simulation
        $stop;
    end

endmodule
