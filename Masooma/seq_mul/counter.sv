module counter(input logic clk, input logic rst, output logic [4:0] q, output logic clear, input logic en);
logic [4:0] d_inc;
logic [4:0] d;
logic [4:0] d_clear=0;
always_comb begin
    d_inc = q+1;
    if (q==17) begin
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
always_ff@(posedge clk, negedge rst) begin
    if (~rst) begin
        q <= 0;
    end else if(en) begin
        q <= d;
    end
end
endmodule