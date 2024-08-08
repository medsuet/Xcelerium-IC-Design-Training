module tb_restoring_division_algorithm (
    `ifdef VERILATOR
        input logic clk
    `endif
);

localparam WIDTH = 16;

logic [WIDTH-1:0] divisor, exp_q;
logic [WIDTH-1:0] dividend, exp_r;
    
`ifndef VERILATOR
    logic clk;
`endif 

logic n_rst;

logic start;
logic ready;

logic [WIDTH-1:0] quotient;
logic [WIDTH-1:0] remainder;

restoring_division_algorithm DUT (
    .divisor(divisor), .dividend(dividend),

    .clk(clk), .n_rst(n_rst),

    .start(start), .ready(ready),

    .quotient(quotient), .remainder(remainder)
);

`ifndef VERILATOR
    initial begin
        clk = 1'b1;
        forever begin
            #20 clk = ~clk;
        end
    end
`endif

initial begin
    init_signals;
    reset_seq;

    $display("\n------ Directed Tests ------\n");
    directed_test (1, 9);
    directed_test (9, 1);
    directed_test (11, 3);
    directed_test (7, 1);
    directed_test (8, 1);
    directed_test (32770, 65234);
    directed_test (9987, 15937);
    directed_test (1, 15);

    $display("\n------ Random Tests ------\n");
    for (int i = 0; i < 10; i++) begin
        directed_test ($random+1, $random);
    end
    $display("\n");
    @(posedge clk);
    //$stop;
    $finish;
end

task directed_test(input logic [WIDTH-1:0] a, b);
    divisor <= a; dividend <= b;
    @(posedge clk);
    start <= 1;
    exp_q = dividend / divisor;
    exp_r = dividend % divisor;
    @(posedge clk);
    start <= 0;
    while (!ready) begin
        @(posedge clk);
    end

    if ((quotient == exp_q) && (remainder == exp_r)) begin
        $display("SUCESSFULLY DIVIDE :) | Divisor = %d, Dividend = %d | Quotient = %d, Remainder = %d", divisor, dividend, quotient, remainder);
    end
    else begin
        $display("CHECK YOUR ALGORITHM :( | Divisor = %d, Dividend = %d", divisor, dividend);
        $display("Quotient  | Expected = %d, Original = %d", exp_q, quotient);
        $display("Remainder | Expected = %d, Original = %d", exp_r, remainder);
    end
endtask

task reset_seq;
    n_rst <= 0;
    @(posedge clk);
    n_rst <= 1;
endtask

task init_signals;
    divisor = 1; dividend = 0;
    start <= 0; n_rst <= 1;
endtask
    
endmodule