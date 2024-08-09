`timescale 1ns / 1ps

module Counter_1_to_13_tb();
    localparam CLK_PERIOD = 10;
    logic clk=1;
    logic reset;
    logic [3:0]counter_out;
    Counter_0_to_x #(4) UUT(.clk(clk),.reset(reset),.counter_out(counter_out));
    always #(CLK_PERIOD/2) clk = ~clk;
    initial begin
        reset = 1;
        #1;
        reset = 0;
        #3200;
        $finish;
    end
endmodule
