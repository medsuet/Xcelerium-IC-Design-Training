/********************************************************************************
  +  Author      : Muhammad Ehsan
  +  Date        : 29-7-2024
  +  Description : Implementation of sequential multiplier using booth algorithm.
                   Also support valid ready (handshake) protocol..
********************************************************************************/

parameter MUL_WIDTH = 16;

module tb;

    logic signed   [(2*MUL_WIDTH)-1:0]   exp_product;
    
//=================== Declearing Input And Outputs For UUT ===================//

    logic                                clk;              
    logic                                rst;             
    logic signed   [MUL_WIDTH-1:0]       multiplicand;    
    logic signed   [MUL_WIDTH-1:0]       multiplier;      
    logic signed   [(2*MUL_WIDTH)-1:0]   product;    
    logic                                src_valid;
    logic                                src_ready;
    logic                                dest_valid;
    logic                                dest_ready;
    
//=========================== Module Instantiation ===========================//

    sequential_multiplier_top #(.MUL_WIDTH(MUL_WIDTH)) uut (
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .clk(clk),
        .rst(rst),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dest_valid(dest_valid),
        .dest_ready(dest_ready),
        .product(product)
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

    task drive_inputs(input logic signed [MUL_WIDTH-1:0] in_1, input logic signed [MUL_WIDTH-1:0] in_2);
        begin
        multiplicand = in_1;
        multiplier = in_2;
        src_valid = 1;
        @(posedge clk);
        src_valid = 0;
        while (dest_valid == 0) begin
            @(posedge clk);
        end 
        dest_ready = 1;
        @(posedge clk);
        dest_ready = 0;
        end

    endtask 

//============================ Monitoring Outputs ============================//

    task monitor_outputs;
        begin
            exp_product = multiplicand * multiplier;
            if(exp_product != product)begin
                $display("Fail");
            end
            else if (exp_product == product)
            begin
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
        fork
            for (int i=0; i<20;i++ ) begin
                drive_inputs($random % (2^MUL_WIDTH),$random % (2^MUL_WIDTH));
                monitor_outputs();    
            end
        join
        $finish;
    end
endmodule

