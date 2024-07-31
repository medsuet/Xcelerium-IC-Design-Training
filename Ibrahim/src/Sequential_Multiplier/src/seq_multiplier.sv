`include "src/Datapath.sv"
`include "src/Controller.sv"

module seq_multiplier #(
    parameter WIDTH = 16
) (
    input logic                  clk,           // Clock signal
    input logic                  rst_n,         // Active-low reset signal
    input logic                  start,         // Start signal
    input logic [WIDTH-1:0]      multiplier,    // Multiplier input
    input logic [WIDTH-1:0]      multiplicand,  // Multiplicand input

    output logic [(2*WIDTH)-1:0] product,       // Product output
    output logic                 ready          // Ready signal indicating the end of multiplication
);

// Internal signals
logic count_done, Q0, Q_1, en_multr, clear; 
logic en_mltd, en_count, en_ac, selQ, selQ_1, selA, en_out;  // Control signals
logic [1:0] alu_op;  // ALU operation code

// Controller instance to handle state transitions and control signals
Controller #(
    .WIDTH(WIDTH)
) C1(
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

// Datapath instance to handle the multiplication operations and data flow
Datapath #(
    .WIDTH_M(WIDTH),
    .WIDTH_P(2 * WIDTH)
) D1(
    .clk(clk),
    .rst_n(rst_n),
    .start(start),
    .multiplicand(multiplicand),
    .multiplier(multiplier),

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
