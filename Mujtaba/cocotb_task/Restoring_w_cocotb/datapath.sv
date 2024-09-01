module datapath #(parameter WIDTH = 16) (
    input logic reset, clk,
    input logic divisor_en,
    input logic dividend_en,
    input logic acc_en,
    input logic SCEn,
    input logic restore_reg,
    input logic sh_en,
    input logic [WIDTH-1:0] Divisor,
    input logic [WIDTH-1:0] Dividend,
    output logic [4:0] SCval,
    output logic [WIDTH-1:0] Quotient,
    output logic [WIDTH-1:0] Remainder
);

    logic [WIDTH:0] divisor_out;
    logic q_msb;
    logic m1_out;
    logic [WIDTH:0] acc_out;
    logic [WIDTH:0] m2_out;
    logic [WIDTH:0] AM_sub;

    divisor_reg dvr1(.reset(reset), .clk(clk), .divisor_en(divisor_en), .Divisor(Divisor), .divisor_out(divisor_out));
    dividend_reg dvd1(.reset(reset), .clk(clk), .dividend_en(dividend_en), .sh_en(sh_en), .q_lsb(m1_out), .Dividend(Dividend), .Quotient(Quotient), .q_msb(q_msb));
    acc_reg a1(.reset(reset), .clk(clk), .r_lsb(q_msb), .acc_en(acc_en), .restore_reg(restore_reg), .acc_in(m2_out), .acc_out(acc_out), .Remainder(Remainder));
    mux2x1 #(1) m1(.sel0(1'b1), .sel1(1'b0), .sel(AM_sub[WIDTH]), .out(m1_out));
    mux2x1 #(17) m2(.sel0(AM_sub), .sel1(acc_out), .sel(AM_sub[WIDTH]), .out(m2_out));
    Sequence_Counter sc1(.clk(clk), .reset(reset), .SCEn(SCEn), .restore_reg(restore_reg), .out(SCval));
    subtracter sub1(.op1(acc_out), .op2(divisor_out), .sub_out(AM_sub));

endmodule


module divisor_reg #(parameter WIDTH = 16) (
    input logic reset, clk,
    input logic divisor_en,
    input logic [WIDTH-1:0] Divisor,
    output logic [WIDTH:0] divisor_out
);

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            divisor_out <= 0;
        end else begin
            if (divisor_en) begin
                divisor_out <= {1'b0, Divisor};
            end else begin
                divisor_out <= divisor_out;
            end
        end
    end

 endmodule
 
module dividend_reg #(parameter WIDTH = 16) (
    input logic reset, clk,
    input logic dividend_en,
    input logic sh_en,
    input logic q_lsb,
    input logic [WIDTH-1:0] Dividend,
    output logic [WIDTH-1:0] Quotient,
    output logic q_msb
);

    assign q_msb = Quotient[WIDTH-1];
    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            Quotient <= 0;
        end else begin
            if (dividend_en) begin
                Quotient <= Dividend;
            end else if  (sh_en) begin
                Quotient <= {Quotient[WIDTH-2:0], 1'b0};
                Quotient[0] <= q_lsb;
            end else begin
                Quotient <= Quotient;
            end
        end
    end

endmodule

module acc_reg #(parameter WIDTH = 16) (
    input logic reset, clk,
    input logic r_lsb,
    input logic acc_en,
    input logic restore_reg,
    input logic [WIDTH:0] acc_in,
    output logic [WIDTH:0] acc_out,
    output logic [WIDTH-1:0] Remainder
);

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            acc_out <= 0;
            Remainder <= 0;
        end else begin
            if (restore_reg) begin
                acc_out <= 0;
            end else if (acc_en) begin
                acc_out <= {acc_in[WIDTH-1:0], r_lsb};
                Remainder <= acc_in[WIDTH-1:0];
            end else begin
                acc_out <= acc_out;
                Remainder <= Remainder;
            end
        end
    end

endmodule

module mux2x1 #(parameter WIDTH = 17) (
    input logic [WIDTH-1:0] sel0,
    input logic [WIDTH-1:0] sel1,
    input logic sel, 
    output logic [WIDTH-1:0] out
);

    always_comb begin
        case (sel)
            1'h0: out = sel0;
            1'h1: out = sel1;
        endcase
    end

endmodule

module subtracter #(parameter WIDTH = 17) (
    input logic [WIDTH-1:0] op1,
    input logic [WIDTH-1:0] op2,
    output logic [WIDTH-1:0] sub_out
);

    assign sub_out = op1 - op2;

endmodule

module Sequence_Counter (
     input logic clk,
     input logic reset,
     input logic SCEn,
     input logic restore_reg,
     output logic [4:0] out
);

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            out <= 1;
        end else begin
            if (restore_reg) begin
                out <= 1;
            end else if (SCEn) begin
                out <= out + 1;
            end else begin
                out <= out;
            end 
        end
    end

endmodule
 
