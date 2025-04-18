module demux #(
    parameter M = 2  
)(
    input  logic             clk,
    input  logic             reset,    
    input  logic             valid_in, 
    input logic FIR1_WAIT, FIR2_WAIT,
    output logic [M-1:0]     shift_reg, 
    output logic WAIT
);

   logic [M-1:0]reminder;   // Give valid only for one clock cycle  

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      
      shift_reg <= '0;
      reminder  <= '0;
    end else if (valid_in) begin
      // When valid_in is high:
      // If the shift register is all zeros, initialize it with bit 0 set to 1.
      if (shift_reg == '0 && reminder == '0)
        shift_reg <= {{(M-1){1'b0}}, 1'b1};
      // If the one-hot bit is at the last position, cycle back to bit 0.
      else if (shift_reg[M-1] || reminder[M-1])
        shift_reg <= {{(M-1){1'b0}}, 1'b1};
      // Otherwise, shift the one-hot bit one position to the left.
      else
        shift_reg <= reminder << 1;
    end else begin
      // When valid_in is low, set the output to zero.
      reminder <= shift_reg;       // Before setting value to zero, remember which filer was on
      shift_reg <= '0;
    end
  end

always_comb begin 
   if(FIR1_WAIT || FIR2_WAIT )  WAIT=1; 
   else WAIT = 0; 
   
end

endmodule
