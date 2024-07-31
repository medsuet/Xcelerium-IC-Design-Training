module sequential_multiplier_tb();
    logic CLK;
    logic RST;
    logic signed [15:0] A;
    logic signed [15:0] B;
    logic START;
    logic READY;
    logic signed [31:0] PRODUCT;

    logic signed[31:0] expected_result;

    int MAX = 500;

sequential_multiplier uut(
    .CLK(CLK),
    .RST(RST),
    .A(A),
    .B(B),
    .START(START),
    .READY(READY),
    .PRODUCT(PRODUCT)
);


    initial begin
        CLK = 1;
        forever #10 CLK = ~CLK;
    end

    task reset();
        begin
            RST <= #1 0;
            @(posedge CLK);
            RST <= #1 1;
        end
    endtask

    task DRIVER(input int MAX);
        int i;
        begin
            for(i = 0;i<MAX;i++)
            begin
            A <= #1 ($random % 65535);
            B <= #1 ($random % 65535);
            START <= #1 1;
            @(posedge CLK);
            START <= #1 0;
            repeat (16) @(posedge CLK);
            end
        end
    endtask

    task MONITOR(input int MAX);
        int j;
        logic signed [15:0] num1;
        logic signed [15:0] num2;
        logic signed [31:0] expected_result;
        begin
            for( j=0;j<MAX ; j++)
            begin
                @(posedge START);
                num1 = A;
                num2 = B;
                @(posedge CLK);
                @(negedge START);
                repeat (16) @(posedge CLK);
                expected_result = num1 * num2;
                if(expected_result == PRODUCT)
                begin
                    $display("Test cases are passesd.");
                    $display("A = %d,B = %d,expected_result = %d, PRODUCT = %d",num1,num2,expected_result,PRODUCT);
                end
                else
                begin
                    $display("Fail");
                end
            end
        end
    endtask

    initial begin
        reset();
        fork
            DRIVER(MAX);
            MONITOR(MAX);
        join
        $display("All tests are passed.");
        $stop;
        $finish;
    end
endmodule




                
                

//
//            wait(READY==1);
//            expected_result = A * B;
//            if(expected_result == PRODUCT)
//            begin
//                $display("Test cases are passed");
//                $display("A = %d,B = %d, PRODUCT = %d",A,B,expected_result);
//            end
//            else
//            begin
//                $display("Fails");
//            end
//        end
//    endtask
//
//    initial begin
//        START = 1;
//        //A = -3;
//        //B = 3;
//        DRIVER_INPUTS(-3,3);
//        @(posedge CLK);
//        START = 0;
//        for( i=0 ; i<200 ; (i = i+1))
//        begin
//            DRIVER_INPUTS(3+i,11+i);
//            MONITOR_OUTPUTS();
//            @(posedge CLK);
//        end
//    end
//endmodule
//
//
//