`include "Datapath.sv"
`include "Controller.sv"

module seq_multiplier (
    input logic clk,
    input logic rst_n,
    input logic start,
    input logic [15:0] multiplier,
    input logic [15:0] multiplicand,

    output logic [31:0] product,
    output logic ready
);

logic [15:0]accumulator;
logic count_done, Q0, Q_1, en_multr, clear;
logic en_mltd, en_count, en_ac, selQ, selQ_1, selA, en_out;
logic [1:0]alu_op;

Controller C1(
    .clk(clk),
    .rst_n(rst_n),
    .start(start),     
    .count_done(count_done), 
    .Q0(Q0),           
    .Q_1(Q_1),        

    .ready(ready),
    .en_multr(en_multr), 
    .en_mltd(en_mltd), 
    .en_count(en_count), 
    .en_ac(en_ac),
    .alu_op(alu_op),
    .selQ(selQ),
    .selA(selA), 
    .selQ_1(selQ_1), 
    .en_out(en_out),
    .clear(clear)
);

Datapath D1(
    .clk(clk),
    .rst_n(rst_n),
    .start(start),
    .multiplicand(multiplicand),
    .multiplier(multiplier),
    .accumulator(accumulator),
    .en_multr(en_multr),
    .en_mltd(en_mltd),
    .en_count(en_count),
    .en_ac(en_ac),
    .alu_op(alu_op),
    .selQ(selQ),
    .selA(selA),
    .selQ_1(selQ_1),
    .en_out(en_out),
    .clear(clear),

    .count_done(count_done), 
    .Q0(Q0),           
    .Q_1(Q_1),        
    .product(product)
);
    
endmodule