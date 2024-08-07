/*
    Name: counter.sv
    Author: Muhammad Tayyab
    Date: 7-8-2024
    Description: <NUMBITS> wide counter

    Parameter: NUMBITS      : number of bits (width)

    Inputs: clk         : clock signal
            reset       : reset signal: sets count to 0      
            en          : enable: count if enable is 1
            clear       : set count to 0
    
    Output: count:      current value of counter
*/

module counter #(parameter NUMBITS)
(
    input logic clk, reset, en, clear,
    output logic [(NUMBITS-1):0] count
);

always_ff @(posedge clk, negedge reset) begin
    if (!reset)
        count <= 0;
    else if (clear)
        count <= 0;
    else if (en)
        count <= count + 1;
end

endmodule