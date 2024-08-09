module flip_flop(
    input logic d,
    input logic clk,
    input logic reset,
    output logic q1,q2,q3
);
    // first flip flop 
    always_ff @( posedge clk ) begin 
        if (reset) begin
            q1 <= #1 0;
            q2 <= #1 0;
            q3 <= #1 0;
        end
        else begin
            q1 <= #1 d;
            q2 <= #1 ~q1;
            q3 <= #1 q2;
        end
    end
endmodule
