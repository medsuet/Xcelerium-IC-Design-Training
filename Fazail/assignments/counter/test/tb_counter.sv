localparam WIDTH = 4;

module tb_counter (
    `ifdef VERILATOR
        input logic clk
    `endif
);
    `ifndef VERILATOR
        logic clk;
    `endif

    logic n_rst;
    
    logic clr;
    logic [WIDTH-1:0]value;
    logic [WIDTH-1:0]mux_out;

    // instantiate counter module
    counter UUT (
        .clk(clk),
        .n_rst(n_rst),

        .value(value),
        .clr(clr),
        .mux_out(mux_out)
    );
    
    `ifndef VERILATOR
        initial begin
            clk = 1;
            forever #20  clk = ~clk;
        end
    `endif
    
    initial begin
        n_rst = 0;      // active low reset

        @(posedge clk);
        n_rst = 1;

        repeat(50) @(posedge clk);

        @(posedge clk);
        $finish; 
    end

    initial begin
        $monitor("|| value = %0h | clear = %0h | mux_out = %0h ||", value, clr, mux_out);
    end

endmodule