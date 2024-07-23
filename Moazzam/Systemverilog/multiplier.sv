module multiplier(
    input logic [15:0] A,
    input logic [15:0] B,
    output logic [31:0] Product
);

logic [31:0] and_result [15:0] = '{default : '0};
logic [31:0] result [15:0] = '{default : '0};
logic [31:0] carry [15:0] = '{default : '0};
//logic c;

    /*----------first calculate all AND and NAND gate value---------------------*/
    genvar i;
    generate
        // For the results of all AND gate 0f Row 0 to 14 and NAND at end of each row
        for (i=0; i < 15; i++)
        begin
            always_comb 
            begin
                and_result[i][31:0] = (A &  {16{B[i]}} ) << i;
                and_result[i][15+i] = ~(and_result[i][15+i]); 
            end
        end
    endgenerate

    // For the results of Row 15(last row) and NAND at each and AND at end
    always_comb 
    begin
        //Product = ~(A & { 16{B[15]} });
        and_result[15] = ~(A & { 16{B[15]} }) << 15;
        and_result[15][31:30] = {1, ~and_result[15][30]}; 
        and_result[0][16] = 1'b1;
        result[15][0] = and_result[0][0]; 
    end


    /*--------start caluation of Addition using HALF and FULL adder-------------*/
     //Acc. to our method
 
    half_adder h1 (.a(and_result[0][1]), .b(and_result[1][1]), 
                    .sum(result[15][1]) , .carry(carry[1][1]) ) ;   //1st HA of 1st row
    
    genvar row,col;
    generate
        //for row B1
        for(col=2; col<17; col++)
        begin
            //always_comb
                full_adder f1 (.a(and_result[0][col]), .b(and_result[1][col]), .cin(carry[1][col-1]) ,
                            .sum(result[1][col]), .cout(carry[1][col]) ) ;
        end
        //from row B2 to B14 
        for (row=2; row < 15; row++) 
        begin
            //A0
            //always_comb 
                half_adder h2 (.a(result[row-1][row]), .b(and_result[row][row]), 
                            .sum(result[15][row]) , .carry(carry[row][row]) ) ;
            //for column A1 to A14
            for(col=row+1; col<14+row; col++)
            begin
                //always_comb
                    full_adder f2 (.a(result[row-1][col]), .b(and_result[row][col]), .cin(carry[row][col-1]) , 
                                .sum(result[row][col]), .cout(carry[row][col]) );
            end
            //A15
            //always_comb
                full_adder f3 (.a(carry[row-1][row+14]), .b(and_result[row][row+14+1]), .cin(carry[row][row+14]) , 
                            .sum(result[row][row+14+1]), .cout(carry[row][row+14+1]) );
        end
        
    endgenerate


    /*------------last row is different at end so made it separate----------------*/
    //A0
    //always_comb
    half_adder h3 (.a(result[14][15]), .b(and_result[15][15]), 
                .sum(result[15][15]) , .carry(carry[15][15]) ) ;

    genvar l_r;
    generate
        int x=15;
        //for column A1 to A14
        for(l_r=16; l_r<30; l_r++)
        begin
            //always_comb
                full_adder f4 (.a(result[14][l_r]), .b(and_result[15][l_r]), .cin(carry[15][l_r-1]) , 
                            .sum(result[15][l_r]), .cout(carry[15][l_r])) ;
        end
    endgenerate


    //A15 and col 30
    full_adder f5 (.a(carry[14][29]), .b(and_result[15][30]), .cin(carry[15][29]) , 
                .sum(result[15][30]), .cout(carry[15][30]) ) ;
    //extra adder for 1
    half_adder h4 ( .a(1'b1) , .b(carry[15][30]) , .sum(result[15][31]) , .carry(c) ) ;
    always_comb 
    begin
        //main product 
        Product = result[15];
    end


endmodule

