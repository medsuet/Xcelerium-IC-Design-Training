module wallace_Tree_Multiplier (
						  input logic [15:0] Multiplier, Multiplicant, //multiplier and multiplicand
						  output logic [31:0] result);
						  
		logic[31:0] z1;
		logic[31:0] z2;
		
		logic pp[15:0][15:0]; //partial products

		always_comb begin
			
			int i, j;
			for (i = 0; i <= 15; i = i+1)
			for (j = 0; j <= 15; j = j+1)
			pp[j][i] = Multiplier[j] & Multiplicant[i];
			end
			


wire fas[200:0];
wire has[200:0];
wire fac[200:0];
wire hac[200:0];
wire dot[200:0];

/*stage 1******************/ 
assign dot[0] = pp[0][0];
half_adder ha0( .x(pp[0][1]),  .y(pp[1][0]),  .s(has[0]), .c(hac[0]));
  genvar idx0;
  generate
    for (idx0 = 0; idx0 < 14; idx0 = idx0 + 1) begin : stage1_fa
      full_adder fa(.x(pp[0][idx0 + 2]), .y(pp[1][idx0 + 1]), .cin(pp[2][idx0]), .s(fas[idx0]), .c(fac[idx0]));
    end
  endgenerate

half_adder ha1( .x(pp[1][15]), .y(pp[2][14]), .s(has[1]), .c(hac[1]));
assign dot[1] = pp[2][15];

assign dot[2] = pp[3][0];
half_adder ha2( .x(pp[3][1]),  .y(pp[4][0]),  .s(has[2]), .c(hac[2]));

genvar idx1;
generate
  for (idx1 = 0; idx1 < 14; idx1 = idx1 + 1) begin 
    full_adder fa(.x(pp[3][idx1 + 2]), .y(pp[4][idx1 + 1]), .cin(pp[5][idx1]), .s(fas[idx1 + 14]), .c(fac[idx1 + 14]));
  end
endgenerate

half_adder ha3( .x(pp[4][15]), .y(pp[5][14]), .s(has[3]), .c(hac[3]));
assign dot[3] = pp[5][15];

assign dot[4] = pp[6][0];
half_adder ha4( .x(pp[6][1]), .y(pp[7][0]), .s(has[4]), .c(hac[4]));

genvar idx2;
generate
  for (idx2 = 0; idx2 < 14; idx2 = idx2 + 1) begin 
    full_adder fa(.x(pp[6][idx2 + 2]), .y(pp[7][idx2 + 1]), .cin(pp[8][idx2]), .s(fas[idx2 + 28]), .c(fac[idx2 + 28]));
  end
endgenerate


half_adder ha5( .x(pp[7][15]), .y(pp[8][14]), .s(has[5]), .c(hac[5]));
assign dot[5] = pp[8][15];

assign dot[6] = pp[9][0];
half_adder ha6( .x(pp[9][1]), .y(pp[10][0]), .s(has[6]), .c(hac[6]));

genvar idx3;
generate
  for (idx3 = 0; idx3 < 14; idx3 = idx3 + 1) begin 
    full_adder fa(.x(pp[9][idx3 + 2]), .y(pp[10][idx3 + 1]), .cin(pp[11][idx3]), .s(fas[idx3 + 42]), .c(fac[idx3 + 42]));
  end
endgenerate

half_adder ha7( .x(pp[10][15]), .y(pp[11][14]), .s(has[7]), .c(hac[7]));
assign dot[7] = pp[11][15];

assign dot[8] = pp[12][0];
half_adder ha8( .x(pp[12][1]), .y(pp[13][0]), .s(has[8]), .c(hac[8]));

genvar idx4;
generate
  for (idx4 = 0; idx4 < 14; idx4 = idx4 + 1) begin 
    full_adder fa(.x(pp[12][idx4 + 2]), .y(pp[13][idx4 + 1]), .cin(pp[14][idx4]), .s(fas[idx4 + 56]), .c(fac[idx4 + 56]));
  end
endgenerate

half_adder ha9( .x(pp[13][15]), .y(pp[14][14]), .s(has[9]), .c(hac[9]));
assign dot[9] = pp[14][15];

