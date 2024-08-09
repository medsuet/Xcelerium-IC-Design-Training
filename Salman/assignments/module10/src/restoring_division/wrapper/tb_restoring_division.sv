module tb_restoring_division(
    input logic clk,
    input logic reset,
    input logic [WIDTH-1:0] dividend,
    input logic [WIDTH-1:0] divisor,
    input logic src_valid, dst_ready,
    output logic src_ready, dst_valid,
    output logic [WIDTH-1:0] remainder,
    output logic [WIDTH-1:0] quotient
);

localparam WIDTH = 16;

restoring_division dut (
    .clk(clk),
    .reset(reset),
    .dividend(dividend),
    .divisor(divisor),
    .src_valid(src_valid), 
    .dst_ready(dst_ready),
    .src_ready(src_ready),
    .dst_valid(dst_valid),
    .remainder(remainder),
    .quotient(quotient)
);

initial
begin
    $dumpfile ("restoring-division-algorithm.vcd");
    $dumpvars;
end

endmodule