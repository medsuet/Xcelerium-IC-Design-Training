`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2024 02:26:31 PM
// Design Name: 
// Module Name: Sequential_Adder_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Sequential_Adder_TB();
    localparam CLK_PERIOD = 10;
    logic clk=1;
    logic reset,start;
    logic bit_val,result;
    int i=0;
    logic [3:0]VALUE;
    logic [3:0]VALUE1;
Sequential_Adder DUT(.clk(clk),.reset(reset),.tx_start(start),.in(bit_val),.out(result));
    always #(CLK_PERIOD/2) clk = ~clk;
    initial begin
        reset = 1;
        #1;
        reset = 0;
        #1

        VALUE=4'b1111;
        start = 1;
        for(i=0;i<4;i++)begin
            @(posedge clk);
            bit_val=VALUE[i];
        end
        start=0;
        #30
        VALUE1=4'b1111;
        start = 1;
        for(i=0;i<4;i++)begin
            @(posedge clk);
            bit_val=VALUE1[i];
        end
        start=0;
        
        #100
        $finish;
    end
endmodule