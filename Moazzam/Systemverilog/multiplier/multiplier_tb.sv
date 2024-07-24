module multiplier_tb();

logic signed [15:0] A;
logic signed [15:0] B;
logic signed [31:0] Product;
logic signed [31:0] exp;

int fd;
int pass=0;
int fail=0;
int n=65535;

multiplier UUT (A, B, Product);

initial
begin
    A =  4;  B = 1;
    #5
    A =  1;  B = -3;
    #5
    A =  6;  B = -3;
    #5
    A = -3;  B = -4;      
    #5
    A =  5;  B = -8; 
    #5
    A = -5;  B = -3; 
    #5
    A =  6;  B = 2; 
    #5

    fd = $fopen ("output.log", "w");
    for(int i=0;i<n;i++)begin 
        A = $random ;
        B = $random ;
        exp = A*B; 
        #5;
        if (exp != Product)begin
            fail = fail+1;
            $fdisplay(fd,"Failed");
            $fdisplay(fd,"A = %0d, B = %0d, Product = %0d,Product_exp = %0d", A, B, Product,exp);
        end

        else begin
            pass = pass+1;
            $fdisplay(fd,"Pass");end      
    end
    $fdisplay(fd,"total test %0d= , pass test= %0d, fail test= %0d",n,pass, fail);
    //$finish;

    //$monitor ("time = %0t, A = 0x%0h, B = 0x%0h, product = 0x%h ", $time, A,B,$signed(A)*$signed(B));
    $stop;
end

endmodule