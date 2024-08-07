module restoring_division_tb;

parameter BITS = 16;

// Inputs
logic unsigned [BITS-1:0] dividend;
logic unsigned [BITS-1:0] divisor;
logic clk;
logic rst;
logic valid_src;

//refernce model output
logic unsigned [BITS-1:0] exp_q;
logic unsigned [BITS-1:0] exp_r;
// Outputs
logic valid_des;
logic unsigned [BITS-1:0] quotient;
logic unsigned [BITS-1:0] reminder;

//number of tests
//logic unsigned [BITS-1:0] random_number_1;
//logic unsigned [BITS-1:0] random_number_2;

int n = 20000;
int pass = 0;
int fail = 0;
int math_error = 0;

restoring_division uut (
    .dividend(dividend),
    .divisor(divisor),
    .clk(clk),
    .rst(rst),
    .valid_src(valid_src),
    .valid_des(valid_des),
    .quotient(quotient),
    .reminder(reminder)
);

// Clock generation
initial begin
    clk = 1;
    forever #5 clk = ~clk; // 10 ns period clock
end


// Stimulus process
initial begin
    // Initialize Inputs
    dividend <= 0;
    divisor <= 0;
    rst <= 0;
    valid_src <= 0;
    repeat(2)@(posedge clk);
    rst <= 1;

    //dir_test(0,0);
    dir_test(11,11);
    dir_test(1,4);
    dir_test(15,7);
    dir_test(10,8);

    for(int i=0;i<n;i++)begin 
        @(posedge clk);
        //Random Testing
        drive_inputs($random ,$random); 
        monitor_outputs();
        @(posedge clk);
    end
    $display("total test %0d= , pass test= %0d, fail test= %0d, Maths error = %0d",n,pass, fail,math_error);
    //$finish;
    $stop;
end


//Direct test
task dir_test(input logic [BITS-1:0] a_in,b_in);
   rst <= 1; valid_src <= 1; dividend <= a_in; divisor <= b_in;
   @(posedge clk)
   valid_src <= 0;
   repeat(17) @(posedge clk);
endtask


// Task for driving inputs
task drive_inputs(input logic unsigned [BITS-1:0] in1, input logic unsigned [BITS-1:0] in2);
    begin
        dividend <= in1;
        divisor <= in2;
        valid_src <= 1;
        @(posedge clk);
        valid_src <= 0;
    end
endtask

// Task for monitoring outputs
task monitor_outputs;
    begin
        @(posedge valid_des);
        exp_q = dividend / divisor;
        exp_r = dividend % divisor;
        @(posedge clk);
        if(divisor == 0)
        begin
            math_error =math_error +1;
            $display("Maths error! no number divided by ZERO");
        end
        else if((exp_q != quotient) && (exp_r != reminder))
        begin
            fail = fail+1;
            $display("Fail");
            $display("dividend = %0d, divisor = %0d, Q = %0d,R= %0d, Q_e = %0d,R_e = %0d", dividend, divisor, quotient, reminder,exp_q,exp_r);
        end
        else
        begin
            pass = pass+1;
            $display("pass");
            $display("dividend = %0d, divisor = %0d, Q = %0d,R= %0d, Q_e = %0d,R_e = %0d", dividend, divisor, quotient, reminder,exp_q,exp_r);
        end
    end
endtask

endmodule