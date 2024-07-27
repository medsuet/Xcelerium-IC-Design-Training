//==============Author: Masooma Zia==============
//==============Date: 26-07-2024==============
//==============Description:Test Bench for 4-bit Sequential Counter using State Machine==============
module tb_adder;
    logic clk=0;
    logic reset;
    logic b;
    logic s;
    adder uut (
        .clk(clk),
        .reset(reset),
        .b(b),
        .s(s)
    );
    always #5 clk = ~clk; 

    initial begin
        reset = 0;
        repeat (10) @(posedge clk);
        reset = 1;
        b = 1;
        @(posedge clk); b = 0;
        @(posedge clk); b = 0;
        @(posedge clk); b = 0;
        @(posedge clk);
        b = 0;
        @(posedge clk); b = 0;
        @(posedge clk); b = 1;
        @(posedge clk); b = 1;
        repeat(10)@(posedge clk);
        $stop;
    end
endmodule
