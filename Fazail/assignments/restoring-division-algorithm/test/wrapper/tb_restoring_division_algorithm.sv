module tb_restoring_division_algorithm (

    input logic [WIDTH-1:0] divisor,
    input logic [WIDTH-1:0] dividend,
        
    input logic clk,
    input logic n_rst,

    input logic start,
    output logic ready,

    output logic [WIDTH-1:0] quotient,
    output logic [WIDTH-1:0] remainder

);

localparam WIDTH = 16;

restoring_division_algorithm dut (

    .divisor(divisor), .dividend(dividend),

    .clk(clk), .n_rst(n_rst),

    .start(start), .ready(ready),

    .quotient(quotient), .remainder(remainder)

);

 initial begin
     $dumpfile ("restoring-division-algorithm.vcd");
     $dumpvars;
 end
    
endmodule