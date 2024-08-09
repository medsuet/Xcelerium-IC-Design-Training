module signed_16bit_multiplier(
    input logic [15:0] A,  // 16-bit signed multiplicand
    input logic [15:0] B,  // 16-bit signed multiplier
    output logic [31:0] product  // 32-bit signed product
);

    logic [15:0] pp [15:0]; // For partial products
    logic [15:0] sum [15:0];
    logic [15:0] cout [15:0];


genvar i, j;
generate
    for (i = 0; i < 16; i++) begin
        for (j = 0; j < 16; j++) begin
            if (i == 15 || j == 15) begin
                if (i == 15 && j == 15) begin
                    assign pp[15][15] = (A[15] & B[15]);
                end else if (i == 15) begin
                    assign pp[15][j] = ~(A[j] & B[15]);
                end else begin
                    assign pp[i][15] = ~(A[15] & B[i]);
                end
            end else begin
                assign pp[i][j] = A[j] & B[i];
            end
        end
    end
endgenerate


genvar n, level;
generate

    // Levels 0 to 13
    for (level = 0; level < 14; level = level + 1) begin

        if (level == 0) begin
            ha ha_inst(.a(pp[0][1]), .b(pp[1][0]), .sum(sum[0][0]), .cout(cout[0][0]));

            for (n = 1; n < 15; n = n + 1) begin
                fa fa_inst(.a(pp[0][n+1]), .b(pp[1][n]), .cin(cout[0][n-1]), .sum(sum[0][n]), .cout(cout[0][n]));
            end

            fa fa_last_inst(.a(1'b1), .b(pp[1][15]), .cin(cout[0][14]), .sum(sum[0][15]), .cout(cout[0][15]));
        end
        else begin
            ha ha_inst(.a(pp[level+1][0]), .b(sum[level-1][1]), .sum(sum[level][0]), .cout(cout[level][0]));

            for (n = 1; n < 15; n = n + 1) begin
                fa fa_inst(.a(sum[level-1][n+1]), .b(pp[level+1][n]), .cin(cout[level][n-1]), .sum(sum[level][n]), .cout(cout[level][n]));
            end

            fa fa_last_inst(.a(cout[level-1][15]), .b(pp[level+1][15]), .cin(cout[level][14]), .sum(sum[level][15]), .cout(cout[level][15]));
        end
    end

    // Level 14
    ha ha14(.a(pp[15][0]), .b(sum[13][1]), .sum(sum[14][0]), .cout(cout[14][0]));

    for (n = 1; n < 15; n = n + 1) begin
        fa fa_inst(.a(sum[13][n+1]), .b(pp[15][n]), .cin(cout[14][n-1]), .sum(sum[14][n]), .cout(cout[14][n]));
    end

    fa fa14_inst(.a(cout[13][15]), .b(pp[15][15]), .cin(cout[14][14]), .sum(sum[14][15]), .cout(cout[14][15]));

    // Handle MSB for signed multiplication
    // Final half-adder for MSB
    ha ha_msb_inst(.a(1'b1), .b(cout[14][15]), .sum(product[31]), .cout());


endgenerate


assign product[30:0] = {sum[14][15:0], sum[13][0], sum[12][0], sum[11][0], sum[10][0], sum[9][0], sum[8][0],
                            sum[7][0], sum[6][0], sum[5][0], sum[4][0], sum[3][0], sum[2][0], sum[1][0], sum[0][0], pp[0][0]};


endmodule
// Full Adder module
module fa(
    input logic a, b, cin,
    output logic sum, cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

// Half Adder module
module ha(
    input logic a, b,
    output logic sum, cout
);
    assign sum = a ^ b;
    assign cout = a & b;
endmodule