
module Seq_Div_top_tb;

    // Inputs
    logic signed [15:0] divident;
    logic signed [15:0] divisor;
    logic clk;
    logic rst;
    logic start;

    //refernce model output
    logic signed [15:0] exp_remain;
    logic signed [15:0] exp_quot;

    // Outputs
    logic ready;
    logic signed [15:0] remainder;
    logic signed [15:0] quotient;


    // Instantiate the Unit Under Test (UUT)
    Top uut(.clk(clk),
            .rst(rst),
            .divident(divident),
            .divisor(divisor),
            .ready(ready),
            .remainder(remainder),
            .quotient(quotient),
            .start(start));

    // Clock generation
    initial begin
        clk = 1;
        forever #5 clk = ~clk; 
    end

    // Dump file for waveform
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0, Seq_Div_top_tb);
    end
    // Task for reset sequence
    task reset_sequence;
        begin
            divident = 0;
            divisor = 0;
            rst = 0;
            start = 0;
            exp_quot = 0;
            exp_remain = 0;
            repeat(3)@(posedge clk);
            start = 0;
            @(posedge clk);
            rst = 1;
        end
    endtask

    // Task for driving inputs
    task drive_inputs(input logic signed [15:0] in1, input logic signed [15:0] in2);
        begin
            divident = in1;
            divisor = in2;
            start = 1;
            @(posedge clk);
            start = 0;
            while(! ready) @(posedge clk);
        end
    endtask

    // Task for monitoring outputs
    task monitor_outputs;
        begin
            @(posedge ready); 
            exp_remain = divident % divisor;
            exp_quot = divident / divisor;
            if((exp_remain == remainder) && (exp_quot == quotient))
            begin
                $display("pass");
              // $display("A = %0h, B = %0h, Rem = %0h,exp_remain= %0h,quot=%0h,exp_quot", divident, divisor,remainder,exp_remain,quotient,exp_quot);
            end
            else
            begin
                $display("fail");
             $display("A = %0h, B = %0h, Rem = %0h,exp_remain= %0h,quot=%0h,exp_quot", divident, divisor,remainder,exp_remain,quotient,exp_quot);
            end
        end
    endtask

    // Stimulus process
    initial begin
        reset_sequence(); 
          
         

        // for random testing
        for(int i=0;i<3000;i++)
        begin 
            fork
            drive_inputs(10+i,1+i); 
            monitor_outputs();
            join
        end
      //  fork
       //     drive_inputs(256,24600); 
       //     monitor_outputs();
       // join
        $finish;
    end
endmodule