assign dot[10]  = pp[15][0];
assign dot[11] = pp[15][1];
assign dot[12] = pp[15][2];
assign dot[13] = pp[15][3];
assign dot[14] = pp[15][4];
assign dot[15] = pp[15][5];
assign dot[16] = pp[15][6];
assign dot[17] = pp[15][7];
assign dot[18] = pp[15][8];
assign dot[19] = pp[15][9];
assign dot[20] = pp[15][10];
assign dot[21] = pp[15][11];
assign dot[22] = pp[15][12];
assign dot[23] = pp[15][13];
assign dot[24] = pp[15][14];
assign dot[25] = pp[15][15];




/***********************/
/*stage 2***************/
assign dot[26] = dot[0];
assign dot[27] = has[0];
half_adder ha10(.x(fas[0]), .y(hac[0]), .s(has[10]), .c(hac[10]));
full_adder fa70(.x(fas[1]),  .y(fac[0]),  .cin(dot[2]), .s(fas[70]), .c(fac[70]));
full_adder fa71(.x(fas[2]),  .y(fac[1]),  .cin(has[2]), .s(fas[71]), .c(fac[71]));
genvar i;
generate
    for (i = 0; i <= 10; i = i + 1) begin 
        full_adder fa (.x(fas[i + 3]),.y(fac[i + 2]),.cin(fas[14 + i]),.s(fas[72 + i]),.c(fac[72 + i])
        );
    end
endgenerate

full_adder fa83(.x(has[1]),  .y(fac[13]), .cin(fas[26]), .s(fas[83]), .c(fac[83]));
full_adder fa84(.x(dot[1]),  .y(hac[1]),  .cin(fas[27]), .s(fas[84]), .c(fac[84]));

assign dot[28] = fas[28];
assign dot[29] = has[3];
assign dot[30] = dot[3];

assign dot[31] = hac[2];
half_adder ha11(.x(fac[14]), .y(dot[4]), .s(has[11]), .c(hac[11]));
half_adder ha12(.x(fac[15]), .y(has[4]), .s(has[12]), .c(hac[12]));
full_adder fa85(.x(fac[16]),  .y(fas[28]),  .cin(hac[4]), .s(fas[85]), .c(fac[85]));

genvar index6;
generate
    for (index6 = 0; index6 <= 10; index6 = index6 + 1) begin 
        full_adder fa (.x(fac[17 + index6]),.y(fas[29 + index6]),.cin(fac[28 + index6]),.s(fas[86 + index6]),.c(fac[86 + index6])
        );
    end
endgenerate

full_adder fa97(.x(hac[3]),   .y(fas[40]),  .cin(fac[39]), .s(fas[97]), .c(fac[97]));
half_adder ha13(.x(fas[41]), .y(fac[40]), .s(has[13]), .c(hac[13]));
half_adder ha14(.x(has[5]), .y(fac[41]), .s(has[14]), .c(hac[14]));
half_adder ha15(.x(dot[5]), .y(hac[5]), .s(has[15]), .c(hac[15]));

assign dot[32] = dot[6];
assign dot[33] = has[6];
half_adder ha16(.x(fas[42]), .y(hac[6]), .s(has[16]), .c(hac[16]));
full_adder fa98(.x(fas[43]), .y(fac[42]),  .cin(dot[8]), .s(fas[98]), .c(fac[98]));
full_adder fa99(.x(fas[44]), .y(fac[43]),  .cin(has[8]), .s(fas[99]), .c(fac[99]));
genvar idx7;
generate
    for (idx7 = 0; idx7 <= 10; idx7 = idx7 + 1) begin 
        full_adder fa (.x(fas[45 + idx7]),.y(fac[44 + idx7]),.cin(fas[56 + idx7]),.s(fas[100 + idx7]),.c(fac[100 + idx7])
        );
    end
endgenerate

full_adder fa111(.x(has[7]),  .y(fac[55]),  .cin(fas[67]), .s(fas[111]), .c(fac[111]));
full_adder fa112(.x(dot[7]),  .y(hac[7]),   .cin(fas[68]), .s(fas[112]), .c(fac[112]));
assign dot[34] = fas[69];
assign dot[35] = has[9];
assign dot[36] = dot[9];

//last two rows of dots will carry over a few times, keep track of them

