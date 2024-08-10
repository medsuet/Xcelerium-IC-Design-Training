/*******************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 06-08-2024
  +  Description : Testing restoring division algorithm using Cocotb.
*******************************************************************************/

parameter WIDTH = 16;

module tb;

//=================== Declearing Input And Outputs For UUT ===================//

    logic                 clk;
    logic                 rst;
    logic   [WIDTH-1:0]   dividend;
    logic   [WIDTH-1:0]   divisor;
    logic   [WIDTH-1:0]   remainder;
    logic   [WIDTH-1:0]   quotient;
    logic                 src_valid;
    logic                 src_ready;
    logic                 dest_valid;
    logic                 dest_ready;
 
    logic   [WIDTH-1:0]   exp_remainder;
    logic   [WIDTH-1:0]   exp_quotient;

//=========================== Module Instantiation ===========================//

    restoring_division_top #(.WIDTH(WIDTH)) uut (
        .clk(clk),
        .rst(rst),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_valid(dest_valid),
        .dest_ready(dest_ready),
        .divisor(divisor),
        .dividend(dividend),
        .remainder(remainder),
        .quotient(quotient)
    );

//=========================== Generating Waveform ============================//

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end

endmodule

