module counter #(parameter WIDTH = 4) (
    input logic clk,
    input logic reset,
    output logic clear,
    output logic [WIDTH-1:0] D_out,
    output logic [WIDTH-1:0] mux_out,  
    output logic [WIDTH-1:0] Q
);
    incrementer incr1(.val(Q), .reset(reset), .incr(D_out));
    mux2x1 mux1(.a(D_out), .b(4'h0), .sel(clear), .out(mux_out));
    comparater cmp1(.a(Q), .b(4'hd), .clear(clear));
    D_flipflops dff1(.a(mux_out), .clk(clk), .reset(reset), .out(Q));

endmodule


module mux2x1 #(parameter WIDTH = 4) ( 
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    input logic sel,
    output logic [WIDTH-1:0] out
);

    always_comb begin
        case(sel)
            1'h0: out = a;
            1'h1: out = b;
            default: out = 4'hx;
        endcase
    end
endmodule

module incrementer #(parameter WIDTH = 4) (
    input logic [WIDTH-1:0] val,
    input logic reset,
    output logic [WIDTH-1:0] incr
);

    always_comb begin
        if (reset) begin
            incr = 0;
        end else begin
            incr = val + 1;
        end
    end

endmodule

module comparater #(parameter WIDTH = 4) (
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    output logic clear
);

    always_comb begin
        if (a == b) begin
            clear = 1;
        end else begin
            clear = 0;
        end
    end

endmodule

module D_flipflops #(parameter WIDTH = 4) (
    input logic [WIDTH-1:0] a,
    input logic clk, reset,
    output logic [WIDTH-1:0] out
);

    always_ff @(posedge clk) begin
        if (reset) begin
            out <= #1 0;
        end else begin
            out <= #1 a;
        end
    end

endmodule
