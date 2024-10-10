//==============Author: Masooma Zia==============
//==============Date: 29-07-2024==============
//==============Description:Top module for 16-bit signed sequential multiplier==============
`include "mul_dp.sv"
`include "mul_ctrl.sv"
module mul(input signed clk, input signed rst, input signed [15:0] q, input signed [15:0] m, input signed start, output signed [31:0] p, output signed ready);
logic en_shift_A, en_shift_q, en_m, A_mux_sel, m_mux_sel, q_sel, A_sel, en_q, en_A;
logic clear;
logic [16:0] q_shift_out;
logic m_sel, en_ct;
mul_dp datapath(.clk(clk), .rst(rst), .en_shift_A(en_shift_A), .en_shift_q(en_shift_q), .en_m(en_m), 
.q_sel(q_sel), .A_sel(A_sel), .m_mux_sel(m_mux_sel), .A_mux_sel(A_mux_sel),  .q(q), .m(m), .p(p), .m_sel(m_sel), .q_shift_out(q_shift_out), 
.clear(clear), .en_A(en_A), .en_q(en_q), .en_ct(en_ct));
mul_ctrl controller(.clk(clk), .rst(rst), .start(start), .q_shift_out(q_shift_out), .clear(clear), .ready(ready),
.q_sel(q_sel), .A_sel(A_sel), .m_mux_sel(m_mux_sel), .A_mux_sel(A_mux_sel), .en_shift_q(en_shift_q), .en_m(en_m), .en_shift_A(en_shift_A), 
.m_sel(m_sel), .en_A(en_A), .en_q(en_q), .en_ct(en_ct));
endmodule