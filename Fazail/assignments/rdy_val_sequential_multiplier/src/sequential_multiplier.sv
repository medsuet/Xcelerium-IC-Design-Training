module sequential_multiplier #(
    WIDTH = 16
    )(
        input logic signed [WIDTH-1:0] multiplier,
        input logic signed [WIDTH-1:0] multiplicand,
        //input logic start,

        input logic clk, n_rst,

        input logic src_valid_i, dst_ready_i,

        output logic signed [2*WIDTH-1:0] product,
        //output logic ready
        output logic src_ready_o, dst_valid_o
);

logic en_in, bit_sel, count_15, count_14, count_en, clr;
logic bit_01, count_lb, en_fp;

datapath Datapath (.multiplier(multiplier), .multiplicand(multiplicand),
                   .clk(clk), .n_rst(n_rst),
 
                   // Controller -> Datapath
                   .en_in(en_in), .bit_sel(bit_sel), .en_fp(en_fp),
                   .count_lb(count_lb), .count_en(count_en), .clr(clr), 
                   
                   // Datapath -> Controller
                   .count_14(count_14), .count_15(count_15), .bit_01(bit_01),
                   
                   // output
                   .product(product)
                   );

controller Controller ( .clk(clk), .n_rst(n_rst),
                        .src_valid_i(src_valid_i), .dst_ready_i(dst_ready_i),
                        
                        // Datapath -> Controller 
                        .bit_01(bit_01), .count_15(count_15), .count_14(count_14),
                        
                        // controller -> Datapath
                        .en_in(en_in), .bit_sel(bit_sel), .count_lb(count_lb),
                        .count_en(count_en), .clr(clr), .en_fp(en_fp),
                        
                        // Output 
                        .src_ready_o(src_ready_o), .dst_valid_o(dst_valid_o)
                        );
    
endmodule