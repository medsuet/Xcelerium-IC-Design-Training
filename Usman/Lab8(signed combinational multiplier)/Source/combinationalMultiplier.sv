module combinationalMultiplier(input logic [15:0]a,[15:0]b, output logic [31:0]product);
[15:0]intrm[0:15];
logic line[0:15];
[15:0]carry;
always_comb begin
intrm[0]  = a&b[0];
s[0] = intrm[0][0];

line[0] = b0&a[15];
line[1] = line[0]&a[15];

intrm[1] = a&b[1];
adder(intrm[1:15] & intrm[1][0:14],0,carry[0],intrm[2]);
end
