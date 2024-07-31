module counter_tb();
logic clk;
logic rst;
logic [3: 0] C_out;

counter UUT (.clk(clk), .rst(rst), .C_out(C_out));

initial
begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial
begin
    rst = 1;
    @(posedge clk);
    rst = 0;
    repeat(17) @(posedge clk);
    $stop;
end


endmodule