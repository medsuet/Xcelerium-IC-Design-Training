module comb_multiplier#(parameter WIDTH = 16) (
    input logic signed [WIDTH-1:0] a,
    input logic signed [WIDTH-1:0] b,
    output logic signed [2*WIDTH-1:0] prod
);

    logic signed [2*WIDTH-1:0] extend_b;
    logic signed [2*WIDTH-1:0] sum;
    assign extend_b = {{WIDTH{b[15]}}, b};
    
    always_comb begin
        sum = 0;
        for (int i=0; i<WIDTH; i++) begin
            if (i != WIDTH-1) begin
                sum  =  sum + (({2*WIDTH{a[i]}} & extend_b) << i);
            end else if (a[i] == 1 && i == WIDTH-1) begin
                sum = sum + ((~({2*WIDTH{a[i]}} & extend_b) + 1) << i);
            end else begin
                sum  =  sum + (({2*WIDTH{a[i]}} & extend_b) << i);
            end
        end
        prod = sum;
    end
endmodule
