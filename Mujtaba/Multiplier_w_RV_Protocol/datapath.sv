module datapath #(parameter WIDTH = 16) (
    input logic [WIDTH-1:0] Multiplicand,
    input logic [WIDTH-1:0] Multiplier,
    input logic mupdEn,
    input logic muprEn,
    input logic SCEn,
    input logic psEn,
    input logic muxsel,
    input logic restore_reg,
    input logic clk,
    input logic reset,
    output logic [3:0] SCval,
    output logic [2*WIDTH-1:0] Product
);
    logic [WIDTH-1:0] mupdout;
    logic [WIDTH-1:0] muprout;
    logic [2*WIDTH-1:0] signExOut;
    logic muxsel1;
    logic [3:0] count;
    logic [2*WIDTH-1:0] mux1out;
    logic [2*WIDTH-1:0] mux2out;
    logic [2*WIDTH-1:0] mux2shOut;
    logic [2*WIDTH-1:0] rcaOut;
    
    Register MultiplicanReg(.in(Multiplicand), .clk(clk), .en(mupdEn), .reset(reset), .out(mupdout));
    Register MultiplierReg(.in(Multiplier), .clk(clk), .en(muprEn), .reset(reset), .out(muprout));
    mux16x1 m3(.in(muprout), .sel(SCval), .out(muxsel1));
    signExtend SignE1(.in(mupdout), .out(signExOut));
    mux2x1 m1(.sel0(32'h0), .sel1(signExOut), .sel(muxsel1), .out(mux1out));
    mux2x1 m2(.sel0(mux1out), .sel1((~mux1out)+1), .sel(muxsel), .out(mux2out));
    PartialSum ps1(.in(rcaOut), .clk(clk), .reset(reset), .en(psEn), .restore_reg(restore_reg), .out(Product));
    LeftShift lls1(.in(mux2out), .sha(SCval), .out(mux2shOut));
    Adder #(32) a1(.a(mux2shOut), .b(Product), .out(rcaOut));
    Sequence_Counter Sc1(.clk(clk), .reset(reset), .en(SCEn), .out(SCval));

endmodule

module Adder #(parameter WIDTH = 4) (
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    output logic [WIDTH-1:0] out
);
    assign out = a+b;

 endmodule

module Register #(parameter WIDTH = 16) (
    input logic [WIDTH-1:0] in,
    input logic clk,
    input logic en,
    input logic reset,
    output logic [WIDTH-1:0] out
);

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            out <= 0;
        end else begin
            if (en) begin
                out <= in;
            end else begin
                out <= out;
            end
        end
    end

endmodule

module PartialSum (
    input logic [31:0] in,
    input logic clk, reset,
    input logic en,
    input logic restore_reg,
    output logic [31:0] out
);

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            out <= 0;
        end else begin
            if (restore_reg) begin
                out <= 0;
            end else if (en) begin
                out <= in;
            end else begin
                out <= out;
            end 
        end
    end

endmodule

module mux2x1 #(parameter WIDTH = 32) (
    input logic [WIDTH-1:0] sel0,
    input logic [WIDTH-1:0] sel1,
    input logic sel,
    output logic [WIDTH-1:0] out
);

    always_comb begin
        case(sel)
            1'h0: out = sel0;
            1'h1: out = sel1;
            default: out = 1'hx;
        endcase
    end

 endmodule

module mux16x1 (
    input logic [15:0] in,
    input logic [3:0] sel,
    output logic out
);

    always @(*) begin
        case(sel)
            4'h0: out = in[0];
            4'h1: out = in[1];
            4'h2: out = in[2];
            4'h3: out = in[3];
            4'h4: out = in[4];
            4'h5: out = in[5];
            4'h6: out = in[6];
            4'h7: out = in[7];
            4'h8: out = in[8];
            4'h9: out = in[9];
            4'hA: out = in[10];
            4'hB: out = in[11];
            4'hC: out = in[12];
            4'hD: out = in[13];
            4'hE: out = in[14];
            4'hF: out = in[15];
            default: out = 1'hx;
        endcase
    end

endmodule

module signExtend (
    input logic [15:0] in,
    output logic [31:0] out
);

    assign out = {{16{in[15]}}, in};

endmodule

 module Sequence_Counter (
     input logic clk,
     input logic reset,
     input logic en,
     output logic [3:0] out
);

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            out <= 0;
        end else begin
            if (en) begin
                out <= out + 1;
            end else begin
                out <= out;
            end 
        end
    end

endmodule
 
module LeftShift (
    input logic [31:0] in,
    input logic [3:0] sha,
    output logic [31:0] out
);

    assign out = in << sha;

 endmodule
