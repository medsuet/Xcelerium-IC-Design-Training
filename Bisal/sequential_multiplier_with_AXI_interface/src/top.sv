module Top_Module(
    input logic clk,
    input logic reset,
    input logic src_valid,
    input logic dst_ready,
    input logic [15:0] A,
    input logic [15:0] B,
    output logic [31:0] P,
    output logic src_ready,
    output logic dst_valid
);

    // Wires to connect Control Unit and Data Path
    logic enReg, enCount, enShift;
    logic [3:0] count;

    // Instantiate the Control Unit
    Control_Unit cu (
        .clk(clk),
        .reset(reset),
        .src_valid(src_valid),
        .dst_ready(dst_ready),
        .enReg(enReg),
        .count(count),
        .enCount(enCount),
        .enShift(enShift),
        .dst_valid(dst_valid),
        .src_ready(src_ready)
    );

    // Instantiate the Data Path
    Data_path dp (
        .clk(clk),
        .reset(reset),
        .enReg(enReg),
        .dst_valid(dst_valid),
        .enCount(enCount),
        .enShift(enShift),
        .A(A),
        .B(B),
        .P(P),
        .count(count)
    );

endmodule
