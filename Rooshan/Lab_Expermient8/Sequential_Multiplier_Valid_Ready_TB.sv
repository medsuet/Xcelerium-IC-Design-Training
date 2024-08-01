`timescale 1ns / 1ps
module Sequential_Multiplier_TB();
    localparam CLK_PERIOD = 10;
    logic clk=1;
    logic reset,start;
    logic bit_val,valid_src,ready_dst,End_of_Transmission;
    logic [31:0]result;
    int c=0;
    logic [15:0]VALUE1;
    logic [15:0]VALUE2;
    Sequential_Multiplier DUT(.clk(clk),.reset(reset),.start(start),.valid_src(valid_src),.ready_dst(ready_dst),.input1(VALUE1),.input2_bit(bit_val),.Product(result),.End_of_Transmission(End_of_Transmission));
    task driver(input logic [15:0]driver_Value1,input logic [15:0]driver_Value2);
    begin
        VALUE1=driver_Value1;
        VALUE2=driver_Value2;
    end
    endtask
    task monitor;
    begin
        $display("The product of %d and %d is %d which is equal to the result %d(through direct multiplication)",$signed(VALUE1),$signed(VALUE2),$signed(result),$signed(VALUE1)*$signed(VALUE2));
    end
    endtask
    always #(CLK_PERIOD/2) clk = ~clk;
    initial begin
        reset = 0;
        #1;
        reset = 1;
        #1
        valid_src = 1;
        
        for (int j=0;j<4;j++)begin
//            VALUE1=$random()%30;
//            VALUE2=$random()%30;
            driver($random()%30,$random()%30);
            start = 1;
            valid_src=~valid_src;
            ready_dst=0;
            if (valid_src==0)begin
//                $display("x");
                @(posedge clk);
            end
            else begin
//                $display("y");
                for(int i=0;i<16;i++)begin
                    @(posedge clk);
                    bit_val=VALUE2[i];
                end
                @(posedge clk);
                @(posedge clk);
                @(posedge clk);
                monitor;
//                $display("The product of %d and %d is not %d but %d",$signed(VALUE1),$signed(VALUE2),$signed(result),$signed(VALUE1)*$signed(VALUE2));
                if ($signed(result)!=$signed(VALUE1)*$signed(VALUE2))begin
                    $display("The product of %d and %d is not %d but %d",$signed(VALUE1),$signed(VALUE2),$signed(result),$signed(VALUE1)*$signed(VALUE2));
                    c=c+1;
                end
                start = 0;
                ready_dst=1;
                @(posedge clk);
                #1;
                #10;
            end
        end
        if (c==0)begin
            $display("No wrong answer");
        end
        #5000
        $finish;
    end
endmodule