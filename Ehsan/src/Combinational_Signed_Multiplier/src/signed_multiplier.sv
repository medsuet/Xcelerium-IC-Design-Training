module signed_multiplier (
    input [15:0] multiplicand, multiplier,
    output [31:0] product
);

logic [15:0] sum  [14:0];  //sum out of adder modules
logic [15:0] cout [14:0]; //carry out of adder modules
logic last_carry;         //last full adder carry 
logic [15:0]  pp [15:0];  //partial products

//generating partial products
genvar i,j;
generate
for (i=0; i<15; i++) begin
    for (j=0; j<15; j++) begin  
        assign pp [i][j] = multiplicand[j] & multiplier[i];
    end
end

for (i=0; i<15; i++) begin  
    assign pp [i][15] = ~(multiplicand[15] & multiplier[i]);
    assign pp [15][i] = ~(multiplicand[i] & multiplier[15]);   
end
assign pp [15][15] = (multiplicand[15] & multiplier[15]);
endgenerate


//adding partial products
genvar n;
generate    
    
//for loop from level 0 to level 14
for (n=1; n<15; n++) begin
    fa fa_0 (.a(pp[0][n+1]),    .b(pp[1][n]),   .cin(cout[0][n-1]),   .sum(sum[0][n]),   .cout(cout[0][n]));
    fa fa_1 (.a(sum[0][n+1]),   .b(pp[2][n]),   .cin(cout[1][n-1]),   .sum(sum[1][n]),   .cout(cout[1][n]));
    fa fa_2 (.a(sum[1][n+1]),   .b(pp[3][n]),   .cin(cout[2][n-1]),   .sum(sum[2][n]),   .cout(cout[2][n]));
    fa fa_3 (.a(sum[2][n+1]),   .b(pp[4][n]),   .cin(cout[3][n-1]),   .sum(sum[3][n]),   .cout(cout[3][n]));
    fa fa_4 (.a(sum[3][n+1]),   .b(pp[5][n]),   .cin(cout[4][n-1]),   .sum(sum[4][n]),   .cout(cout[4][n]));
    fa fa_5 (.a(sum[4][n+1]),   .b(pp[6][n]),   .cin(cout[5][n-1]),   .sum(sum[5][n]),   .cout(cout[5][n]));
    fa fa_6 (.a(sum[5][n+1]),   .b(pp[7][n]),   .cin(cout[6][n-1]),   .sum(sum[6][n]),   .cout(cout[6][n]));
    fa fa_7 (.a(sum[6][n+1]),   .b(pp[8][n]),   .cin(cout[7][n-1]),   .sum(sum[7][n]),   .cout(cout[7][n]));
    fa fa_8 (.a(sum[7][n+1]),   .b(pp[9][n]),   .cin(cout[8][n-1]),   .sum(sum[8][n]),   .cout(cout[8][n]));
    fa fa_9 (.a(sum[8][n+1]),   .b(pp[10][n]),  .cin(cout[9][n-1]),   .sum(sum[9][n]),   .cout(cout[9][n]));
    fa fa_10(.a(sum[9][n+1]),   .b(pp[11][n]),  .cin(cout[10][n-1]),  .sum(sum[10][n]),  .cout(cout[10][n]));
    fa fa_11(.a(sum[10][n+1]),  .b(pp[12][n]),  .cin(cout[11][n-1]),  .sum(sum[11][n]),  .cout(cout[11][n]));
    fa fa_12(.a(sum[11][n+1]),  .b(pp[13][n]),  .cin(cout[12][n-1]),  .sum(sum[12][n]),  .cout(cout[12][n]));
    fa fa_13(.a(sum[12][n+1]),  .b(pp[14][n]),  .cin(cout[13][n-1]),  .sum(sum[13][n]),  .cout(cout[13][n]));
    fa fa_14(.a(sum[13][n+1]),  .b(pp[15][n]),  .cin(cout[14][n-1]),  .sum(sum[14][n]),  .cout(cout[14][n]));
