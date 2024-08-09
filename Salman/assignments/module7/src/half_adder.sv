module half_adder (
	input  logic a,       // Input 'a'
	input  logic b,       // Input 'b'
	output logic s,       // Output 's' (Sum)
	output logic c        // Output 'c' (Carry)
);

// Combinational logic equations for sum and carry
always_comb 
begin
	s = a ^ b;  // XOR operation for sum
	c = a & b;  // AND operation for carry
end

endmodule
