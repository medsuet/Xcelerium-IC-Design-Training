module adder(input logic [15:0]num1,num2, input logic carry_in, 
               output logic carry_out,output logic [15:0]sum );
logic [16:0]full_add;
always_comb begin
full_add = num1 + num2 + carry_in;
sum = full_add[15:0];
carry_out =full_add[16];
end
endmodule
