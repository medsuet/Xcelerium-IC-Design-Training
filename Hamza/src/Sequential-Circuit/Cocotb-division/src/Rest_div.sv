// Restoring Division module parameterized by WIDTH
module Rest_div #(
    parameter WIDTH = 16
) (
    input logic              clk,           
    input logic              reset,         
    input logic              src_valid,    
    input logic              dest_ready,   
    input logic [WIDTH-1:0]  dividend,     
    input logic [WIDTH-1:0]  divisor,      
    output logic [WIDTH-1:0] quotient,     
    output logic [WIDTH-1:0] remainder,    
    output logic             dest_valid,   
    output logic             src_ready     
);

logic alu_op, count_comp, en_A, en_M, en_Q, en_count, sel_A, sel_Q;
logic en_out, en_final, clear, sub_msb;

// Controller instance to handle state transitions and control signals
Controller Controller(
    .clk(clk),
    .reset(reset),
    .src_valid(src_valid),
    .dest_ready(dest_ready),     
    .count_comp(count_comp), 
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

// Datapath instance to perform the division operation
Datapath #(
    .WIDTH_M(WIDTH)
) Datapath(
    .clk(clk),
    .reset(reset),
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

    .count_comp(count_comp), 
    .sub_msb(sub_msb),        
    .quotient(quotient),
    .remainder(remainder)
);

endmodule
