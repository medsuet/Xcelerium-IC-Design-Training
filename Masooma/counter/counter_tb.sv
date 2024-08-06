//==============Author: Masooma Zia==============
//==============Date: 25-07-2024==============
//==============Description:Test Bench for 4-bit counter with clear bit activated on 13==============
module counter_tb;
logic clk=0;
logic reset;
logic [3:0] q;

counter UUT(
    .clk(clk),
    .reset(reset),
    .q(q)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("counter.vcd");
    $dumpvars(0,counter_tb);
    reset=0;
#10;
    reset=1;
repeat (40) @(posedge clk);
$finish;
end
endmodule

