module sequential_multiplier (
    input logic signed [15:0] multiplicand,multiplier,
    input logic clk,reset,start,
    output logic ready,
    output logic [31:0] product
);



logic selectMultiplier; // 2x1_mux for multiplier selector (initialized or updated)
logic enable; // 1 bit for clearing 
logic count16; // check the counter reach its limit 16 or not
logic [1:0] operation;       // 2 bits for Qnext and Qnext+1 (00-->notthing,01--->add,10--->sub,11--->nothing)
logic [1:0] selectAccumulator; // 4x1_mux for data selection 


datapath datapath_design (.multiplicand(multiplicand),
                          .multiplier(multiplier),
                          .clk(clk),
                          .reset(reset),
                          .enable(enable),
                          .count16(count16),
                          .selectAccumulator(selectAccumulator),
                          .selectMultiplier(selectMultiplier),
                          .operation(operation),
                          .product(product));

controller controller_design (.clk(clk),
                           .reset(reset),
                           .ready(ready),
                           .start(start),
                           .enable(enable),
                           .count16(count16),
                           .operation(operation),
                           .selectMultiplier(selectMultiplier),
                           .selectAccumulator(selectAccumulator));


// Add VCD dump commands
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, sequential_multiplier);
    end
    
endmodule