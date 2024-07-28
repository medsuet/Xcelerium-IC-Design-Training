module sequential_binaryadder_tb();
    logic CLK;
    logic RST;
    logic NUMBER;
    logic OUTPUT;

    sequential_binaryadder uut(
        .CLK(CLK),
        .RST(RST),
        .NUMBER(NUMBER),
        .OUTPUT(OUTPUT)
    );

    //generation of clk
    initial begin
        CLK = 1;
        forever #10 CLK = ~CLK;   //20ns cock period
    end

    initial begin
        RST <= #1 0;
        repeat(2) @(posedge CLK);      // Wait for two clock cycles
        RST <= #1 1;


        //@(posedge CLK);
        // verify for 5
        NUMBER <= #1 1;
        @(posedge CLK);
        NUMBER <= #1 0;
        @(posedge CLK);
        NUMBER <= #1 1;
        @(posedge CLK);
        NUMBER <= #1 0;
        repeat(3)@(posedge CLK);//repeat for three clock  cycles

        //test case 2
        //@(posedge CLK);
        // verify for 8
        NUMBER <= #1 0;
        @(posedge CLK);
        NUMBER <= #1 0;
        @(posedge CLK);
        NUMBER <= #1 0;
        @(posedge CLK);
        NUMBER <= #1 1;
        repeat(3)@(posedge CLK);
        $stop;
        $finish;
    end
endmodule





    
