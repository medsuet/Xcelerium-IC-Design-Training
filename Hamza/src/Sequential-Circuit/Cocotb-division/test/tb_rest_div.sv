module tb_rest_div;
    // Parameter definition with default value
    parameter WIDTH = 16; 
    parameter MAXNUM = 56535; 
    parameter CYCLE = 10; 

    // Inputs
    logic [WIDTH-1:0] dividend;
    logic [WIDTH-1:0] divisor; 
    logic clk;                 
    logic reset;               
    logic src_valid;           
    logic dest_ready;          

    // Outputs
    logic [WIDTH-1:0] quotient; 
    logic [WIDTH-1:0] remainder;
    logic src_ready, dest_valid;

    // Expected outputs for verification
    logic [WIDTH-1:0] expected_quotient;
    logic [WIDTH-1:0] expected_remainder;

    // Instantiate the Unit Under Test (UUT)
    Rest_div #(.WIDTH(WIDTH)) uut (
        .dividend(dividend),
        .divisor(divisor),
        .clk(clk),
        .reset(reset),
        .src_valid(src_valid),
        .dest_ready(dest_ready),
        .dest_valid(dest_valid),
        .src_ready(src_ready),
        .quotient(quotient),
        .remainder(remainder)
    );

    // Dump file for waveform
    initial begin
        $dumpfile("Rest_div.vcd");
        $dumpvars(0,tb_rest_div);
    end

endmodule
