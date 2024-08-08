module restoring_division_tb();
    // Signals
    logic CLK;
    logic RST;
    logic START;
    logic [15:0] A;
    logic [15:0] M;
    logic [15:0] Q;
    logic READY;
    logic [15:0] QUOTIENT;
    logic [15:0] REMAINDER;

    // Instantiate the Unit Under Test (UUT)
    datapath uut(
        .CLK(CLK),
        .RST(RST),
        .START(START),
        .A(A),
        .M(M),
        .Q(Q),
        .READY(READY),
        .QUOTIENT(QUOTIENT),
        .REMAINDER(REMAINDER)
    );

    // Clock Generation
    initial begin
        CLK = 1;
        forever #10 CLK = ~CLK;
    end

    //task Driver
    task drive_input(input logic[15:0] dividend, input logic[15:0] divisor);
        begin

            RST <= #1 0;
            START <= #1 0;
            @(posedge CLK);
            RST <= #1 1;
            START <= #1 1;
            A <= #1 1'b0;
            Q <= #1 dividend;
            M <= #1 divisor;
            @(posedge CLK);
            START <= #1 0;
        end
    endtask

    //task Monitor

    task monitor_output(input logic[15:0] dividend, input logic[15:0] divisor);
        logic [15:0] expected_quotient;
        logic [15:0] expected_remainder;
        begin
            // Calculate expected results
            expected_quotient = dividend / divisor;
            expected_remainder = dividend % divisor;
            // Wait for the READY signal
            repeat(16) @(posedge CLK);
            // Check results
            if(QUOTIENT == expected_quotient && REMAINDER == expected_remainder)
            begin
                $display("Test Passed: QUOTIENT = %0d, REMAINDER = %0d",QUOTIENT,REMAINDER);
            end
            else
            begin
                $display("Test Failed: Expected QUOTIENT = %0d, REMAINDER = %0d; Got QUOTIENT = %0d, REMAINDER = %0d",
                expected_quotient, expected_remainder, QUOTIENT, REMAINDER);
            end
        end
    endtask
    initial 
    begin
        fork
            begin
                // Test case 1
                // dividend = 9, divisor = 4
                drive_input(16'd9, 16'd4);
                monitor_output(16'd9, 16'd4);
                //drive_input();
                //monitor_output();
                // Test case 2
                // dividend = 20, divisor = 3
                drive_input(16'd20, 16'd3);
                monitor_output(16'd20, 16'd3);
                // Test case 3
                // dividend = 100, divisor = 7
                drive_input(16'd100, 16'd7);
                monitor_output(16'd100, 16'd7);
                // Add more test cases as needed
            end
        join
    end
endmodule
  


//module restoring_division_tb();
//    logic CLK;
//    logic RST;
//    logic START;
//    logic [15:0] A;
//    logic [15:0] M;
//    logic [15:0] Q;
//   // logic [3:0] N;
//    logic READY;
//    logic [15:0] QUOTIENT;
//    logic [15:0] REMAINDER;
//
//datapath uut(
//    .CLK(CLK),
//    .RST(RST),
//    .START(START),
//    .A(A),
//    .M(M),
//    .Q(Q),
//    //.N(N),
//    .READY(READY),
//    .QUOTIENT(QUOTIENT),
//    .REMAINDER(REMAINDER)
//);
//
//initial 
//begin
//    CLK = 1;
//    forever #10 CLK = ~CLK;
//end
//
//initial
//begin
//    RST <= #1 0;
//    @(posedge CLK);
//    RST <= #1 1;
//    Q <= #1 9;  // dividend
//    M <= #1 4;   // divisor
//    A <= #1 0;
//    //N <= #1 16;
//    START <= #1 1;
//    @(posedge CLK);
//    START <= #1 0;
//    repeat(16) @(posedge CLK);
//end
//endmodule
//