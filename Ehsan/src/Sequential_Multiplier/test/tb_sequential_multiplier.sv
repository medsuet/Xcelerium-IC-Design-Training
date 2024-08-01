module tb;
    logic clk, rst, start_bit, ready_bit;
    logic signed [15:0] multiplicand, multiplier;
    logic signed [31:0] product,exp_product;
    int Passed, Failed;      //no. of test pass and fail
    int test_cases = 10000;   //no. of test cases
    sequential_multiplier uut (
        .clk(clk),
        .rst(rst),
        .start_bit(start_bit),
        .ready_bit(ready_bit),
        .multiplicand(multiplicand),
        .multiplier(multiplier),
        .product(product)
    );

    //generating clk
    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    //reset circuit
    task reset_circuit;
        rst = 0;
        #5;
        rst = 1;
    endtask

    //monitor that checks the output of module
    task monitor;
        begin
            exp_product = multiplicand * multiplier;
            wait (ready_bit == 1);
            @(posedge clk);
            //repeat(17)@(posedge clk);
            if(exp_product != product)begin
                Failed++;
                $display("Fail");
                $display("multiplicand = %0d, multiplier = %0d, product = %0d, expected= %0d", multiplicand, multiplier, product,exp_product);
            end
            else
            begin
                Passed++;
                $display("Pass");
                $display("multiplicand = %0d, multiplier = %0d, product = %0d, expected= %0d", multiplicand, multiplier, product,exp_product);
            end
        end
    endtask

    //driver r that apply inputs to module
    task driver  (input logic signed [15:0] in_1, input logic signed [15:0] in_2);
        begin
            multiplicand = in_1;
            multiplier = in_2;
            start_bit = 1;
            @(posedge clk);
            start_bit = 0;
        end
    endtask

    //random testing
    initial begin
        reset_circuit;
        for(int i=0;i<test_cases;i++)begin 
            driver ($random % 65536,$random % 65536); 
            monitor;
        end
        @(posedge clk);
        $display("No. of test = %0d, Passed = %0d, Failed = %0d", test_cases,Passed, Failed);
        $finish;
    end

    //generating waveform
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end
endmodule

