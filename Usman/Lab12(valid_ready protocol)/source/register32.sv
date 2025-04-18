module register32 (
    input logic clk,          
    input logic rst_n,        // Asynchronous active-low reset
    
    input logic [31:0] data_in_32, 
    input logic en,
    output logic [31:0] reg_32
   
);

    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            reg_32 <= 32'b0; 
        else if(en)
            reg_32 <= data_in_32; 
    end

   

endmodule

