// `timescale 1ns/1ps

module signed_comb_multiplier_tb;
    // Testbench for the signed_multiplier module

    // Inputs to the multiplier
    logic [15:0] multiplicand;   // Multiplicand input
    logic [15:0] multiplier;     // Multiplier input

    // Output from the multiplier
    logic [31:0] product;        // Product output

    // Intermediate signals for signed values
    logic signed [15:0] signed_multiplicand; // Signed version of multiplicand
    logic signed [15:0] signed_multiplier;   // Signed version of multiplier
    logic signed [31:0] signed_product;      // Signed version of product
    logic signed [31:0] expected_product;    // Expected product for comparison

    // Instantiate the signed_multiplier module
    signed_comb_multiplier uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );

    // Convert unsigned inputs and output to signed for comparison
    assign signed_multiplicand = $signed(multiplicand);
    assign signed_multiplier = $signed(multiplier);
    assign signed_product = $signed(product);

    // Seed for the random number generator
    integer seed;

    initial begin
        // Initialize inputs
        multiplicand = 0;
        multiplier = 0;
        seed = 12345; // Seed value for random number generation (can be changed)

        // Display headers for the output
        $display("Time\tMultiplicand\tMultiplier\tProduct\t\t\t\tExpected");

        // Generate random test cases
        for (int i = 0; i < 10; i++) begin
            // Update seed for each iteration to get different random values
            seed = 12345 + i;

            // Generate random values for multiplicand and multiplier
            // Mask to keep only positive values (0 to 32767)
            multiplicand = ($random(seed) % 32768) & 16'h7FFF;
            multiplier = ($random(seed) % 32768) & 16'h7FFF;
            
            // Randomly decide to make values positive or negative
            if (i < 4) begin
                // Case 1: Both positive
                multiplicand = multiplicand;
                multiplier = multiplier;
            end else if (i < 6) begin
                // Case 2: Multiplicand negative, multiplier positive
                multiplicand = ~multiplicand;
                multiplier = multiplier;
            end else if (i < 8) begin
                // Case 3: Multiplicand positive, multiplier negative
                multiplicand = multiplicand;
                multiplier = ~multiplier;
            end else begin
                // Case 4: Both negative
                multiplicand = ~multiplicand;
                multiplier = ~multiplier;
            end

            // Compute the expected product
            expected_product = signed_multiplicand * signed_multiplier;

            // Wait for the multiplication to be computed
            #10;

            // Display the results
            $monitor("%0d\t%0d\t\t%0d\t\t%0d\t\t%0d\t\t",
                     $time, signed_multiplicand, signed_multiplier, signed_product,
                     expected_product);

        end

        // Stop the simulation after the test cases are run
        #10 $stop;
    end

    initial begin
        // Dump waveform data to a VCD file for simulation analysis
        $dumpfile("waveform.vcd");
        $dumpvars(0, signed_comb_multiplier_tb);
    end
endmodule
