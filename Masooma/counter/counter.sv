//==============Author: Masooma Zia==============
//==============Date: 25-07-2024==============
//==============Description:4-bit counter with clear bit activated on 13==============
module counter(input logic clk, input logic reset, output logic [3:0] q);
logic [3:0] d;
logic [3:0] d_inc;
logic [3:0] d_clear=0;
logic clear;
always_comb begin
    d_inc = q+1;
    if (q==13) begin
        clear=1;
    end else begin
        clear=0;
    end
    if (clear) begin
        d=d_clear;
    end else begin
        d=d_inc;
    end
end
always_ff@(posedge clk, negedge reset) begin
    if (~reset) begin
        q <= #1 0;
    end else begin
        q <= #1 d;
    end
end
endmodule