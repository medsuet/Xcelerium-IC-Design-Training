module adder_tb;

logic [15:0]num1;
logic [15:0]num2;
logic carry_in;
logic [15:0]sum;
logic carry_out;

adder uut(.num1(num1), .num2(num2), .carry_in(carry_in), .sum(sum), .carry_out(carry_out));

initial begin
 num1 = 16'd0;
 num2 = 16'd0;
 carry_in = 1'd0;

#10;
 num1 = 16'd1;  num2 = 16'd1; carry_in = 1'd0;
#10;
 num1 = 16'd1;  num2 = 16'd1; carry_in = 1'd0;
#10;
num1 = 16'd3276; num2 = 16'd3276; carry_in = 1'b1;
#10;
num1 = 16'hFFFF; num2 = 16'hEFFF; carry_in = 1'b0;
#10;
$finish;
end

initial begin
 $monitor("At time %0t: num1 = %b, num2 = %b, carry_in = %b -> sum = %b, carry_out = %b",
           $time,num1,num2,carry_in,sum,carry_out);
end
endmodule
