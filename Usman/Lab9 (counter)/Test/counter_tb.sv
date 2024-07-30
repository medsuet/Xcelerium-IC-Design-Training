module couter_tb;

logic clk, reset;
logic [3:0]out;

initial begin
clk<=0;
forever #10 clk <= ~clk;
end

counter uut(.clk(clk), .reset(reset), .out(out));
initial begin
rst();
end

task rst();
reset<=1;
#5 reset<=0;
endtask
initial begin
$monitor("reset = %b, out = %b",reset,out);
end
endmodule
