module Mux #(
    parameter WIDTH = 16    // Width of the inputs and output
) (
    input logic [WIDTH-1:0]  in0,  // Input 0
    input logic [WIDTH-1:0]  in1,  // Input 1
    input logic              sel,  // Select signal
    output logic [WIDTH-1:0] out   // Output
);

    always_comb begin
        if (sel)
            out = in1;
        else
            out = in0;
    end

endmodule
