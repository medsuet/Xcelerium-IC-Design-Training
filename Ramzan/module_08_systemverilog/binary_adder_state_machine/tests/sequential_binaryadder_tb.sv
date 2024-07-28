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

    task reset;
        begin
            RST <= #1 0;
            repeat(2)@(posedge CLK);
            RST <= #1 1;
        end
    endtask

    task binary_number(input logic [3:0] num);
        integer i;
        begin
            for (i=0 ; i<=3 ; i = i+1) 
            begin
                NUMBER <= #1 num[i];
                @(posedge CLK);
            end
            repeat(3)@(posedge CLK);       // Wait for three clock cycles after applying the number
        end
    endtask

    initial begin
        reset();                           // Apply reset
        binary_number(4'b1010);               // Test case 1: Verify for 5 (0101 in binary) 
        reset();  
        binary_number(4'b1000);               // Test case 2: Verify for 8 (1000 in binary)
        $stop;
        $finish;
    end
endmodule

