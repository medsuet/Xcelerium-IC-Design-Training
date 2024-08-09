module combinational_multiplier (
    input logic [15:0] A, B,
    output logic [31:0] P
);
localparam NUM_LEVELS = 15;
//intermediate wires
logic [15:0] carry [15:0];
logic [15:0] sum [15:0];
logic c_lh,sum_lh;
// Partial products
logic [15:0] andResult [15:0]; 
genvar i,j;
generate
   for(i = 0; i < 16; i = i + 1) begin 
      for(j = 0; j < 16; j = j + 1) begin 
         if (i == 15 && j == 15)
            assign andResult[i][j] = A[i] & B[j];
         else if (i == 15 | j == 15)
            assign andResult[i][j] = ~(A[i] & B[j]);
         else
            assign andResult[i][j] = A[j] & B[i];
      end
   end
endgenerate

generate

//B1 level 
half_adder HA_1( .a(andResult[0][1]),.b(andResult[1][0]),.sum(sum[0][0]),.carry(c[0][0]));
   for(i=0;i<14;i++)begin
      full_adder FA_L1( .a(andResult[0][i+2]),.b(andResult[1][i+1]),.cin(c[0][i]),.cout(c[0][i+1]),.sum(sum[0][i+1]));
    end
full_adder FA_L1_last( .a(1'd1),.b(andResult[1][15]),.cin(c[0][14]),.cout(c[0][15]),.sum(sum[0][15]));

// B2 - B14 levels 
    for (i = 3; i <= NUM_LEVELS; i = i + 1) begin : gen_adders
        half_adder HA(.a(sum[i-2][1]), .b(andResult[i][0]), .sum(sum[i-1][0]), .carry(c[i-1][0]));
        for (int j = 0; j < 14; j = j + 1) begin
            full_adder FA(.a(sum[i-2][j+2]), .b(andResult[i][j+1]), .cin(c[i-1][j]), .cout(c[i-1][j+1]), .sum(sum[i-1][j+1]));
        end
        full_adder FA_last(.a(c[i-2][15]), .b(andResult[i][15]), .cin(c[i-1][14]), .cout(c[i-1][15]), .sum(sum[i-1][15]));
    end

//Last Half Adder
half_adder HA_last( .a(1'd1),.b(c[14][15]),.sum(sum_lh),.carry(c_lh));

endgenerate

//FINAL PRODUCT
assign P =  { sum_lh,sum[14][15], sum[14][14], sum[14][13], sum[14][12],sum[14][11], sum[14][10], 
              sum[14][9], sum[14][8], sum[14][7], sum[14][6], sum[14][5], sum[14][4], sum[14][3], 
              sum[14][2], sum[14][1],  sum[14][0],
              sum[13][0], sum[12][0], sum[11][0],sum[10][0], sum[9][0], sum[8][0], sum[7][0],
              sum[6][0], sum[5][0],sum[4][0],sum[3][0],sum[2][0],sum[1][0],sum[0][0],andResult[0][0]};

endmodule