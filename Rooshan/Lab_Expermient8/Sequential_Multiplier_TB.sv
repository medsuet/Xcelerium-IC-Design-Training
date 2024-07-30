`timescale 1ns / 1ps
module Sequential_Multiplier_TB();
    localparam CLK_PERIOD = 10;
    logic clk=1;
    logic reset,start;
    logic bit_val;
    logic [31:0]result;
    int i=0;
    logic [15:0]VALUE1;
    logic [15:0]VALUE2;
Sequential_Multiplier DUT(.clk(clk),.reset(reset),.start(start),.input1(VALUE1),.input2_bit(bit_val),.Product(result));
//Sequential_Multiplier(clk,reset,start,input1,input2_bit,Product);
    always #(CLK_PERIOD/2) clk = ~clk;
    initial begin
        reset = 0;
        #1;
        reset = 1;
        #1
        VALUE1=-10;
        VALUE2=5;
        start = 1;
        for(i=0;i<16;i++)begin
            @(posedge clk);
            bit_val=VALUE2[i];
        end
        start=0;
        #100
        $finish;
    end
endmodule