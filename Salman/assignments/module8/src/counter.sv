module counter (
    input logic CLK,            // Clock Signal
    input logic RESET,          // Reset -- Active Low -- Asynchronous Reset
    output logic [3:0] COUNT    // Counter Word
);

localparam MAX = 4'd13;     // Max Count Limit

logic clear;                // Clear Signal
logic [3:0] D,Q;                  // Counter Input (D), Output (Q)

assign COUNT = Q;           // Since Counter Output (Q) is 'COUNT'

always_comb 
begin
    clear = (Q == MAX);

    D = (clear) ? 4'd0 : (Q+1);
end

always_ff @(posedge CLK or negedge RESET)
begin
    if (!RESET)
    begin
        Q <= #1 0;
    end
    else 
    begin
        Q <= #1 D;
    end
end
endmodule