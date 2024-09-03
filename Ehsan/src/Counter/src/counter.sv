module counter (
    input logic clk,       
    input logic rst,        
    output logic [3:0] Q
);  
logic [3:0] adder;
logic [3:0] mux_out;
logic clear_bit;

always_comb  begin
    //adder
    adder = Q + 1;

    //comparitor
    if (Q == 4'b1101) begin
        clear_bit = 1'b1;
    end
    else begin
        clear_bit = 0;
    end

    //mux
    if (clear_bit) begin
        mux_out = 4'b0000;
    end
    else begin
        mux_out = adder;
    end
end

always_ff @(posedge clk or negedge rst) begin
    if (!rst) begin
        Q <= 4'b0000; 
    end 
    else begin
        Q <= mux_out; 
    end
end

endmodule

