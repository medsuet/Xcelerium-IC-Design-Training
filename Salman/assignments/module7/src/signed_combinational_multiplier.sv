module signed_combinational_multiplier (
    input logic signed [15:0] A,               // 16 bit signed input 'a'
    input logic signed [15:0] B,               // 16 bit signed input 'b'
    output logic signed [31:0] P               // 32 bit signed output 'P' (Product)
);

    // There will be 16 AND Rows
    // Each row will contain AND of 16 bits with a single bit (extended)
    logic [15:0] AND_RESULT [15:0];     // 16 AND Rows (rows), 16 Results (cols)

	// 15 number of 16-bit Arrays
    logic [15:0] ADDER_RESULT [14:0];   // 15 Adder Rows (rows), 16 Adders in each row (cols)
    logic [15:0] CARRY_RESULT [14:0];   // 15 Adder Rows (rows), 16 Carries in each row (cols)
    logic sum_last;                     // Last Half Adder's Sum
    logic carry_last;                   // Last Half Adder's Carry

    genvar i, j;                        // Variables for generate for loops

    // Logic for AND & NAND Gates

    // AND Gates
    generate
        for (i = 0; i < 15; i++) begin : and_gen
            // 1 NAND, 14 AND - Concatenated into a single signal
            assign AND_RESULT[i] = { ~(A[15] & B[i]), A[14:0] & {15{B[i]}} };
            // 14 NAND Gates at end of 14 rows
        end
    endgenerate

    // 15 @[0:14] NAND GATES for Last Row
    assign AND_RESULT[15] = { A[15] & B[15], ~(A[14:0] & {15{B[15]}}) };
    // 1 AND GATE @[15] for Last Row

    // LOGIC for First Row (Special Case)
    half_adder half_adder_first(
        .a(AND_RESULT[0][1]),      // A1.B0
        .b(AND_RESULT[1][0]),      // A0.B1
        .s(ADDER_RESULT[0][0]),    // (0,0)
        .c(CARRY_RESULT[0][0])     // (0,0)
    );

    // Special Case (1st row)
    generate
        for (i = 1; i < 15; i++) begin : adder_gen_0
            full_adder full_adder_first(
                .a(AND_RESULT[0][i+1]),       // B0 . Ai+1
                .b(AND_RESULT[1][i]),         // B1 . Ai
                .c_in(CARRY_RESULT[0][i-1]),  // Input Carry from prev Adder
                .s(ADDER_RESULT[0][i]),       // Current Adder Sum Result
                .c_out(CARRY_RESULT[0][i])    // Current Adder Carry Result
            );
        end
    endgenerate

    // Special Case: Last (15th) Full Adder in 1st row (Yellow Filled)
    full_adder full_adderx_first(
        .a(1'b1),                          // 1'b1
        .b(AND_RESULT[1][15]),             // ~(B1 . A15)
        .c_in(CARRY_RESULT[0][14]),        // Input Carry from prev Adder (2nd last - 14th)
        .s(ADDER_RESULT[0][15]),           // Current Adder Sum Result
        .c_out(CARRY_RESULT[0][15])        // Current Adder Carry Result
    );

    // Logic for 2nd row to ending (15th) row [1:14]
    generate
        for (i = 1; i < 15; i++) begin : row_gen
            // Half Adder at start
            half_adder half_adderx(
                .a(AND_RESULT[i+1][0]),         // Input: Bi+1 . A0
                .b(ADDER_RESULT[i-1][1]),       // Input: Upper FA Sum Result
                .s(ADDER_RESULT[i][0]),         // Output: Current Adder Sum Result
                .c(CARRY_RESULT[i][0])          // Output: Current Adder Carry Result
            );

            for (j = 1; j < 15; j++) begin : col_gen
                full_adder full_adderx(
                    .a(AND_RESULT[i+1][j]),       // Input: Bi+1 . Aj
                    .b(ADDER_RESULT[i-1][j+1]),   // Input: Upper FA Sum Result
                    .c_in(CARRY_RESULT[i][j-1]),  // Input: Carry from prev Adder
                    .s(ADDER_RESULT[i][j]),       // Output: Current Adder Sum Result
                    .c_out(CARRY_RESULT[i][j])    // Output: Current Adder Carry Result
                );
            end
            
            // Full Adder at end (Special Case for each row)
            full_adder full_addery(
                .a(AND_RESULT[i+1][15]),       // Input: Bi+1 . A15
                .b(CARRY_RESULT[i-1][15]),     // Input: Upper FA Carry Result (Last FA)
                .c_in(CARRY_RESULT[i][14]),    // Input: Carry from prev Adder
                .s(ADDER_RESULT[i][15]),       // Output: Current Adder Sum Result
                .c_out(CARRY_RESULT[i][15])    // Output: Current Adder Carry Result
            );
        end
    endgenerate

    // Last Row, Last Half Adder
    half_adder half_addery(
        .a(1'b1),                          // Input: 1'b1
        .b(CARRY_RESULT[14][15]),          // Input: Prev Adder Carry Result (Last Full Adder)
        .s(sum_last),                      // Output: Current Adder Sum Result
        .c(carry_last)                     // Output: Current Adder Carry Result
    );

    // Compiling results of each Half Adder to P[0:31]
    // P0
    assign P[0] = AND_RESULT[0][0];

    // P31
    assign P[31] = sum_last;

    // P1 to P14
    generate
        for (i = 0; i < 14; i++) begin : p_gen_0_to_14
            assign P[i+1] = ADDER_RESULT[i][0];
        end
    endgenerate

    // P15 to P30
    generate
        for (i = 0; i < 16; i++) begin : p_gen_15_to_30
            assign P[i+15] = ADDER_RESULT[14][i];
        end
    endgenerate

endmodule
