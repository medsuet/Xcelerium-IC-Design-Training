module comb_multiplier(
    input logic signed [15:0] a,
    input logic signed [15:0] b,
    output logic signed [31:0] prod
);

    logic signed [31:0] extend_b;
    logic signed [31:0] sum;
    assign extend_b = {{16{b[15]}}, b};
    
    always_comb begin
        sum = 0;
        for (int i=0; i<16; i++) begin
            if (i != 15) begin
                sum  =  sum + (({32{a[i]}} & extend_b) << i);
            end else if (a[i] == 1 && i == 15) begin
                sum = sum + ((~({32{a[i]}} & extend_b) + 1) << i);
            end else begin
                sum  =  sum + (({32{a[i]}} & extend_b) << i);
            end
        end
        prod = sum;
    end
endmodule
