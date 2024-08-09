module restoring_division (
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
localparam NUM_1 = 16'h1;

// Datapath Signals

logic [WIDTH:0] reg_m;
logic [WIDTH:0] reg_a;
logic [WIDTH-1:0] reg_q;

logic [(2*WIDTH):0] shift_aq, unit_aq;
logic [WIDTH:0] split_a, a_subtract_m;
logic [WIDTH-1:0] split_q;

logic [WIDTH-1:0] mux_q_input, mux_q_feedback;
logic [WIDTH:0] mux_a_feedback, mux_a_input;
logic [(WIDTH/4)-1:0] count, mux_count;

// Controller Signals

logic en_aq, en_m;
logic msb_a, mux_aq, sel_aq;
logic stop, count_en, clear;

assign msb_a = a_subtract_m[WIDTH];
assign stop = (count == (WIDTH - 1));


// ################
//    Controller
// ################
controller controller(
    .clk(clk),
    .reset(reset),
    // Controller I/O's
    .msb_a(msb_a),
    .stop(stop),
    .mux_aq(mux_aq),
    .en_aq(en_aq),
    .en_m(en_m),
    .sel_aq(sel_aq),
    .clear(clear),
    .count_en(count_en),
    // Ready-valid signals
    .src_valid(src_valid),
    .src_ready(src_ready),
    .dst_ready(dst_ready),
    .dst_valid(dst_valid)
);

// ################
//     Datapath
// ################

// Mux before input registers - Selecter is mux_aq
always_comb 
begin
    mux_a_input = (mux_aq) ? 0 : mux_a_feedback;
    mux_q_input = (mux_aq) ? dividend : mux_q_feedback;
end

// Input registers - Enable is en_aq and en_m
// Asynchronous Active Low Reset
always_ff @(posedge clk or negedge reset) 
begin
    if (!reset)
    begin
        reg_m <= #1 0;
        reg_a <= #1 0;
        reg_q <= #1 0;
    end
    else
    begin
        if (en_m)
            reg_m <= #1 divisor;

        if (en_aq)
        begin
            reg_a <= #1 mux_a_input;
            reg_q <= #1 mux_q_input;
        end
    end
end

// Unit_AQ, Left Shift, Unit_AQ Split
always @(*)
begin
    unit_aq = {reg_a, reg_q};
    shift_aq = unit_aq << 1;

    split_a = shift_aq[(2*WIDTH): WIDTH];
    split_q = shift_aq[WIDTH-1:0];
end

// AQ Feedback Mux - Selected is sel_aq
always_comb 
begin
    // A Feedback Mux
    a_subtract_m = split_a - reg_m;
    mux_a_feedback = (sel_aq) ? split_a : a_subtract_m;

    // Q Feedback Mux
    //mux_q_feedback = (sel_aq) ? (split_q & (!(NUM_1))) : (split_q | (NUM_1));
    if (sel_aq)
        mux_q_feedback = split_q & (~NUM_1);
    else
        mux_q_feedback = split_q | NUM_1;
end

// Output Mux - Selector is dst_valid
always_comb
begin
    remainder = (dst_valid) ? mux_a_feedback[WIDTH-1:0] : 0;
    quotient = (dst_valid) ? mux_q_feedback : 0;
end

// Counter Mux - Selector is clear
always_comb
begin
    //mux_count = (clear) ? 0: (count+1);
    if (clear)
        mux_count = 0;
    else
        mux_count = count+1;
end

// Counter logic
always_ff @(posedge clk or negedge reset)
begin
    if (!reset)
        count <= #1 0;
    else if (count_en | clear)
        count <= #1 mux_count;
end
    
endmodule