/*stage 3********/
//dot[26], dot[27]
assign dot[37] = has[10];
half_adder ha17(.x(fas[70]), .y(hac[10]), .s(has[17]), .c(hac[17]));
half_adder ha18(.x(fas[71]), .y(fac[70]), .s(has[18]), .c(hac[18]));
full_adder fa113(.x(fas[72]),  .y(fac[71]),   .cin(dot[31]), .s(fas[113]), .c(fac[113]));
full_adder fa114(.x(fas[73]),  .y(fac[72]),   .cin(has[11]), .s(fas[114]), .c(fac[114]));
full_adder fa115(.x(fas[74]),  .y(fac[73]),   .cin(has[12]), .s(fas[115]), .c(fac[115]));
genvar idx8;
generate
    for (idx8 = 0; idx8 <= 9; idx8 = idx8 + 1) begin
        full_adder fa (.x(fas[75 + idx8]),.y(fac[74 + idx8]),.cin(fas[85 + idx8]),.s(fas[116 + idx8]),.c(fac[116 + idx8])
        );
    end
endgenerate

full_adder fa126(.x(dot[28]),  .y(fac[84]),   .cin(fas[95]), .s(fas[126]), .c(fac[126]));

half_adder ha19(.x(dot[29]), .y(fas[96]), .s(has[19]), .c(hac[19]));
half_adder ha20(.x(dot[30]), .y(fas[97]), .s(has[20]), .c(hac[20]));
assign dot[38] = has[13];
assign dot[39] = has[14];
assign dot[40] = has[15];

assign dot[41] = hac[11];
assign dot[42] = hac[12];
half_adder ha21(.x(fac[85]), .y(dot[32]), .s(has[21]), .c(hac[21]));
half_adder ha22(.x(fac[86]), .y(fac[86]), .s(has[22]), .c(hac[22]));
half_adder ha23(.x(fac[87]), .y(has[16]), .s(has[23]), .c(hac[23]));
full_adder fa127(.x(fac[88]),  .y(fas[98]),  .cin(hac[16]),  .s(fas[127]), .c(fac[127]));

genvar idx9;
generate
    for (idx9 = 0; idx9 <= 8; idx9 = idx9 + 1) begin
        full_adder fa (.x(fac[89 + idx9]),.y(fas[99 + idx9]),.cin(fac[98 + idx9]),.s(fas[128 + idx9]),.c(fac[128 + idx9])
        );
    end
endgenerate
full_adder fa137(.x(hac[13]),  .y(fas[108]), .cin(fac[107]), .s(fas[137]), .c(fac[137]));
full_adder fa138(.x(hac[14]),  .y(fas[109]), .cin(fac[108]), .s(fas[138]), .c(fac[138]));
full_adder fa139(.x(hac[15]),  .y(fas[110]), .cin(fac[109]), .s(fas[139]), .c(fac[139]));
half_adder ha24(.x(fas[111]), .y(fac[110]), .s(has[24]), .c(hac[24]));
half_adder ha25(.x(fas[112]), .y(fac[111]), .s(has[25]), .c(hac[25]));
half_adder ha26(.x(dot[34]), .y(fac[112]), .s(has[26]), .c(hac[26]));
assign dot[43] = dot[35];
assign dot[44] = dot[36]; 





/***************/
/*stage 4 **********/
//dot[26], [27], [37]
assign dot[45] = has[17];
half_adder ha27(.x(has[18]), .y(hac[17]), .s(has[27]), .c(hac[27]));
half_adder ha28(.x(fas[113]), .y(hac[18]), .s(has[28]), .c(hac[28]));
half_adder ha29(.x(fas[114]), .y(fac[113]), .s(has[29]), .c(hac[29]));
full_adder fa140(.x(fas[115]), .y(fac[114]), .cin(dot[41]), .s(fas[140]), .c(fac[140]));
full_adder fa141(.x(fas[116]), .y(fac[115]), .cin(dot[42]), .s(fas[141]), .c(fac[141]));
full_adder fa142(.x(fas[117]), .y(fac[116]), .cin(has[21]), .s(fas[142]), .c(fac[142]));
full_adder fa143(.x(fas[118]), .y(fac[117]), .cin(has[22]), .s(fas[143]), .c(fac[143]));
full_adder fa144(.x(fas[119]), .y(fac[118]), .cin(has[23]), .s(fas[144]), .c(fac[144]));
genvar idx10;
generate
    for (idx10 = 0; idx10 <= 6; idx10 = idx10 + 1) begin 
        full_adder fa (.x(fas[120 + idx10]),.y(fac[119 + idx10]),.cin(fas[127 + idx10]),.s(fas[145 + idx10]),.c(fac[145 + idx10])
        );
    end
endgenerate

