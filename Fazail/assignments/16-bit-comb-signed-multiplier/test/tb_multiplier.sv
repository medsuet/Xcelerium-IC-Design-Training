localparam WIDTH = 16;

module tb_multiplier ();

// Inputs
logic [WIDTH-1:0] multiplier, multiplicand;

// Outputs
logic [2*WIDTH-1:0] product;

//  Instantiate the Multiplier  
multiplier UUT (
    .a(multiplicand),
    .b(multiplier),
    .product(product)
    ); 

logic signed [WIDTH-1:0]a,b;

initial begin
    init_signals;

    repeat(10) begin 
        #5 multiplier = $random; multiplicand = $random; 
        #1 a = multiplier; b = multiplicand; 
        if (mul_ref(a, b) == (product))
            begin
                //$display( "\nHexadecimal Values----> multiplicand = %h; multiplier = %h; product = %h ", multiplicand, multiplier, $signed(mul_ref(a,b)));
            	$display ("---> SUCCESSFULLY MULTIPLIED <---\n");
            end 
        else
            $display("Error for input a=%d, b=%d, expected=%h, product=%h\n", a, b, mul_ref(a,b), product);
    end
    #10
    $finish;
end

// initialize the signals
task init_signals;
    begin
        multiplier = 0; multiplicand = 0;
        a = multiplier; b = multiplicand;
    end
endtask

// Reference function
function [2*WIDTH-1:0]mul_ref(input logic [WIDTH-1:0]in_a, in_b);
    begin
        mul_ref = ($signed(in_a) * $signed(in_b));
    end 
endfunction

endmodule