module sequential_adder_tb();

    logic [3:0] a;
    logic l, m;
    logic clk;
    logic reset;
    logic y;

    sequential_adder dut(
        .l(l),
        .m(m),
        .clk(clk),
        .reset(reset),
        .y(y)
    );

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("sequential_adder_tb.vcd");
        $dumpvars(0, sequential_adder_tb);
        reset = 1; 
        @(posedge clk) reset = 0;
        test_values(3);
        test_values(7);
        test_values(15);
        $finish;
    end

    task test_values(input logic [3:0] a);
        m = #1 a[0]; l = 1'b1;
        @(posedge clk);
        m = #1 a[1]; l = 1'b0;
        @(posedge clk);
        m = #1 a[2]; l = 1'b0;
        @(posedge clk);
        m = #1 a[3]; l = 1'b0;
        @(posedge clk);
    endtask
  
endmodule
