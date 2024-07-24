module multiplier_tb();

logic signed [15:0] A;
logic signed [15:0] B;
logic signed [31:0] Product;
logic signed [31:0] exp;

multiplier UUT (A, B, Product);

initial
begin
    A = -3;  B = -4;      
    #5
    A =  5;  B = -8; 
    #5
    A = -5;  B = -3; 
    #5
    A =  6;  B = 2; 
    #5
   
    for(int i=0;i<200;i++)begin 
     A = $random ;
     B = $random ;
     exp = A*B; 
     #5;
     if (exp != Product)begin
      $display("Failed");
      $display("A = %0d, B = %0d, Product = %0d,Product_exp = %0d", A, B, Product,exp);
      end

     else begin
      $display("Pass");end      
    end

    //$finish;

    //$monitor ("time = %0t, A = 0x%0h, B = 0x%0h, product = 0x%h ", $time, A,B,$signed(A)*$signed(B));
    $stop;
end

endmodule