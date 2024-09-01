module seq_adder_inverter_logic_tb();

    parameter WIDTH = 8;
    logic [WIDTH-1:0] a;
    logic bit_in; 
    logic clk;
    logic reset;
    logic bit_out;

    seq_adder_inverter_logic dut(
        .clk(clk),
        .reset(reset),
        .bit_in(bit_in),
        .bit_out(bit_out)
    );

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("seq_adder_inverter_logic_tb.vcd");
        $dumpvars(0, seq_adder_inverter_logic_tb);
        reset = 1; 
        @(posedge clk) reset = 0;
        test_values(8);
        test_values(3);
        test_values(7);
        test_values(15);
        $finish;
    end

    task test_values(input logic [WIDTH-1:0] a);
        bit_in = #1 a[0]; 
        @(posedge clk);
        bit_in = #1 a[1]; 
        @(posedge clk);
        bit_in = #1 a[2]; 
        @(posedge clk);
        bit_in = #1 a[3]; 
        @(posedge clk);
        bit_in = #1 a[4]; 
        @(posedge clk);
        bit_in = #1 a[5]; 
        @(posedge clk);
        bit_in = #1 a[6]; 
        @(posedge clk);
        bit_in = #1 a[7]; 
        @(posedge clk);
    endtask
  
endmodule
