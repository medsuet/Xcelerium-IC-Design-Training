module full_adder (
	input  logic a,        // Input 'a'
	input  logic b,        // Input 'b'
	input  logic c_in,     // Input 'carry_in'
	output logic s,        // Output 's' (Sum)
	output logic c_out     // Output 'c_out' (Carry)
);

// Combinational logic equations for sum and carry
always_comb
begin
	{c_out, s} = a + b + c_in;
end

endmodule