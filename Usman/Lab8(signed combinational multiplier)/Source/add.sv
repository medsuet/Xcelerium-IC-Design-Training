module add (
  input  logic a, b, cIn,
  output logic cOut, sum
);
  assign sum = a ^ b ^ cIn;
  assign cOut = (a & b) | (a & cIn) | (b & cIn);
endmodule
