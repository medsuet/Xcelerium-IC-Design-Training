module counter_0_to_13 (
    input   logic       clk,    // Clock signal
    input   logic       rst,    // Reset signal
    output  logic [3:0] count, // 4-bit counter output
    output  logic       clear
);

always_comb
begin 
    //It is a combinational circuit so it'll 
    //
    if (count == 4'd13) begin
        clear=1;
    end
    else
    begin
        clear=0;
    end
    
end

always_ff @( posedge clk, posedge rst  ) begin 
    if (rst | clear) begin
        count <= 4'b0000; // Reset count to 0
    end else begin
        count <= count + 1; // Increment count
    end
    
end 

endmodule