full_adder fa152(.x(has[19]), .y(fac[126]), .cin(fas[134]), .s(fas[152]), .c(fac[152]));
full_adder fa153(.x(has[20]), .y(hac[19]), .cin(fas[135]), .s(fas[153]), .c(fac[153]));
full_adder fa154(.x(dot[38]), .y(hac[20]), .cin(fas[136]), .s(fas[154]), .c(fac[154]));
half_adder ha30(.x(dot[39]), .y(fas[137]), .s(has[30]), .c(hac[30]));
half_adder ha31(.x(dot[40]), .y(fas[138]), .s(has[31]), .c(hac[31]));
assign dot[46] = fas[139];
assign dot[47] = has[24];
assign dot[48] = has[25];
assign dot[49] = has[26];
//dot[43]

assign dot[50] = hac[21];
assign dot[51] = hac[22];
assign dot[52] = hac[23];
assign dot[53] = fac[127];
half_adder ha32(.x(fac[128]), .y(hac[8]), .s(has[32]), .c(hac[32])); //check first for errors
genvar idx11;
generate
    for (idx11 = 0; idx11 <= 10; idx11 = idx11 + 1) begin 
        full_adder fa (.x(fac[129 + idx11]),.y(fac[56 + idx11]),.cin(dot[10 + idx11]),.s(fas[155 + idx11]),.c(fac[155 + idx11])
        );
    end
endgenerate

full_adder fa166(.x(hac[24]), .y(fac[67]), .cin(dot[21]), .s(fas[166]), .c(fac[166]));
full_adder fa167(.x(hac[25]), .y(fac[68]), .cin(dot[22]), .s(fas[167]), .c(fac[167]));
full_adder fa168(.x(hac[26]), .y(fac[69]), .cin(dot[23]), .s(fas[168]), .c(fac[168]));
full_adder fa169(.x(dot[36]), .y(hac[9]), .cin(dot[24]), .s(fas[169]), .c(fac[169]));
assign dot[54] = dot[25];





/**************/
/*stage 5 *****/
//dot[26], [27], [37], [45]
assign dot[55] = has[27];
half_adder ha33(.x(has[28]), .y(hac[27]), .s(has[33]), .c(hac[33]));
half_adder ha34(.x(has[29]), .y(hac[28]), .s(has[34]), .c(hac[34]));
half_adder ha35(.x(fas[140]), .y(hac[29]), .s(has[35]), .c(hac[35]));
half_adder ha36(.x(fas[141]), .y(fac[140]), .s(has[36]), .c(hac[36]));
half_adder ha37(.x(fas[142]), .y(fac[141]), .s(has[37]), .c(hac[37]));

full_adder fa170(.x(fas[143]), .y(fac[142]), .cin(dot[50]), .s(fas[170]), .c(fac[170]));
full_adder fa171(.x(fas[144]), .y(fac[143]), .cin(dot[51]), .s(fas[171]), .c(fac[171]));
full_adder fa172(.x(fas[145]), .y(fac[144]), .cin(dot[52]), .s(fas[172]), .c(fac[172]));
full_adder fa173(.x(fas[146]), .y(fac[145]), .cin(dot[53]), .s(fas[173]), .c(fac[173]));
full_adder fa174(.x(fas[147]), .y(fac[146]), .cin(has[32]), .s(fas[174]), .c(fac[174]));
genvar idx12;
generate
    for (idx12 = 0; idx12 < 7; idx12 = idx12 + 1) begin 
        full_adder fa (.x(fas[148 + idx12]),.y(fac[147 + idx12]),.cin(fas[155 + idx12]),.s(fas[175 + idx12]), .c(fac[175 + idx12])      
);
    end
endgenerate

full_adder fa182(.x(has[30]), .y(fac[154]), .cin(fas[162]), .s(fas[182]), .c(fac[182]));
full_adder fa183(.x(has[31]), .y(hac[30]),  .cin(fas[163]), .s(fas[183]), .c(fac[183]));
full_adder fa184(.x(dot[46]), .y(hac[31]),  .cin(fas[164]), .s(fas[184]), .c(fac[184]));
half_adder ha38(.x(dot[47]), .y(fas[165]), .s(has[38]), .c(hac[38]));
half_adder ha39(.x(dot[48]), .y(fas[166]), .s(has[39]), .c(hac[39]));
half_adder ha40(.x(dot[49]), .y(fas[167]), .s(has[40]), .c(hac[40]));
half_adder ha41(.x(dot[43]), .y(fas[168]), .s(has[41]), .c(hac[41]));  ///check here
assign dot[56] = fas[169];
//dot[54]
/*************/





