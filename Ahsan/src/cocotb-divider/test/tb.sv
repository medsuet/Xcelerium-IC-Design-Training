
module divider_tb;

    // Inputs
    logic   [15:0] divident;
    logic   [15:0] divisor;
    logic clk;
    logic rst;
    logic start;

    //refernce model output
    logic  [15:0] exp_remain;
    logic  [15:0] exp_quot;

    // Outputs
    logic ready;
    logic  [15:0] remainder;
    logic  [15:0] quotient;


    // Instantiate the Unit Under Test (UUT)
    Top uut(.clk(clk),
            .rst(rst),
            .divident(divident),
            .divisor(divisor),
            .ready(ready),
            .remainder(remainder),
            .quotient(quotient),
            .start(start));

    // Dump file for waveform
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,divider_tb);
    end
   
endmodule
