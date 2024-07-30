/*module seq_multiplier_tb();
logic  [15:0] A;
logic  [15:0] B;
logic  START;
logic  RST, CLK;
logic [31:0] PRODUCT;
logic READYO;

seq_multiplier UUT
(
    .A(A),
    .B(B),
    .START(START),
    .RST(RST),
    .CLK(CLK),
    .PRODUCT(PRODUCT),
    .READYO(READYO)
);

initial
begin
    CLK = 0;
    forever #10 CLK = ~CLK;
end

initial
begin
    RST <= 0; START <= 0;
    repeat(2) @(posedge CLK );

    dir_test(0,0);
    dir_test(1,7);
    dir_test(-5,3);
    dir_test(-5,-16);
    dir_test(122,-3);
    dir_test(32767,32767);
    $stop;
end

task dir_test(input logic [15:0] a11,b11);
   RST <= 1; START <= 1; A <= a11; B <= b11;
   @(posedge CLK)
   START <= 0;
   repeat(22) @(posedge CLK);
endtask

endmodule
*/
module seq_multiplier_tb;

// Inputs
logic signed [15:0] A;
logic signed [15:0] B;
logic CLK;
logic RST;
logic START;

//refernce model output
logic signed [31:0] exp;
// Outputs
logic READYO;
logic signed [31:0] PRODUCT;

//number of tests
int n = 1000;
int pass = 0;
int fail = 0;

seq_multiplier uut (
    .A(A),
    .B(B),
    .CLK(CLK),
    .RST(RST),
    .START(START),
    .READYO(READYO),
    .PRODUCT(PRODUCT)
);

// Clock generation
initial begin
    CLK = 1;
    forever #5 CLK = ~CLK; // 10 ns period clock
end


// Stimulus process
initial begin
    // Initialize Inputs
    A <= 0;
    B <= 0;
    RST <= 0;
    START <= 0;
    @(posedge CLK);
    RST <= 1;

    dir_test(0,0);
    dir_test(1,7);
    dir_test(-5,3);
    dir_test(-5,-16);
    dir_test(122,-3);
    dir_test(32767,32767);

    for(int i=0;i<n;i++)begin 
        @(posedge CLK);
        //Random Testing
        drive_inputs($random % 32767,$random % 32767); 
        monitor_outputs();
        @(posedge CLK);
    end
    $display("total test %0d= , pass test= %0d, fail test= %0d",n,pass, fail);
    $finish;
end


//Direct test
task dir_test(input logic [15:0] a_in,b_in);
   RST <= 1; START <= 1; A <= a_in; B <= b_in;
   @(posedge CLK)
   START <= 0;
   repeat(20) @(posedge CLK);
endtask

// Task for driving inputs
task drive_inputs(input logic signed [15:0] in1, input logic signed [15:0] in2);
    begin
        A <= in1;
        B <= in2;
        START <= 1;
        @(posedge CLK);
        START <= 0;
    end
endtask

// Task for monitoring outputs
task monitor_outputs;
    begin
        @(posedge READYO);
        @(posedge CLK);
        exp = A * B;
        if(exp != PRODUCT)begin
            fail = fail+1;
            $display("Fail");
            $display("A = %0d, B = %0d, P = %0d,E= %0d", A, B, PRODUCT,exp);
        end
        else
        begin
            pass = pass+1;
            $display("pass");
        end
    end
endtask

endmodule