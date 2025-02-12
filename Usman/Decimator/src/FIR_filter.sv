// FIR Filter Module
module FIR_filter #(parameter DELAY_SIZE = 8, TAP_SIZE = 8,
                    parameter SAMPLE_WIDTH = 32,
                    parameter INPUT_SIZE = 16,
                    parameter decimation_factor = 2,
                    parameter OUTPUT_BITS = 2*SAMPLE_WIDTH + $clog2(INPUT_SIZE/decimation_factor)
 ) (
    input logic clk,
    input logic reset,valid,
    input logic [SAMPLE_WIDTH-1:0] new_sample,
    input logic [SAMPLE_WIDTH-1:0] taps [0:7],
    output logic [OUTPUT_BITS-1:0] conv [0:2*TAP_SIZE-2],
    output logic valid_out,
    output logic WAIT   
);  
    logic compute_enable,shift;    
    logic [3:0] index;
    logic [31:0] delay_line [0:DELAY_SIZE-1];
   
    always_ff@(posedge clk) begin             
              if(valid && !WAIT) delay_line[0] = new_sample;      
    end   
    // Delay line shift logic
    always_ff @(posedge clk or posedge reset) begin
       if (reset) begin     
            for (int i = 1; i < DELAY_SIZE; i = i + 1)
                delay_line[i] <= 32'b0;
        end else begin
	      if (shift) begin
              for (int i = 1; i < DELAY_SIZE; i = i + 1)begin         
                  delay_line[i] <= delay_line[i-1]; end
              delay_line[0]=32'b0;
          end     
        end
    end


     // Instantiate state machine
    convolution_stateMachine #(
        .INPUT_SIZE(8),
        .KERNEL_SIZE(8)
    ) state_machine_inst (
        .clk(clk),
        .reset(reset),
        .start(valid),
        .compute_enable(compute_enable),
        .index(index),
        .valid_out(valid_out), 
        .shift(shift),
        .WAIT(WAIT)
    );

    // Instantiate datapath
    convolution_datapath #(
        .DATA_WIDTH(32),
        .INPUT_SIZE(8),
        .KERNEL_SIZE(8)
    ) datapath_inst (
        .clk(clk),
        .reset(reset),
        .compute_enable(compute_enable),
        .index(index),
        .input_array(delay_line),
        .kernel_array(taps),
        .result_array(conv)
    );
   
endmodule