/*stage 6 ****/
assign dot[57] = has[33];
half_adder ha42(.x(has[34]), .y(hac[33]), .s(has[42]), .c(hac[42])); 
half_adder ha43(.x(has[35]), .y(hac[34]), .s(has[43]), .c(hac[43])); 
half_adder ha44(.x(has[36]), .y(hac[35]), .s(has[44]), .c(hac[44])); 
half_adder ha45(.x(has[37]), .y(hac[36]), .s(has[45]), .c(hac[45])); 
half_adder ha46(.x(fas[170]), .y(hac[37]), .s(has[46]), .c(hac[46])); 
half_adder ha47(.x(fas[171]), .y(fac[170]), .s(has[47]), .c(hac[47])); 
half_adder ha48(.x(fas[172]), .y(fac[171]), .s(has[48]), .c(hac[48])); 
half_adder ha49(.x(fas[173]), .y(fac[172]), .s(has[49]), .c(hac[49])); 
half_adder ha50(.x(fas[174]), .y(fac[173]), .s(has[50]), .c(hac[50])); 
full_adder fa185(.x(fas[175]), .y(fac[174]),  .cin(hac[32]), .s(fas[185]), .c(fac[185]));
genvar idx13;
generate
    for (idx13 = 0; idx13 < 9; idx13 = idx13 + 1) begin 
        full_adder fa (.x(fas[176 + idx13]),.y(fac[175 + idx13]),.cin(fac[155 + idx13]),.s(fas[186 + idx13]), .c(fac[186 + idx13])       
        );
    end
endgenerate

full_adder fa195(.x(has[38]), .y(fac[184]),  .cin(fac[164]), .s(fas[195]), .c(fac[195]));
full_adder fa196(.x(has[39]), .y(hac[38]),   .cin(fac[165]), .s(fas[196]), .c(fac[196]));
full_adder fa197(.x(has[40]), .y(hac[39]),   .cin(fac[166]), .s(fas[197]), .c(fac[197]));
full_adder fa198(.x(has[41]), .y(hac[40]),   .cin(fac[167]), .s(fas[198]), .c(fac[198]));
full_adder fa199(.x(dot[56]), .y(hac[41]),   .cin(fac[168]), .s(fas[199]), .c(fac[199]));
half_adder ha51(.x(dot[54]), .y(fac[169]), .s(has[51]), .c(hac[51])); 




/*************/
/*stage 7 ****/

logic [31:0] carry;


half_adder ha100 (.x(dot[26]),.y(1'd0),.s(result[0]),.c(carry[0]));
full_adder fa1 ( .x(dot[27]), .y(1'd0), .cin(carry[0]), .s(result[1]), .c(carry[1]));
full_adder fa2 ( .x(dot[37]), .y(1'd0), .cin(carry[1]), .s(result[2]), .c(carry[2]));
full_adder fa3 ( .x(dot[45]), .y(1'd0), .cin(carry[2]), .s(result[3]), .c(carry[3]));
full_adder fa4 ( .x(dot[55]), .y(1'd0), .cin(carry[3]), .s(result[4]), .c(carry[4]));
full_adder fa5 ( .x(dot[57]), .y(1'd0), .cin(carry[4]), .s(result[5]), .c(carry[5]));
full_adder fa6 ( .x(has[42]), .y(1'd0), .cin(carry[5]), .s(result[6]), .c(carry[6]));
genvar idx14;
generate
    for (idx14 = 7; idx14 <= 14; idx14 = idx14 + 1) begin : gen_full_adders
        full_adder fa(.x(has[43 + (idx14 - 7)]),.y(hac[42 + (idx14 - 7)]),.cin(carry[idx14 - 1]),.s(result[idx14]),.c(carry[idx14])                );
    end
endgenerate

full_adder fa15 ( .x(fas[185]), .y(hac[50]), .cin(carry[14]), .s(result[15]), .c(carry[15]));
genvar idx15;
generate
    for (idx15 = 0; idx15 < 14; idx15 = idx15 + 1) begin 
        full_adder fa (.x(fas[186 + idx15]),.y(fac[185 + idx15]),.cin(carry[15 + idx15]),.s(result[16 + idx15]), .c(carry[16 + idx15])        
        );
    end
endgenerate

full_adder fa30 ( .x(has[51]), .y(fac[199]), .cin(carry[29]), .s(result[30]), .c(carry[30]));
full_adder fa31 ( .x(1'd0), .y(hac[51]), .cin(carry[30]), .s(result[31]), .c(carry[31]));



endmodule
