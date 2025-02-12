module accumulator #(
    parameter WIDTH = 32,   
    parameter FILTER_SIZE = 16,     
    parameter  TAP_SIZE  =  16,
    parameter decimation_factor =2,
    parameter OUTPUT_BITS = 2*WIDTH + $clog2(FILTER_SIZE/decimation_factor)
) (
    input logic clk,                      
    input logic reset,                   
    input logic valid_input1,             
    input logic valid_input2,             
    input logic [OUTPUT_BITS-1:0] array1[0:FILTER_SIZE-2],  
    input logic [OUTPUT_BITS-1:0] array2[0:FILTER_SIZE-2], 
    output logic valid,                  
    output logic [OUTPUT_BITS-1:0] result[0:(FILTER_SIZE+TAP_SIZE-2)/decimation_factor]
    
);
    // Internal storage 
    logic [OUTPUT_BITS-1:0] extended_array1[0:(FILTER_SIZE+TAP_SIZE-2)/decimation_factor];
    logic [OUTPUT_BITS-1:0] extended_array2[0:(FILTER_SIZE+TAP_SIZE-2)/decimation_factor];
    logic waiting_for_array2;
    
    always_comb begin
        for (int i = 0; i <= (FILTER_SIZE+TAP_SIZE-2)/decimation_factor; i++) begin                        
                    result[i] = extended_array1[i] + extended_array2[i];             
        end
     end
   
    always_ff @(posedge clk or posedge reset) begin
        
        if (reset) begin
            valid <= 0;
            waiting_for_array2 <= 0;
            for (int j = 0; j <= (FILTER_SIZE+TAP_SIZE-2)/decimation_factor; j++) begin
                extended_array1[j] <= 0;
                extended_array2[j] <= 0;
                result[j] <= 0;
            end
        end else begin            
            if (valid_input1 && !waiting_for_array2) begin
                // Append 0 to array1
                extended_array1={array1,0};
                waiting_for_array2 <= 1;
                valid <= 0;
            end else if (valid_input2 && waiting_for_array2) begin
                // Preapend 0 to array1              
                extended_array2={0,array2};
                valid <= 1;           
                waiting_for_array2 <= 0;  
            end else begin
                valid <= 0; 
            end
        end
    end

endmodule

