//==============Author: Masooma Zia==============
//==============Date: 29-07-2024==============
//==============Description:Datapath for 16-bit signed sequential multiplier==============
`include "flipflop.sv"
`include "counter.sv"
`include "shift_q.sv"
`include "shift_A.sv"
module mul_dp(input logic clk, input logic rst, input logic en_shift_A, en_shift_q, en_m, en_q, en_A, en_ct,
input logic q_sel, A_sel, input logic m_mux_sel, A_mux_sel, input logic [15:0] q, 
input logic [15:0] m, input logic m_sel, output logic [31:0] p, output logic [16:0] q_shift_out, output logic clear);
logic [31:0] p_cal;
logic [15:0] m_mux_out, A_mux_out;
logic [16:0] q_in;
logic [15:0] A_in, A_new, A_shift_out, m_out, m_in;
logic [15:0] A=0;
logic [4:0] c_out;
counter ct(.clk(clk), .rst(rst), .q(c_out), .clear(clear), .en(en_ct));
//mux for selecting right signal according to control signals
always_comb begin
    if (m_sel) begin
        m_in=m;
    end else begin
        m_in=m_out;
    end
    if (q_sel) begin
        q_in={q,1'b0};
    end else begin
        q_in=q_shift_out;
    end
    if (m_mux_sel) begin
        m_mux_out=(~m_out)+1;
    end else begin
        m_mux_out=m_out;
    end
    if (A_mux_sel) begin
        A_mux_out=A_shift_out;
    end else begin
        A_mux_out=A_new;
    end
    if (A_sel) begin
        A_in=0;
    end else if (~A_sel) begin
        A_in=A_mux_out;
    end
end
//shift register for multiplier and accumulator
    shift_q sh1(.clk(clk), .rst(rst), .in(q_in), .shift_en(en_shift_q), .en_q(en_q), .shift_reg_out(q_shift_out), .A_in(A_in));
    shift_A sh2(.clk(clk), .rst(rst), .in(A_in),.shift_en(en_shift_A), .en_A(en_A), .shift_reg_out(A_shift_out));
//flipflop for storing multiplicand
    flipflop ff(.clk(clk),.rst(rst),.d(m_in),.en(en_m),.q(m_out));
always@(*) begin
    A_new=A_shift_out+m_mux_out;
    p_cal[15:0]=q_shift_out[16:1];
    p_cal[31:16]=A_shift_out;
end
assign p=p_cal;
    
endmodule


    

