`include "counter.sv"
`include "flipflop.sv"
`include "shift_A.sv"
`include "shift_dd.sv"
module restore_dp(input logic clk, input logic rst, input logic [31:0] dd,input logic [31:0] ds,output logic [31:0] quo,output logic [31:0] rem,
input logic A_sel, dd_sel, en_A, en_dd, en_ds, MSB_set,en_ct, output logic clear, output logic [31:0] A_shift_opr);
logic [5:0] c_out;
logic [31:0] A_in,A_mux_out,A_shift_out;
logic [31:0] dd_in,dd_mux_out,dd_shift_out, ds_out;
logic [31:0] A=0;
counter ct(.clk(clk),.rst(rst),.q(c_out),.clear(clear),.en(en_ct));
always@(*) begin
    if (MSB_set) begin
        A_mux_out=A_shift_out;
    end else begin
        A_mux_out=A_shift_opr;
    end
    if (MSB_set) begin
        dd_mux_out={dd_shift_out[31:1],1'b0};
    end else begin
        dd_mux_out={dd_shift_out[31:1],1'b1};
    end
    if (A_sel) begin
        A_in=A_mux_out;
    end else begin
        A_in=A;
    end
    if (dd_sel) begin
        dd_in=dd_mux_out;
    end else begin
        dd_in=dd;
    end
end
shift_A sh_A(.clk(clk),.rst(rst),.en(en_A),.in(A_in),.shift_reg_out(A_shift_out), .dd_in(dd_in));
shift_dd sh_dd(.clk(clk),.rst(rst),.en(en_dd),.in(dd_in),.shift_reg_out(dd_shift_out));
flipflop ff_ds(.clk(clk),.rst(rst),.d(ds),.en(en_ds),.q(ds_out));

always@(*) begin
    A_shift_opr=A_shift_out-ds_out;
    quo=dd_mux_out;
    rem=A_mux_out;
end
endmodule