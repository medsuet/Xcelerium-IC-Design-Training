module sequential_multiplier #(parameter WIDTH = 16) (
    input logic clk, reset,
    input logic src_valid,
    input logic dest_ready,
    input logic [WIDTH-1:0] Multiplicand,
    input logic [WIDTH-1:0] Multiplier,
    output logic [2*WIDTH-1:0] Product,
    output logic dest_valid,
    output logic src_ready
);

    logic [3:0] SCval;
    logic mupdEn;
    logic muprEn;
    logic SCEn;
    logic psEn;
    logic muxsel;
    logic restore_reg;

    datapath d1(.Multiplicand(Multiplicand), .Multiplier(Multiplier), .mupdEn(mupdEn), .muprEn(muprEn), .SCEn(SCEn), .psEn(psEn), .muxsel(muxsel), .restore_reg(restore_reg), .clk(clk), .reset(reset), .SCval(SCval), .Product(Product));

    controller c1(.src_valid(src_valid), .dest_ready(dest_ready), .clk(clk), .reset(reset), .SCval(SCval), .mupdEn(mupdEn), .muprEn(muprEn), .SCEn(SCEn), .restore_reg(restore_reg), .muxsel(muxsel), .psEn(psEn), .dest_valid(dest_valid), .src_ready(src_ready));

    initial begin
        $dumpfile("sequential_multiplier_tb.vcd");
        $dumpvars(0, sequential_multiplier);
    end
 endmodule
