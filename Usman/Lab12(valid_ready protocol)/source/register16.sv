module register16 (
    input logic clk,         
    input logic rst_n,        // Asynchronous active-low reset
    
    
    
    input logic [15:0] data_in_16, 
    input logic en,
    output logic [15:0] reg_16  
);

    
    
    // 16-bit register
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            reg_16 <= 16'b0; 
        else if (en)
            reg_16 <= data_in_16;
        
            
    end

endmodule

