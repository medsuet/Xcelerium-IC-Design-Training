module comb_16_bit_multiplier (
    input logic signed [15:0] multiplicand, 
    input logic signed [15:0] multiplier,
    output logic signed [31:0] product
);
    // Partial products 
    logic [15:0] partialProduct [15:0];
    logic signed [15:0] unsignedMultiplicand, unsignedMultiplier;

    // Extract sign bits
    logic signBitMultiplicand;
    assign signBitMultiplicand = multiplicand[15]; // extract sign bit of multiplicand
    logic signBitMultiplier;
    assign signBitMultiplier = multiplier[15]; // extract sign bit of multiplier
    // selection for taking twos complement of product if necessary
    logic selectonBit;
    assign selectonBit = signBitMultiplicand ^ signBitMultiplier; // taking xor of sign bits

    // Take absolute values if necessary
    // if negtive numbers make them unsigned numbers by twos complement
    // if sign bit is then negative numbers make them unsigned numbers using twoscomplement
    always_comb begin
        if (signBitMultiplicand) begin
            unsignedMultiplicand = ~multiplicand + 1;
        end else begin
            unsignedMultiplicand = multiplicand;
        end

        if (signBitMultiplier) begin
            unsignedMultiplier = ~multiplier + 1;
        end else begin
            unsignedMultiplier = multiplier;
        end
    end

    // Intermediate sums
    logic [31:0] sum [15:0];

    // Generate partial products
    // there are 16 rows of partial sum so we using for loop
    generate
        for (genvar i = 0; i < 16; i = i + 1) begin : generatePartialProducts
            assign partialProduct[i] = unsignedMultiplicand & {16{unsignedMultiplier[i]}};
        end
    endgenerate

    // Initialize sum[0]
    assign sum[0] = {16'b0, partialProduct[0]};

    // Generate sums
    generate
        for (genvar i = 1; i < 16; i = i + 1) begin : generateSums
            assign sum[i] = sum[i-1] + ({16'b0, partialProduct[i]} << i);
        end
    endgenerate

    // Final product
    always_comb begin
        product = sum[15];
        if (selectonBit) begin
            product = ~product + 1;
        end
    end

endmodule
