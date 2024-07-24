module multiplier
#
(
    parameter IB = 16,
    parameter OB = 2*IB
) 
(
    input logic  [IB-1 : 0] A,
    input logic  [IB-1 : 0] B,
    output logic [OB-1 :0] Product
);
    
    
    logic [OB-1:0] and_result  [IB-1:0] = '{default : '0};
    logic [OB-1:0] result      [IB-1:0] = '{default : '0};
    logic [OB-1:0] carry       [IB-1:0] = '{default : '0};
    
    logic ce;

    /*----------first calculate all AND and NAND gate value---------------------*/
    genvar i;
    generate
        // For the results of all AND gate 0f Row 0 to (IB-2) and NAND at end of each r
        for (i=0; i < IB-1; i++)
        begin
            always_comb 
            begin
                and_result[i][OB-1:0] =  (A &  {IB{B[i]}} ) << i;
                and_result[i][IB-1+i] = ~(and_result[i][IB-1+i]); 
            end
        end
    endgenerate
    
    // For the results of Row 15(last r) and NAND at each and AND at end
    always_comb 
    begin
        and_result[IB-1][OB-1:0]     = ~(A & { 16{B[IB-1]} }) << IB-1;
        and_result[IB-1][OB-1_:OB-2] =  {1'b0 , ~and_result[IB-1][OB-2]}; 
        and_result[0][IB] = 1'b1;
        result[IB-1][0] = and_result[0][0]; //P0
    end


    /*--------start caluation of Addition using HALF and FULL adder-------------*/
     //Acc. to our method
 
    half_adder h1 (.a(and_result[0][1]), .b(and_result[1][1]), 
                    .sum(result[IB-1][1]) , .carry(carry[1][1]) ) ;   //1st HA of 1st r
    
    genvar c;
    generate
        //for row B1
        for(c=2; c<IB+1 ; c++)
        begin
            full_adder f1 (.a(and_result[0][c]), .b(and_result[1][c]), .cin(carry[1][c-1]) ,
                            .sum(result[1][c]), .cout(carry[1][c]) ) ;
        end
    endgenerate

    genvar r,cl;
    generate
        //from row B2 to B[IB-1] 
        for (r=2; r < IB-1; r++) 
        begin
            //A0 --> first element of that row
            half_adder h2 ( .a(result[r-1][r]), .b(and_result[r][r]), 
                            .sum(result[IB-1][r]), .carry(carry[r][r]) ) ;

            //for column A1 to A14
            for(cl=r+1; cl<((IB-1)+r); cl++)    //3 3+2=5
            begin
                full_adder f2 ( .a(result[r-1][cl]), .b(and_result[r][cl]), .cin(carry[r][cl-1]) , 
                                .sum(result[r][cl]), .cout(carry[r][cl]) );
            end
            //A15
            full_adder f3 ( .a(carry[r-1][r+(IB-2)]),    .b(and_result[r][r+(IB-1)]), .cin(carry[r][r+(IB-2)]) , 
                            .sum(result[r][r+(IB-1)]),   .cout(carry[r][r+(IB-1)]) );
        end
    endgenerate


    /*------------last row is different at end so made it separate----------------*/
    
    //A0
    half_adder h3 ( .a(result[IB-2][IB-1]), .b(and_result[IB-1][IB-1]), 
                    .sum(result[IB-1][IB-1]) , .carry(carry[IB-1][IB-1]) ) ;

    genvar l_r;
    generate
        //for column A1 to A14
        for(l_r=IB; l_r<OB-2 ; l_r++)
        begin
            full_adder f4 ( .a(result[IB-2][l_r]), .b(and_result[IB-1][l_r]), .cin(carry[IB-1][l_r-1]) , 
                            .sum(result[IB-1][l_r]), .cout(carry[IB-1][l_r])) ;
        end
    endgenerate


    //A[IB-1]
    full_adder f5 (.a(carry[IB-2][OB-3]), .b(and_result[IB-1][OB-2]), .cin(carry[IB-1][OB-3]) , 
                    .sum(result[IB-1][OB-2]), .cout(carry[IB-1][OB-2]) ) ;
    //extra adder for 1
    half_adder h4 ( .a(1'b1) , .b(carry[IB-1][OB-2]) , .sum(result[IB-1][OB-1]) , .carry(ce) ) ;
    always_comb 
    begin
        //main product 
        //if(result[15][26] == 1 ) begin
        //    Product = {5'b11111, result[15][26:0]}; end
        //else begin
        //    Product = {5'b000000, result[15][26:0]}; end
        Product =  result[IB-1] ;
    end

endmodule
