`timescale 1ns / 1ps
module Sequential_Multiplier_TB();
    localparam CLK_PERIOD = 10;
    logic clk=1;
    logic reset,start;
    logic bit_val;
    logic [31:0]result;
    int c=0;
    logic [15:0]VALUE1;
    logic [15:0]VALUE2;
Sequential_Multiplier DUT(.clk(clk),.reset(reset),.start(start),.input1(VALUE1),.input2_bit(bit_val),.Product(result));
    always #(CLK_PERIOD/2) clk = ~clk;
    initial begin
        reset = 0;
        #1;
        reset = 1;
        #1
        for (int j=0;j<100;j++)begin
            VALUE1=$random()%30;
            VALUE2=$random()%30;
            start = 1;
            for(int i=0;i<16;i++)begin
                @(posedge clk);
                bit_val=VALUE2[i];
            end
            start = 0;
            @(posedge clk);
            #1;
            if ($signed(result)!=$signed(VALUE1)*$signed(VALUE2))begin
                $display("The product of %d and %d is not %d but %d",$signed(VALUE1),$signed(VALUE2),$signed(result),$signed(VALUE1)*$signed(VALUE2));
                c=c+1;
            end
            #10;
        end
        if (c==0)begin
            $display("No wrong answer");
        end
        #5000
        $finish;
    end
endmodule