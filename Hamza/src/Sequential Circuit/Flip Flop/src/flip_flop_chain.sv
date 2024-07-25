module flip_flop_chain (
    input logic clk,         // Clock signal
    input logic reset,       // Reset signal
    input logic D,           // Input to the first flip-flop
    output logic A           // Output of the third flip-flop
);

    // Intermediate signals for flip flop and invertor outputs
    logic X;  
    logic Y;  
    logic B; 

    // Combinational logic for inverter
    always_comb begin
        Y = ~X; 
    end

    // Asynchronous logic for flip-flops with asynchronous reset
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the flip flop outputs
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
