/*******************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 01-08-2024
  +  Description : Implementation of restoring division algorithm, utilizing 
                   valid-ready (handshake) protocol.
*******************************************************************************/

parameter WIDTH = 16;

module tb;

    int Pass;                              //No. of tests passes
    int Fail;                              //No. of tests fails
    int test_cases = 1000;                 //No. of tests
    
    logic    [WIDTH-1:0]    exp_remainder;
    logic    [WIDTH-1:0]    exp_quotient;

//=================== Declearing Input And Outputs For UUT ===================//

    logic                   clk;
    logic                   rst;
    logic    [WIDTH-1:0]    dividend;
    logic    [WIDTH-1:0]    divisor;
    logic    [WIDTH-1:0]    remainder;
    logic    [WIDTH-1:0]    quotient;
    logic                   src_valid;
    logic                   src_ready;
    logic                   dest_valid;
    logic                   dest_ready;

//=========================== Module Instantiation ===========================//

    restoring_division_top #(.WIDTH(WIDTH)) uut (
        .clk(clk),
        .rst(rst),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_valid(dest_valid),
        .dest_ready(dest_ready),
        .divisor(divisor),
        .dividend(dividend),
        .remainder(remainder),
        .quotient(quotient)
    );

//============================= Clock Generation =============================//

    initial begin
        clk = 1;
        forever #5 clk = ~clk; 
    end

//=========================== Generating Waveform ============================//

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end

//============================== Driving Inputs ==============================//

    task drive_inputs(input logic signed [WIDTH-1:0] input_1, input logic signed [WIDTH-1:0] input_2);
        begin
        dividend = input_1;
        divisor = input_2;
        src_valid = 1;
        @(posedge clk);
        src_valid = 0;
        while (dest_valid == 0) begin
            @(posedge clk);
        end 
        dest_ready = 1;
        @(posedge clk);
        dest_ready = 0;
        @(posedge clk);
        end

    endtask 

//============================ Monitoring Outputs ============================//

    task monitor_outputs;
        begin
            while (!dest_valid) begin
                @(posedge clk);
            end
            exp_remainder = int'(dividend % divisor);
            exp_quotient = int'(dividend / divisor);

            if(exp_remainder != remainder && exp_quotient != quotient)begin
                Fail++;
                $display("Fail");
            end
            else if (exp_remainder == remainder && exp_quotient == quotient)begin
                Pass++;
                $display("Pass");
            end
        end
    endtask

//=============================== RESET Circuit ==============================//

    task reset_circuit;
        rst = 0;
        #5;
        rst = 1;
    endtask

//================================== Testing =================================//

    initial begin

        reset_circuit;
        dest_ready = 0;

        // Direct Testing 
        fork
            drive_inputs(1,1);
            monitor_outputs();    
        join

        // Random Testing 
        for (int i=1; i<test_cases;i++ ) begin
            fork
                drive_inputs($random ,$random);
                monitor_outputs();    
            join
        end

        // Showing No. Of Tests Pass And Fail 
        $display("No. of test = %0d, Passed = %0d, Failed = %0d", test_cases, Pass, Fail);
        $finish;
    end
endmodule

