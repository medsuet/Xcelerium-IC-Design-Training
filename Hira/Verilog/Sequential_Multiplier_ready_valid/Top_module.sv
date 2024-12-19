module top_multiplier (
    input  logic         clk,   
    input  logic         rst,   
    input  logic         Src_valid,                                   //this was initialy start
    input  logic         dd_ready,                                   //newly added
    input  logic [15:0]  A,
    input  logic [15:0]  B,
    output logic [31:0]  product, 
    output logic         Src_ready,                             //new added signals
    output logic         dd_valid                              //new added signal
    //output logic done 
);

    wire load, calc;
    wire dp_done;

    datapath dp (
        .clk    (  clk      ),
        .rst    (  rst      ),
        .load   (  load     ),
        .calc   (  calc     ),
        .A      (  A        ),
        .B      (  B        ),
        .product(  product  ),
        .done   (  dp_done  )
    );

    control_unit cu (
        .clk        (  clk       ),
        .rst        (  rst       ),
        .Src_valid  (  Src_valid ),
        .dd_ready   (  dd_ready  ),
        .done       (  dp_done   ),
        .load       (  load      ),
        .Src_ready  (  Src_ready ),
        .dd_valid   (  dd_valid  ),
        .calc       (  calc      )
    );

    //assign done = dp_done;

endmodule