`include "../define/array_mul.svh"

module array_multiplier (
    input logic     clk,reset,
    input logic     [width-1:0]multiplicand,multiplier,
    input logic     valid_src,dst_ready,
    output logic    [result_width-1:0]product,
    output logic    src_ready,dst_valid

);

logic start_tx,counted_15,counted,get_output;


array_multiplier_datapath  DP(

         .clk(clk),.reset(reset),
         .start_tx(start_tx),
         .counted_15(counted_15),
         .dst_ready(dst_ready),
         .multiplier(multiplier),
         .multiplicand(multiplicand),
        .counted(counted),
        .get_output(get_output),
        .product(product)
    
);


array_multiplier_controller_valready CT(

        .clk(clk),.reset(reset),
        .valid_src(valid_src),
        .counted(counted),
        .get_output(get_output),
        .dst_ready(dst_ready),
        .start_tx(start_tx),
        .counted_15(counted_15),
        .src_ready(src_ready),
        .dst_valid(dst_valid)

    );
    
endmodule