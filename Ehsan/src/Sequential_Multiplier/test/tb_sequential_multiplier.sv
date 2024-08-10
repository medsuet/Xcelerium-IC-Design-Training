/*********************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 27-7-2024
  +  Description : Implementation of sequential multiplier using booth algorithm.
*********************************************************************************/

parameter MUL_WIDTH = 4;

module tb;

    int Pass;                                           //No. of tests passes
    int Fail;                                           //No. of tests fails
    int test_cases = 1000;                              //No. of tests
    logic signed   [(2*MUL_WIDTH)-1:0]   exp_product;   //Expected Product

//=================== Declearing Input And Outputs For UUT ===================//

    logic                                  clk;
    logic                                  rst;
    logic   signed   [MUL_WIDTH-1:0]       multiplicand;
    logic   signed   [MUL_WIDTH-1:0]       multiplier;
    logic   signed   [(2*MUL_WIDTH)-1:0]   product;
    logic                                  start_bit;
    logic                                  ready_bit;

//=========================== Module Instantiation ===========================//

    sequential_multiplier uut (
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
        #45;
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
            while (!ready_bit) begin
                @(posedge clk);
            end
        end
    endtask

//============================ Monitoring Outputs ============================//

    task monitor_outputs;
        begin
            while (!ready_bit) begin
                @(posedge clk);            
            end
            exp_product = multiplicand * multiplier;
            
            if(exp_product != product)begin
                Fail++;
                $display("Fail");
                $display("multiplicand = %0d, multiplier = %0d, product = %0d, expected= %0d", multiplicand, multiplier, product,exp_product);
            end 
            else begin
                Pass++;
                $display("Pass");
            end
        end
    endtask

//================================== Testing =================================//

    initial begin
        reset_circuit;

        // Direct Test
        fork
            drive_inputs (1,1); 
            monitor_outputs;        
        join

        //Random Testing
        for(int i=0;i<test_cases-1;i++) begin 
            fork
                drive_inputs ($random % ((2^MUL_WIDTH)-1),$random % ((2^MUL_WIDTH)-1)); 
                monitor_outputs;            
            join
        end

        // Showing No. Of Tests Pass And Fail 
        $display("No. of test = %0d, Pass = %0d, Fail = %0d", test_cases,Pass, Fail);
        $finish;
    end

//=========================== Generating Waveform ============================//

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end

endmodule

