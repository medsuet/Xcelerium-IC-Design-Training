`timescale 1ns / 1ps
module Sequential_Multiplier_TB();
    localparam CLK_PERIOD = 10;
    logic clk=1;
    logic reset,start;
    logic bit_val,valid_src,ready_dst,End_of_Transmission;
    logic [31:0]result;
    logic [15:0]VALUE1;
    logic [15:0]VALUE2;
    Sequential_Multiplier DUT(.clk(clk),.reset(reset),.valid_src(valid_src),.ready_dst(ready_dst),.input1(VALUE1),.input2_bit(bit_val),.Product(result),.End_of_Transmission(End_of_Transmission));
    task driver(input logic [15:0]driver_Value1,input logic [15:0]driver_Value2,input logic driver_valid_src,input logic driver_ready_dst);
    begin
        VALUE1=driver_Value1;
        VALUE2=driver_Value2;
        valid_src=driver_valid_src;
        ready_dst=driver_ready_dst;
        while(valid_src!=1)begin
            @(posedge clk);
        end
        for(int i=0;i<16;i++)begin
            @(posedge clk);
            bit_val=VALUE2[i];
            valid_src = 0;
        end
    end
    endtask
    task monitor;
    begin
    forever while(1)begin
        if (ready_dst)begin
            @(negedge clk)
            #1;
            if ($signed(result)!=$signed(VALUE1)*$signed(VALUE2))begin
                $display("The product of %d and %d is not %d but %d",$signed(VALUE1),$signed(VALUE2),$signed(result),$signed(VALUE1)*$signed(VALUE2));
            end
            break;
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
        driver($random()%30,$random()%30,0,0);
        driver($random()%60,$random()%60,0,0);
        #5000
        $finish;
    end
    initial begin
        valid_src=0;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        valid_src=1;
        for (int l=0;l<20;l++)begin
            @(posedge clk);
        end
        ready_dst=1;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        valid_src=0;
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        @(posedge clk)
        valid_src=1;
        for (int l=0;l<20;l++)begin
            @(posedge clk);
        end
        ready_dst=1;
    end
    initial begin
        monitor;
    end
endmodule