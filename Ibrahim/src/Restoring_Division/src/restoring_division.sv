`include "src/Datapath.sv"
`include "src/Controller.sv"
module restoring_division #(
    parameter WIDTH = 16
) (
    input logic              clk,
    input logic              rst_n,
    input logic              src_valid,
    input logic              dest_ready,
    input logic [WIDTH-1:0]  dividend,
    input logic [WIDTH-1:0]  divisor,

    output logic [WIDTH-1:0] quotient,
    output logic [WIDTH-1:0] remainder,
    output logic             dest_valid,
    output logic             src_ready
);

logic alu_op, count_done, en_A, en_M, en_Q, en_count, sel_A, sel_Q;
logic en_out, en_final, clear, sub_msb;

// Controller instance to handle state transitions and control signals
Controller C1(
    .clk(clk),
    .rst_n(rst_n),
    .src_valid(src_valid),
    .dest_ready(dest_ready),     
    .count_done(count_done), 
    .sub_msb(sub_msb),      

    .src_ready(src_ready),
    .dest_valid(dest_valid),
    .en_M(en_M), 
    .en_Q(en_Q), 
    .en_count(en_count), 
    .en_A(en_A),
    .alu_op(alu_op),
    .sel_Q(sel_Q),
    .sel_A(sel_A), 
    .en_out(en_out),
    .en_final(en_final),
    .clear(clear)
);

Datapath #(
    .WIDTH_M(WIDTH)
) D1(
    .clk(clk),
    .rst_n(rst_n),
    .dividend(dividend),
    .divisor(divisor),
    .en_M(en_M),
    .en_Q(en_Q),
    .en_count(en_count),
    .en_A(en_A),
    .alu_op(alu_op),
    .sel_Q(sel_Q),
    .sel_A(sel_A),
    .en_out(en_out),
    .en_final(en_final),
    .clear(clear),

    .count_done(count_done), 
    .sub_msb(sub_msb),        
    .quotient(quotient),
    .remainder(remainder)
);

endmodule