end

    //level 0
    ha ha0(.a(pp[0][1]),      .b(pp[1][0]),  .sum(sum[0][0]),     .cout(cout[0][0]));
    fa fa0(.a(1'b1),          .b(pp[1][15]), .cin(cout[0][14]),   .sum(sum[0][15]),     .cout(cout[0][15]));

    //level 1
    ha ha1(.a(pp[2][0]),      .b(sum[0][1]), .sum(sum[1][0]),     .cout(cout[1][0]));
    fa fa1(.a(cout[0][15]),   .b(pp[2][15]), .cin(cout[1][14]),   .sum(sum[1][15]),     .cout(cout[1][15]));

    //level 2
    ha ha2(.a(pp[3][0]),      .b(sum[1][1]), .sum(sum[2][0]),     .cout(cout[2][0]));
    fa fa2(.a(cout[1][15]),   .b(pp[3][15]), .cin(cout[2][14]),   .sum(sum[2][15]),     .cout(cout[2][15]));

    //level 3
    ha ha3(.a(pp[4][0]),      .b(sum[2][1]), .sum(sum[3][0]),     .cout(cout[3][0]));
    fa fa3(.a(cout[2][15]),   .b(pp[4][15]), .cin(cout[3][14]),   .sum(sum[3][15]),     .cout(cout[3][15]));

    //level 4
    ha ha4(.a(pp[5][0]),      .b(sum[3][1]), .sum(sum[4][0]),     .cout(cout[4][0]));
    fa fa4(.a(cout[3][15]),   .b(pp[5][15]), .cin(cout[4][14]),   .sum(sum[4][15]),     .cout(cout[4][15]));

    //level 5
    ha ha5(.a(pp[6][0]),      .b(sum[4][1]), .sum(sum[5][0]),     .cout(cout[5][0]));
    fa fa5(.a(cout[4][15]),   .b(pp[6][15]), .cin(cout[5][14]),   .sum(sum[5][15]),     .cout(cout[5][15]));

    //level 6
    ha ha6(.a(pp[7][0]),      .b(sum[5][1]), .sum(sum[6][0]),     .cout(cout[6][0]));
    fa fa6(.a(cout[5][15]),   .b(pp[7][15]), .cin(cout[6][14]),   .sum(sum[6][15]),     .cout(cout[6][15]));

    //level 7
    ha ha7(.a(pp[8][0]),      .b(sum[6][1]), .sum(sum[7][0]),     .cout(cout[7][0]));
    fa fa7(.a(cout[6][15]),   .b(pp[8][15]), .cin(cout[7][14]),   .sum(sum[7][15]),     .cout(cout[7][15]));

    //level 8
    ha ha8(.a(pp[9][0]),      .b(sum[7][1]), .sum(sum[8][0]),     .cout(cout[8][0]));
    fa fa8(.a(cout[7][15]),   .b(pp[9][15]), .cin(cout[8][14]),   .sum(sum[8][15]),     .cout(cout[8][15]));

    //level 9
    ha ha9(.a(pp[10][0]),     .b(sum[8][1]),  .sum(sum[9][0]),    .cout(cout[9][0]));
    fa fa9(.a(cout[8][15]),   .b(pp[10][15]), .cin(cout[9][14]),  .sum(sum[9][15]),     .cout(cout[9][15]));

    //level 10
    ha ha10(.a(pp[11][0]),    .b(sum[9][1]),  .sum(sum[10][0]),   .cout(cout[10][0]));
    fa fa10(.a(cout[9][15]),  .b(pp[11][15]), .cin(cout[10][14]), .sum(sum[10][15]),   .cout(cout[10][15]));

    //level 11
    ha ha11(.a(pp[12][0]),    .b(sum[10][1]), .sum(sum[11][0]),   .cout(cout[11][0]));
    fa fa11(.a(cout[10][15]), .b(pp[12][15]), .cin(cout[11][14]), .sum(sum[11][15]),   .cout(cout[11][15]));

    //level 12
    ha ha12(.a(pp[13][0]),    .b(sum[11][1]), .sum(sum[12][0]),   .cout(cout[12][0]));
    fa fa12(.a(cout[11][15]), .b(pp[13][15]), .cin(cout[12][14]), .sum(sum[12][15]),   .cout(cout[12][15]));

    //level 13
    ha ha13(.a(pp[14][0]),    .b(sum[12][1]), .sum(sum[13][0]),   .cout(cout[13][0]));
    fa fa13(.a(cout[12][15]), .b(pp[14][15]), .cin(cout[13][14]), .sum(sum[13][15]),   .cout(cout[13][15]));

    //level 14
    ha ha14(.a(pp[15][0]),    .b(sum[13][1]), .sum(sum[14][0]),   .cout(cout[14][0]));
    fa fa14(.a(cout[13][15]), .b(pp[15][15]), .cin(cout[14][14]), .sum(sum[14][15]),   .cout(cout[14][15]));

endgenerate

//last half adder
ha ha_last(.a(1'b1), .b(cout[14][15]), .sum(last_carry), .cout());

//concatinating bits to form product
assign product = {  last_carry,  sum[14][15], sum[14][14], sum[14][13], sum[14][12],
                    sum[14][11], sum[14][10], sum[14][9],  sum[14][8],  sum[14][7], 
                    sum[14][6],  sum[14][5],  sum[14][4],  sum[14][3],  sum[14][2], 
                    sum[14][1],  sum[14][0],  sum[13][0],  sum[12][0],  sum[11][0],
                    sum[10][0],  sum[9][0],   sum[8][0],   sum[7][0],   sum[6][0], 
                    sum[5][0],   sum[4][0],   sum[3][0],   sum[2][0],   sum[1][0],  
                    sum[0][0],   pp[0][0]};

endmodule
