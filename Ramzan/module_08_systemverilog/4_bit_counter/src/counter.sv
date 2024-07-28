module counter(
    input logic CLK,
    input logic RST,
    output logic [3:0] Q
);

    localparam MAX_COUNT = 4'd13;
    logic [3:0] D;
    logic [3:0] A;
    logic CLEAR;

    initial begin
        assign CLEAR = (Q==MAX_COUNT);
        assign A = (Q + 1);
        assign D = CLEAR ? 4'b0000 : A;
    end
    
    always_ff @(posedge CLK) begin
        if (RST) begin
            Q <= #1 4'b0000;        // Update the counter
        end
        else begin 
            Q <= #1 D;              // Assign the counter output
        end
    end

endmodule
        
