module decimator #(
   parameter SAMPLE_WIDTH = 32,
   parameter INPUT_SIZE   = 16,
   parameter NUM_TAPS     = 16, 
   parameter DECIMATION_FACTOR = 2,
   parameter OUTPUT_BITS = 2*SAMPLE_WIDTH + $clog2(INPUT_SIZE/DECIMATION_FACTOR)
)(
input logic clk, rst,
input logic [SAMPLE_WIDTH-1:0] new_sample,
input logic valid_in,
output logic [OUTPUT_BITS-1:0] decimated_output[0:15],
output logic output_valid,WAIT
);
// Initializing Parameters

localparam NUM_FILTERS         = DECIMATION_FACTOR;
localparam FILTER_OUTPUT_SIZE  = ((INPUT_SIZE/DECIMATION_FACTOR) * 2) - 1;
localparam TAPS_SIZE           =  NUM_TAPS/DECIMATION_FACTOR;
 
// Initializing   Valiables 
logic valid1,valid2,valid_out1,valid_out2,FIR1_WAIT,FIR2_WAIT;
logic [OUTPUT_BITS-1:0]conv1[0:FILTER_OUTPUT_SIZE-1];
logic [OUTPUT_BITS-1:0]conv2[0:FILTER_OUTPUT_SIZE-1];
logic [SAMPLE_WIDTH-1:0] taps1 [0:TAPS_SIZE-1];
logic [SAMPLE_WIDTH-1:0] taps2 [0:TAPS_SIZE-1];
logic [DECIMATION_FACTOR-1:0]select;

// Hard Coding Taps as Taps are Fixed
initial begin 
      taps2 ={32'd15,32'd13,32'd11,32'd9,32'd7,32'd5,32'd3,32'd1}; 
      taps1 = {32'd14,32'd12,32'd10,32'd8,32'd6,32'd4,32'd2,32'd0};  
end

// Module Instantiation
demux        Selector(clk,rst,valid_in,FIR1_WAIT,FIR2_WAIT,select,WAIT);   // Select Which Filter Should Take sample
FIR_filter   FIR1(clk,rst,select[0],new_sample,taps1,conv1,valid_out1,FIR1_WAIT);
FIR_filter   FIR2(clk,rst,select[1],new_sample,taps2,conv2,valid_out2,FIR2_WAIT);
accumulator  Adder(clk,rst,valid_out1,valid_out2,conv1,conv2,output_valid,decimated_output);// Accumulate Outputs From Both FIR
    
endmodule




