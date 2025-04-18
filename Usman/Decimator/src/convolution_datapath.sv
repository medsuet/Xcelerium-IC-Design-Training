module convolution_datapath #(
    parameter DATA_WIDTH = 32,    
    parameter INPUT_SIZE = 8,    
    parameter KERNEL_SIZE = 8,    
    parameter decimation_factor = 2
) (
    input  logic clk,                            
    input  logic reset,                          
    input  logic compute_enable,                 
    input  logic [3:0] index,                   
    input  logic [DATA_WIDTH-1:0] input_array [0:INPUT_SIZE-1],  
    input  logic [DATA_WIDTH-1:0] kernel_array [KERNEL_SIZE-1:0], 
    output logic [66:0] result_array [0:INPUT_SIZE*2-2] 
);
    
    logic [DATA_WIDTH-1:0] product [KERNEL_SIZE-1:0]; 
    logic [66:0] sum;                      
    integer i;

    // Perform convolution when enabled
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            sum <= 0;
            for (i = 0; i <= 2*INPUT_SIZE ; i++) begin
                result_array[i] <= 0;
            end
        end else if (compute_enable) begin
            // Compute convolution at the current index
            sum = 0;
            for (int i = 0; i <= index; i++) begin
              if((i)<=INPUT_SIZE-1 && compute_enable)begin
                sum += input_array[i] * kernel_array[i];end
                
           
            end
            result_array[index] <= sum;
            
        end
    end
endmodule
