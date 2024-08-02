module full_adder (input x, y, cin,
			  output logic s, c
	);
	
	assign s = x^y^cin;
	assign c = (x&y)|(y&cin)|(cin&x);

			  
endmodule

module half_adder (input x, y,
			  output logic s, c
			  );
	assign s = x ^ y;
	assign c = x & y;
endmodule


