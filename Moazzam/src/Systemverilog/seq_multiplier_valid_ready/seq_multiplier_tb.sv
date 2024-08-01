module seq_multiplier_tb;

// Inputs
logic clk;
logic rst;
logic valid_in;
logic ready_in;
logic signed [15:0] multiplier;
logic signed [15:0] multiplicant;

// Outputs
logic valid_out;
logic ready_out;
logic signed [31:0] product;

//refernce model output
logic signed [31:0] exp;

//number of tests
int n = 10000;
int pass = 0;
int fail = 0;

seq_multiplier uut (
    .clk(clk),
    .rst(rst),    
    .multiplier(multiplier),
    .multiplicant(multiplicant),
    .valid_in(valid_in),
    .ready_in(ready_in),

    .product(product),
    .valid_out(valid_out),
    .ready_out(ready_out)
);

// Clock generation
initial begin
    clk = 1;
    forever #5 clk = ~clk; // 10 ns period clock
end


// Stimulus process
initial begin
    // Initialize Inputs
    multiplier <= 0;
    multiplicant <= 0;
    rst <= 0;
    valid_in <= 0; ready_out <= 0;
    @(posedge clk);
    rst <= 1;
    repeat(4) @(posedge clk);

    //dir_test(0,0);
    dir_test(4,7);
    dir_test_2(-5,3);
    dir_test_3(-5,-16);
    dir_test(122,-3);
    dir_test(32767,32767);
/*
    for(int i=0;i<n;i++)begin 
        @(posedge clk);
        //Random Testing
        drive_inputs($random % 32767,$random % 32767); 
        monitor_outputs();
        @(posedge clk);
    end
    $display("total test %0d= , pass test= %0d, fail test= %0d",n,pass, fail);
    $finish;
    */
    $stop;
end


//Direct test
task dir_test(input logic [15:0] a_in,b_in);
    rst <= 1; valid_in <= 1; multiplier <= a_in; multiplicant <= b_in;
    @(negedge ready_in);
    valid_in <= 0;
    @(posedge valid_out);
    repeat(2) @(posedge clk);
    if(ready_out == 0)   ready_out <= 1;
    @(posedge clk);
    ready_out <= 0;
    @(posedge clk);

endtask

//Direct test
task dir_test_2(input logic [15:0] a_in,b_in);
    repeat(3) @(posedge clk);
    rst <= 1; valid_in <= 1; multiplier <= a_in; multiplicant <= b_in;
    @(negedge ready_in);
    valid_in <= 0;
    repeat(3) @(posedge clk);
    valid_in <= 1;  multiplier <= b_in; multiplicant <= a_in;
    @(posedge valid_out);
    repeat(2) @(posedge clk);
    if(ready_out == 0)   ready_out <= 1;
    @(posedge clk);
    ready_out <= 0;
    @(negedge ready_in);
    valid_in <= 0;
    @(posedge valid_out);
    if(ready_out == 0)   ready_out <= 1;
    @(posedge clk);
    ready_out <= 0;

endtask

task dir_test_3(input logic [15:0] a_in,b_in);
    rst <= 1; valid_in <= 1; multiplier <= a_in; multiplicant <= b_in;
    @(negedge ready_in);
    valid_in <= 0;
    repeat(2) @(posedge clk);
    ready_out <= 1;
    @(posedge valid_out);
    if(ready_out == 0)   ready_out <= 1;
    @(posedge clk);
    ready_out <= 0;
    @(posedge clk);

endtask
/*
// Task for driving inputs
task drive_inputs(input logic signed [15:0] in1, input logic signed [15:0] in2);
    begin
        multiplier <= in1;
        multiplicant <= in2;
        valid_in <= 1;
        @(posedge clk);
        valid_in <= 0;
    end
endtask

// Task for monitoring outputs
task monitor_outputs;
    begin
        @(posedge valid_out);
        @(posedge clk);
        exp = multiplier * multiplicant;
        if(exp != product)begin
            fail = fail+1;
            $display("Fail");
            $display("multiplier = %0d, multiplicant = %0d, P = %0d,E= %0d", multiplier, multiplicant, product,exp);
        end
        else
        begin
            pass = pass+1;
            $display("pass");
        end
    end
endtask
*/
endmodule