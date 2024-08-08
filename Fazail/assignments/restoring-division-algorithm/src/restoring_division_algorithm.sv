module restoring_division_algorithm (
    input logic [WIDTH-1:0] divisor,
    input logic [WIDTH-1:0] dividend,
    
    input logic clk, n_rst,
    input logic start,

    output logic ready,
    output logic [WIDTH-1:0] quotient,
    output logic [WIDTH-1:0] remainder
);

localparam WIDTH = 16;

logic en_aq, en_in, sel_a, count_en, clr, en_qr ;
logic a_msb, n_count;

datapath datapath (
    .clk(clk), .n_rst(n_rst),

    // inputs
    .divisor(divisor), .dividend(dividend),

    // controller -> datapath
    .en_in(en_in), .en_aq(en_aq), .sel_a(sel_a),
    .count_en(count_en), .clr(clr), .en_qr(en_qr),

    // datapath --> controller
    .a_msb(a_msb), .n_count(n_count),

    // outputs
    .quotient(quotient), .remainder(remainder)
);

controller controller (
    .clk(clk), .n_rst(n_rst),

    // input 
    .start(start),

    // controller -> datapath
    .en_in(en_in), .en_aq(en_aq), .sel_a(sel_a),
    .count_en(count_en), .clr(clr), .en_qr(en_qr),

    // datapath --> controller
    .a_msb(a_msb), .n_count(n_count),

    // output
    .ready(ready)
);
    
endmodule