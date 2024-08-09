//`timescale 1ns / 1ps
//module Res_div_tb();
//    localparam CLK_PERIOD = 10;
//    logic clk=1;
//    logic reset;
//    logic valid_src,ready_dst;
//    logic [3:0]Quotient;
//    logic [4:0]Remainder;
//    logic [3:0]VALUE1;
//    logic [4:0]VALUE2;
//    logic ready_src;
//    logic valid_dst;
//    logic [6:0]N=5;
//    Res_Div #(5) DUT(.clk(clk),.reset(reset),.valid_src(valid_src),.ready_dst(ready_dst),.N(N),.Q_initial(VALUE1),.M(VALUE2),.Remainder(Remainder),.Quotient(Quotient),.ready_src(ready_src),.valid_dst(valid_dst));
//    task driver(input logic [3:0]driver_Value1,input logic [4:0]driver_Value2,input logic driver_valid_src,input logic driver_ready_dst);
//    begin
//        VALUE1=driver_Value1;
//        VALUE2=driver_Value2;
//        valid_src=driver_valid_src;
//        ready_dst=driver_ready_dst;
//        for(int i=0;i<16;i++)begin
//            @(posedge clk);
//            valid_src = 0;
//        end
////        while(valid_dst!=1)begin
////            @(posedge clk);
////        end
//        @(posedge clk);
//        ready_dst=1;
//        while(ready_src!=1)begin
//            @(posedge clk);
//        end
//        ready_dst=0;
//    end
//    endtask
    
//    task monitor;
//    begin
//        #20;
//        while(1)begin
//            while(ready_src!=1)begin     //Wait for ready_src 
//                @(posedge clk);
//            end
//            while(valid_src!=1)begin     //Wait for valid_src 
//                @(posedge clk);
//            end
//            while (valid_dst!=1)begin    //Wait for valid_dst
//                @(posedge clk);
//            end
//            while (ready_dst!=1)begin    //Wait for ready_dst
//                @(posedge clk);
//            end
//            $display("%0t : The Quotient and Remainder of %0d and %0d are %0d and %0d respectively (by restoring division algorithm) and %0d and %0d respectively(by reference Model)",$time,$unsigned(VALUE1),$unsigned(VALUE2),$unsigned(Quotient),$unsigned(Remainder),$unsigned((VALUE1-(VALUE1%VALUE2))/VALUE2),$unsigned(VALUE1%VALUE2));
//            if ((Quotient!=(VALUE1-(VALUE1%VALUE2))/VALUE2)||(Remainder!=(VALUE1%VALUE2)/VALUE2))begin
//                $display("%0t : The Quotient and Remainder of %0d and %0d are %0d and %0d respectively (by restoring division algorithm) and %0d and %0d respectively(by reference Model)",$time,$unsigned(VALUE1),$unsigned(VALUE2),$unsigned(Quotient),$unsigned(Remainder),$unsigned((VALUE1-(VALUE1%VALUE2))/VALUE2),$unsigned(VALUE1%VALUE2));
//            end
//        end
//    end
//    endtask
//    always #(CLK_PERIOD/2) clk = ~clk;
//    initial begin
//        reset = 1;
//        #10;
//        reset = 0;
//        #10;
//        reset = 1;
////        for (int i=0;i<4000;i++)begin
//        driver($random(),$random(),1,0);
//        driver($random(),$random(),1,0);
////            @(posedge clk);
////        end
//        #5000
//        $finish;
//    end
//    initial begin
//        monitor;
//    end
//endmodule
`timescale 1ns / 1ps
module Res_div_tb();
    localparam CLK_PERIOD = 10;
    logic clk=1;
    logic reset;
    logic valid_src,ready_dst;
    logic [3:0]Quotient;
    logic [4:0]Remainder;
    logic [3:0]VALUE1;
    logic [4:0]VALUE2;
    logic ready_src;
    logic valid_dst;
    logic [6:0]N=5;
    Res_Div #(5) DUT(.clk(clk),.reset(reset),.valid_src(valid_src),.ready_dst(ready_dst),.N(N),.Q_initial(VALUE1),.M(VALUE2),.Remainder(Remainder),.Quotient(Quotient),.ready_src(ready_src),.valid_dst(valid_dst));
    task driver(input logic [3:0]driver_Value1,input logic [4:0]driver_Value2,input logic driver_valid_src,input logic driver_ready_dst);
    begin
        VALUE1=driver_Value1;
        VALUE2=driver_Value2;
        valid_src=driver_valid_src;
        ready_dst=driver_ready_dst;
        for(int i=0;i<16;i++)begin
            @(posedge clk);
            valid_src = 0;
        end
        @(posedge clk);
        ready_dst=1;
        while(ready_src!=1)begin
            @(posedge clk);
        end
    end
    endtask
    
    task monitor;
    begin
        #20;
        while(1)begin
//            while(ready_src!=1)begin     //Wait for ready_src 
//                @(posedge clk);
//            end
            while(valid_src!=1)begin     //Wait for valid_src 
                @(posedge clk);
            end
            while (valid_dst!=1)begin    //Wait for valid_dst
                @(posedge clk);
            end
            while (ready_dst!=1)begin    //Wait for ready_dst
                @(posedge clk);
            end
            if ((Quotient==15)&&(Remainder==VALUE1))begin
                $display("DIVISION BY ZERO");
            end
            else if ((Quotient!=(VALUE1-(VALUE1%VALUE2))/VALUE2)||(Remainder!=(VALUE1%VALUE2)/VALUE2))begin
                $display("The Quotient and Remainder of %0d and %0d are %0d and %0d respectively (by restoring division algorithm) and %0d and %0d respectively(by reference Model)",$unsigned(VALUE1),$unsigned(VALUE2),$unsigned(Quotient),$unsigned(Remainder),$unsigned((VALUE1-(VALUE1%VALUE2))/VALUE2),$unsigned(VALUE1%VALUE2));
            end
        end
    end
    endtask
    always #(CLK_PERIOD/2) clk = ~clk;
    initial begin
        reset = 1;
        #10;
        reset = 0;
        #10;
        reset = 1;
//        for (int i=0;i<4000;i++)begin
        driver(0,0,1,1);
        driver($random(),0,1,1);
        driver($random(),$random(),1,1);
//            @(posedge clk);
//        end
        #5000000
        $finish;
    end
    initial begin
        monitor;
    end
endmodule