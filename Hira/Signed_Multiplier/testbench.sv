module tb_wallace_Tree_Multiplier;
    logic [15:0] Multiplier;
    logic [15:0] Multiplicant;
    logic [31:0] Product;
    int i;
    int expected_product;

    // Instantiate the module
    wallace_Tree_Multiplier multiplier_inst (
        .Multiplier(Multiplier),
        .Multiplicant(Multiplicant),
        .result(Product)
    );

    initial begin

        // Generate and test random numbers
        for (i = 0; i < 10; i = i + 1) begin
            // Generate random operands
            Multiplier = $random / 16'd 65536;
            Multiplicant = $random / 16'd 65536;

            // Compute the expected product
            expected_product = Multiplier * Multiplicant;

            #10; // Wait for some time to observe the result

            // Display the inputs and results
            $display("Multiplier: %d, Multiplicant: %d, Product: %d", Multiplier, Multiplicant, Product);

            // Check if the result is as expected
            if (Product === expected_product) begin
                $display("PASS: The result is correct.");
            end else begin
                $display("FAIL: Expected %d but got %d.", expected_product, Product);
            end
        end

        // End the simulation
        $finish;
    end
endmodule
