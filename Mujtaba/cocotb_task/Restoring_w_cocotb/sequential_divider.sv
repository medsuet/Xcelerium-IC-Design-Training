module sequential_divider #(parameter WIDTH = 16) (
    input logic reset, clk,
    input logic src_valid,
    input logic dest_ready,
    input logic [WIDTH-1:0] Divisor,
    input logic [WIDTH-1:0] Dividend,
    output logic [WIDTH-1:0] Quotient,
    output logic [WIDTH-1:0] Remainder,
    output logic dest_valid, 
    output logic src_ready
);

    logic dividend_en;
    logic restore_reg;
    logic divisor_en;
    logic acc_en;
    logic sh_en;
    logic SCEn;
    logic [4:0] SCval;

    datapath dp1(.reset(reset), .clk(clk), .divisor_en(divisor_en), .dividend_en(dividend_en), .acc_en(acc_en), .SCEn(SCEn), .restore_reg(restore_reg), .sh_en(sh_en), .Divisor(Divisor), .Dividend(Dividend), .SCval(SCval), .Quotient(Quotient), .Remainder(Remainder));

    controller c1(.src_valid(src_valid), .dest_ready(dest_ready), .clk(clk), .reset(reset), .SCval(SCval), .divisor_en(divisor_en), .dividend_en(dividend_en), .SCEn(SCEn), .restore_reg(restore_reg), .sh_en(sh_en), .acc_en(acc_en), .dest_valid(dest_valid), .src_ready(src_ready));

//     initial begin
//         $dumpfile("sequential_divider_tb.vcd");
//         $dumpvars(0,sequential_divider);
//     end
endmodule
