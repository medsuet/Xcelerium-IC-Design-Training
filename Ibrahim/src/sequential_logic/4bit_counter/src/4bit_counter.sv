module counter #(
    parameter WIDTH_C = 4,
    parameter int MAX_COUNT = 13
  ) (
      // Input signals
      input logic                clk, 
      input logic                reset,
  
      // Output signals
      output logic [WIDTH_C-1:0] reg_out
  );
      logic [WIDTH_C-1:0] count_up;
      logic [WIDTH_C-1:0] reg_in;
      logic               clear;
  
      // Adder: count_up = reg_out + 1
      assign count_up = reg_out + 1'b1;
  
      // Comparator: clear is high when reg_out == 13
      assign clear = (reg_out == MAX_COUNT);
  
      // MUX: select_count is either count_up or 0
      assign reg_in = clear ? {WIDTH_C{1'b0}}  : count_up;
  
      always_ff @(posedge clk or posedge reset) begin
          if(reset) begin
              reg_out <= #1 {WIDTH_C{1'b0}};
          end else begin
              reg_out <= #1 reg_in;
          end
      end
  endmodule