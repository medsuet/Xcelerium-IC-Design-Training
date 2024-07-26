module shift_reg(
    input logic clk, rst, D,
    output logic A
);
logic B,Y,X;
    always_comb begin
        Y = ~X;
    end
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin         
            X <= #1 1'b0;  
            B <= #1 1'b0;  
            A <= #1 1'b0; 
        end else begin
            X <= #1 D;     
            B <= #1 Y;     
            A <= #1 B;  
        end
    end

endmodule
