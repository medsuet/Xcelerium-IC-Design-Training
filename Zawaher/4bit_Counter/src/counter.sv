`timescale 1ns / 1ps

module Counter (
    input logic clk,
    input logic reset,
    output logic [3:0] value,
    output logic counter_clr
);

    logic [3:0] counter;

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            counter <= #1 4'b0000;        // Initialize counter to zero
            counter_clr <= #1 1'b0;       // Initialize counter_clr to zero
        end else if (counter == 4'b1101) begin
            counter <= #1 4'b0000;        // Clear counter when it reaches 13
            counter_clr <= #1 1'b1;       // Set counter_clr
        end else begin
            counter <= #1 counter + 1;    // Increment counter
            counter_clr <= #1 1'b0;       // Reset counter_clr
        end
    end
    
    always_comb begin
        value = counter;               // Assign counter to value output
    end

endmodule
