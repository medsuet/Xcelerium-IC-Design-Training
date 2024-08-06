module counter_tb();

    parameter WIDTH = 4;
    logic clk, reset, clear;
    logic [WIDTH-1:0] D_out; 
    logic [WIDTH-1:0] mux_out;
    logic [WIDTH-1:0] Q;   

    counter dut(
        .clk(clk),
        .reset(reset),
        .clear(clear),
        .D_out(D_out),
        .mux_out(mux_out),
        .Q(Q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("counter_tb.vcd");
        $dumpvars(0, counter_tb);
        reset = 1;
        @(posedge clk) reset = 0;
        repeat(20) @(posedge clk); 
        $finish;
    end

endmodule
