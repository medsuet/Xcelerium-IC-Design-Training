`include "../define/array_mul.svh"

module array_multiplier (
    input logic     clk,reset,
    input logic     [width-1:0]multiplicand,multiplier,
    input logic     start,
    output logic    [result_width-1:0]product,
    output logic    ready
);

logic start_tx,counted_15,counted,get_output;


array_multiplier_datapath  DP(

         .clk(clk),.reset(reset),
         .start_tx(start_tx),
         .counted_15(counted_15),
         .multiplier(multiplier),
         .multiplicand(multiplicand),
        .counted(counted),
        .get_output(get_output),
        .product(product)
    
);


array_multiplier_controller CT(

         .clk(clk),.reset(reset),
         .start(start),
         .counted(counted),
         .get_output(get_output),
        .start_tx(start_tx),
        .counted_15(counted_15),
        .ready(ready)

    );
    
endmodule