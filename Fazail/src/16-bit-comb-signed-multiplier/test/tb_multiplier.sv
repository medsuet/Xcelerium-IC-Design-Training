module tb_multiplier ();
logic [3:0] multiplier, multiplicand;
logic [7:0] product;
//logic [4-1 : 0] pp [4-1 : 0];

multiplier UUT (
    .a(multiplicand),
    .b(multiplier),

    .product(product)
    //.pp(pp)
); 

initial begin
    multiplier = 0; multiplicand = 0;

    #200 multiplier = -1; multiplicand = 10; 
    //$finish;
end
    
initial begin
    $monitor("Time=%0t: A=%b B=%b | Product=%b ", $time, multiplicand, multiplier, product/*, pp*/);

end
endmodule