module comb_16bit_mul (
    input logic signed [15:0] input1, 
    input logic signed [15:0] input2,
    output logic signed [31:0] product
);
    
    logic [15:0] partialProduct [15:0]; // for partial products
    logic [31:0] sum [15:0]; // for intermediate sum
    logic signed [15:0] unsignedInput1, unsignedInput2; // for storing after complement if taken

    // Extract sign bits
    logic signBit1;
    assign signBit1 = input1[15]; // extract the sign bit of input1 (multiplicand)
    logic signBit2;
    assign signBit2 = input2[15]; // extract the sign bit of input2 (multiplier)

    // taking decision if 2's complement is necessory or not
    logic selectonBit; // decision bit to take 2's complement or not
    assign selectonBit = signBit1 ^ signBit2;

    // Take absolute values if necessary
    // if negtive numbers, then make unsigned numbers by taking 2's complement
    always_comb begin
        if (signBit1) begin
            unsignedInput1 = ~input1 + 1; // make unsign number from signed number
        end 
        else begin
            unsignedInput1 = input1;
        end

        if (signBit2) begin // make unsign number from signed number
            unsignedInput2 = ~input2 + 1;
        end 
        else begin
            unsignedInput2 = input2;
        end
    end

   
    // Generate partial products
    generate
        for (genvar i = 0; i < 16; i = i + 1) begin : gen_partial_products
            assign partialProduct[i] = unsignedInput1 & {16{unsignedInput2[i]}};
        end
    endgenerate

    // Initialize sum[0]
    assign sum[0] = {16'b0, partialProduct[0]};

    // Generate sums
    generate
        for (genvar i = 1; i < 16; i = i + 1) begin : gen_sums
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
