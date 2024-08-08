module sequential_multiplier (
        input logic signed [WIDTH-1:0] multiplier,
        input logic signed [WIDTH-1:0] multiplicand,
        input logic start,

        input logic clk, n_rst,

        output logic signed [2*WIDTH-1:0] product,
        output logic ready
);

localparam WIDTH = 16;

logic en_in, bit_sel, count_15, count_14, count_en, clr;
logic bit_01, count_lb;

datapath Datapath (.multiplier(multiplier), .multiplicand(multiplicand),
                   .clk(clk), .n_rst(n_rst),
 
                   // Controller -> Datapath
                   .en_in(en_in), .bit_sel(bit_sel),
                   .count_lb(count_lb), .count_en(count_en), .clr(clr), 
                   
                   // Datapath -> Controller
                   .count_14(count_14), .count_15(count_15), .bit_01(bit_01),
                   
                   // output
                   .product(product)
                   );

controller Controller ( .clk(clk), .n_rst(n_rst),
                        .start(start),
                        
                        // Datapath -> Controller 
                        .bit_01(bit_01), .count_15(count_15), .count_14(count_14),
                        
                        // controller -> Datapath
                        .en_in(en_in), .bit_sel(bit_sel), .count_lb(count_lb),
                        .count_en(count_en), .clr(clr),
                        
                        // Output 
                        .ready(ready)
                        );
    
endmodule