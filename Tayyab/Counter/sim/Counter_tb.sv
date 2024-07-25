/*
    Name: Counter_tb.sv
    Author: Muhammad Tayyab
    Date: 24-7-2024
    Description: Testbench for Counter.sv
*/

module Counter_tb();

    parameter UBOUND = 14;
    parameter NUMBITS = 4;
    parameter RESETTIME = 25;

    logic clk, reset;
    logic [(NUMBITS-1):0]count;

    Counter #(NUMBITS, UBOUND) UUT(clk, reset, count);

    // Generate clock
    initial begin
        clk = 0;
        forever #15 clk = ~clk;
    end

    // Send signals to the counter
    initial begin
        #RESETTIME;             // wait for RESETTIME
        reset_counter();        // reset counter
    end

    // View value of counter at each posedge of clock
    always @(posedge clk) begin
        $display("Counter value: %d", count);
    end

    // Task to reset the counter
    task reset_counter();
        reset = 1;
        #7;
        reset = 0;
    endtask
    
endmodule
