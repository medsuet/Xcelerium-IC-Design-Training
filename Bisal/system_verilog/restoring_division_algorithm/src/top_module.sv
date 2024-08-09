module Top_Module(
    input logic clk,
    input logic reset,
    input logic src_valid,
    input logic dst_ready,
    input logic [31:0] Q,
    input logic [31:0] M,
    output logic [31:0] Quotient,
    output logic [31:0] Remainder,
    output logic dst_valid,
    output logic src_ready
);

    logic enReg, enCount, enShift, mux_sel, clear;
    logic [4:0] count;
    logic [31:0] regA;

    // Instantiate Control Unit
    Control_Unit cu(
        .clk(clk),
        .reset(reset),
        .src_valid(src_valid),
        .dst_ready(dst_ready),
        .regA(regA),
        .count(count),
        .enReg(enReg),
        .enCount(enCount),
        .enShift(enShift),
        .dst_valid(dst_valid),
        .src_ready(src_ready),
        .mux_sel(mux_sel),
        .clear(clear)
    );

    // Instantiate Data Path
    Data_path dp(
        .clk(clk),
        .reset(reset),
        .enReg(enReg),
        .enCount(enCount),
        .enShift(enShift),
        .mux_sel(mux_sel),
        .clear(clear),
        .Q(Q),
        .M(M),
        .Quotient(Quotient),
        .Remainder(Remainder),
        .count(count),
        .regA(regA)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, Top_Module);
    end

endmodule
