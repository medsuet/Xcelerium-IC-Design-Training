module top_multiplier (
    input      logic            clk,   
    input      logic            rst,   
    input      logic            start,                      //input ready
    input      logic            in_valid,                   //input valid
    input      logic    [15:0]  A,
    input      logic    [15:0]  B,
    output     logic    [31:0]  product,
    output     logic            output_valid,               //This was done before, our output is ready nows
    output     logic            output_ready                 
);

    wire load, calc;
    wire dp_done;

    datapath dp (
        .clk(clk),
        .rst(rst),
        .load(load),
        .calc(calc),
        .A(A),
        .B(B),
        .product(product),
        .done(dp_done)
    );

    control_unit cu (
        .clk(clk),
        .rst(rst),
        .start(start),
        .in_valid(in_valid),                                    //new signal added
        .done(dp_done),
        .load(load),
        .processing(output_ready),                              //new signal added
        .calc(calc)
    );

    assign output_valid = dp_done;

endmodule