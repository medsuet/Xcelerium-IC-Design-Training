module Mux (
    input logic [15:0]  in0,  // Input 0
    input logic [15:0]  in1,  // Input 1
    input logic         sel,  // Select signal
    output logic [15:0] out   // Output
);

    always_comb begin
        if (sel)
            out = in1;
        else
            out = in0;
    end

endmodule
