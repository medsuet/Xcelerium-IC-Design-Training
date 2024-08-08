module datapath (
    input logic clk,
    input logic n_rst,

    input logic [WIDTH-1:0] divisor,    // m
    input logic [WIDTH-1:0] dividend,   // q

    // controller --> datapath
    input logic en_in,
    input logic en_aq,
    input logic sel_a,
    input logic count_en,
    input logic clr,
    input logic en_qr,

    // datapath --> controller
    output logic a_msb,
    output logic n_count,               // n is the number of 
                                        // bits in the dividend
    // Outputs
    output logic [WIDTH-1:0] quotient,
    output logic [WIDTH-1:0] remainder
);

localparam WIDTH = 16;

logic [WIDTH : 0]       m_divisor, sub_am, mux_a, mux_a2;
logic [WIDTH-1 : 0]     q_01, q_00, mux_q, mux_q2;
logic [(2*WIDTH) : 0]   a_div, reg_a_div, mux_aq;
logic [(WIDTH/2): 0]    count, add_count;

// input muxes
assign mux_a2 = (en_aq) ? '0 : mux_a ;
assign mux_q2 = (en_aq) ? dividend : mux_q ;

// divisor register
always_ff @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
        m_divisor <= '0;
    end
    else if (en_in) begin
        m_divisor <= divisor;
    end
    else begin
        m_divisor <= m_divisor;
    end
end

// mux for aq
assign mux_aq = clr ? '0 : {mux_a2, mux_q2};

// a-dividend register
always_ff @(posedge clk or negedge n_rst) begin
    if (!n_rst)begin
        reg_a_div <= '0;
    end
    
    else if (en_qr) begin
        reg_a_div <= reg_a_div;
    end

    else begin
        reg_a_div <= mux_aq;
    end
end

// step-1: shift left 
assign a_div = reg_a_div << 1;

// step-2: A = A - divisor
assign sub_am = a_div[2*WIDTH:WIDTH] + (~divisor + 1'b1);
assign a_msb = sub_am[WIDTH];

// step-3: sel-A 
//  case: msb of sub_am is 1 then restore A else not.
assign mux_a = (sel_a) ? a_div[2*WIDTH:WIDTH] : sub_am;

//  case: msb of sub_am is 1 then lsb of a_div is zero.
assign q_01  = a_div[WIDTH-1:0] | (16'h0001);
assign q_00  = a_div[WIDTH-1:0] & (16'hFFFE);

assign mux_q = (sel_a) ? q_00 : q_01; 

// counter
always_ff @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
        count <= '0;
    end
    else begin
        if (count_en) count <= add_count;
        else if (clr) count <= '0;
        else count <= '0;
    end
end

// adder
assign add_count = count + 1;

// comparator
assign n_count = (count == (WIDTH)) ? 1'b1 : 1'b0;

assign quotient = (en_qr) ? reg_a_div[WIDTH-1:0] : '0;
assign remainder = (en_qr) ? reg_a_div[2*WIDTH-1:WIDTH] : '0;
    
endmodule