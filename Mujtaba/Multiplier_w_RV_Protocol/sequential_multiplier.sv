module sequential_multiplier #(parameter WIDTH = 16) (
    input logic clk, reset,
    input logic input_valid,
    input logic output_ready,
    input logic [WIDTH-1:0] Multiplicand,
    input logic [WIDTH-1:0] Multiplier,
    output logic [2*WIDTH-1:0] Product,
    output logic output_valid,
    output logic input_ready
);

    logic [3:0] SCval;
    logic mupdEn;
    logic muprEn;
    logic SCEn;
    logic psEn;
    logic muxsel;
    logic resEn;
    logic restore_reg;

    datapath d1(.Multiplicand(Multiplicand), .Multiplier(Multiplier), .mupdEn(mupdEn), .muprEn(muprEn), .SCEn(SCEn), .psEn(psEn), .muxsel(muxsel), .restore_reg(restore_reg), .resEn(resEn), .clk(clk), .reset(reset), .SCval(SCval), .Product(Product));

    controller c1(.input_valid(input_valid), .output_ready(output_ready), .clk(clk), .reset(reset), .SCval(SCval), .mupdEn(mupdEn), .muprEn(muprEn), .SCEn(SCEn), .restore_reg(restore_reg), .muxsel(muxsel), .psEn(psEn), .resEn(resEn), .output_valid(output_valid), .input_ready(input_ready));

 endmodule
