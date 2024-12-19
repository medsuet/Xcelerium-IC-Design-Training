module tb_SL;
logic clk;
logic [31:0]A,Q,AM,QM;

SL dut(.clk(clk), .A(A), .Q(Q), .AM(AM), .QM(QM));

initial begin 
    clk = 0;
    forever #5 clk = ~clk;
   end

initial 
begin
@(posedge clk);
A= 32'd0; Q = 32'd40;
@(posedge clk);
A = 32'd3; Q = 32'd20;
 
end

initial
begin
$monitor("A = %d, Q = %d, AM = %d, QM = %d", A,Q,AM,QM);
end
endmodule