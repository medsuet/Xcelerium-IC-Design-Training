module top_multiplier (
    input  logic         clk,   
    input  logic         rst,   
    input  logic         start, 
    input  logic [15:0]  A,
    input  logic [15:0]  B,
    output logic [31:0]  product, 
    output logic         done 
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
        .clk        (   clk    ),
        .rst        (   rst    ),
        .start      (   start  ),
        .done       (   dp_done),
        .load       (   load   ),
        .calc       (   calc   )
    );

    assign done = dp_done;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, top_multiplier);
    end

endmodule