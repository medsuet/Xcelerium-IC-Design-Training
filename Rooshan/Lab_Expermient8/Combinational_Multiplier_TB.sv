`timescale 1ns / 1ps
module Signed_Multiplier_tb();
    logic [15:0]Value1;
    logic [15:0]Value2;
    logic [31:0]PRODUCT;
    Signed_Multiplier imp(.a(Value1),.b(Value2),.Product(PRODUCT));
    initial begin
        for(int i=0;i<30;i++)begin
            Value1= $urandom%30;
            Value2= $urandom%30;
            #10
//            $display("The product of %d and %d is %d",$signed(Value1),$signed(Value2),$signed(PRODUCT));
            if ($signed(PRODUCT)!=$signed(Value1)*$signed(Value2))begin
                $display("The product of %d and %d is incorrect( %d ). The correct product is %d",$signed(Value1),$signed(Value2),$signed(PRODUCT),$signed(Value1)*$signed(Value2));
            end
            else begin
                $display("The product of %d and %d is correct( %d )",$signed(Value1),$signed(Value2),$signed(PRODUCT),);
            end
            #10;
        end

        #3200;
        
        $finish;
    end
endmodule
