/*********************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 27-7-2024
  +  Description : Implementation of sequential multiplier using booth algorithm.
*********************************************************************************/

parameter MUL_WIDTH = 16;

module tb;

    int Passed;                                         //No. of tests passes
    int Failed;                                         //No. of tests fails
    int test_cases = 1000;                             //No. of tests
    logic signed   [(2*MUL_WIDTH)-1:0]   exp_product;   //Expected Product

//=================== Declearing Input And Outputs For UUT ===================//

    logic                                clk;
    logic                                rst;
    logic signed   [MUL_WIDTH-1:0]       multiplicand;
    logic signed   [MUL_WIDTH-1:0]       multiplier;
    logic signed   [(2*MUL_WIDTH)-1:0]   product;
    logic                                start_bit;
    logic                                ready_bit;

//=========================== Module Instantiation ===========================//

    sequential_multiplier #(.MUL_WIDTH(MUL_WIDTH)) uut (
        .clk(clk),
        .rst(rst),
        .start_bit(start_bit),
        .ready_bit(ready_bit),
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );
//============================= Clock Generation =============================//

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

//=============================== RESET Circuit ==============================//

    task reset_circuit;
        rst = 0;
        #5;
        rst = 1;
    endtask

//============================== Driving Inputs ==============================//

    task drive_inputs (input logic signed [MUL_WIDTH-1:0] in_1, input logic signed [MUL_WIDTH-1:0] in_2);
        begin
            multiplicand = in_1;
            multiplier = in_2;
            start_bit = 1;
            @(posedge clk);
            start_bit = 0;
        end
    endtask

//============================ Monitoring Outputs ============================//

    task monitor_outputs;
        begin
            exp_product = multiplicand * multiplier;
            while (ready_bit == 0) begin
                @(posedge clk);            
            end;
            if(exp_product != product)begin
                Failed++;
                $display("Fail");
                $display("multiplicand = %0d, multiplier = %0d, product = %0d, expected= %0d", multiplicand, multiplier, product,exp_product);
            end
            else
            begin
                Passed++;
                $display("Pass");
            end
        end
    endtask

//================================== Testing =================================//

    initial begin
        reset_circuit;

        // Direct Test
        drive_inputs ($random % ((2^MUL_WIDTH)-1),$random % ((2^MUL_WIDTH)-1)); 
        monitor_outputs;

        //Random Testing
        for(int i=0;i<test_cases-1;i++) begin 
            drive_inputs ($random % ((2^MUL_WIDTH)-1),$random % ((2^MUL_WIDTH)-1)); 
            monitor_outputs;
        end

        @(posedge clk);
        $display("No. of test = %0d, Passed = %0d, Failed = %0d", test_cases,Passed, Failed);
        $finish;
    end

//=========================== Generating Waveform ============================//

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end

endmodule

