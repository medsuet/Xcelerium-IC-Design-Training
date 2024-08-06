module sequential_multiplier #(parameter WIDTH = 16) (
    input logic clk, reset,
    input logic start,
    input logic [WIDTH-1:0] Multiplicand,
    input logic [WIDTH-1:0] Multiplier,
    output logic [2*WIDTH-1:0] Product,
    output logic ready
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

    controller c1(.start(start), .clk(clk), .reset(reset), .SCval(SCval), .mupdEn(mupdEn), .muprEn(muprEn), .SCEn(SCEn), .restore_reg(restore_reg), .muxsel(muxsel), .psEn(psEn), .resEn(resEn), .ready(ready));

 endmodule
