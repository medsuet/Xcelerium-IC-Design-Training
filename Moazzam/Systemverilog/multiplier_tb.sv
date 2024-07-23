module multiplier_tb();

logic [15:0] A;
logic [15:0] B;
logic [31:0] Product;

multiplier UUT (A, B, Product);

initial
begin
    A = 16'h0007;  B = 16'h0003;      //5 * 3
    #20
    A = 16'hfffb ;  B = 16'h0003;     //-5 * 3
    #20
    A = 16'h0005 ;  B = 16'hfffd;     //5 * -3
    #20
    A = 16'hfffb ;  B = 16'hfffd;     //-5 * -3
    #20
    A = 16'h0018;  B = 16'hefdf;      
    #20
    A = 16'hffff ;  B = 16'h0003;     
    #20
    A = 16'h0055 ;  B = 16'hfffd;     
    #20
    A = 16'hf00b ;  B = 16'hf111;     
    #20

    $monitor ("time = %0t, A = 0x%0h, B = 0x%0h, product = 0x%h ", $time, A,B,$signed(A)*$signed(B));
    $stop;
end

endmodule