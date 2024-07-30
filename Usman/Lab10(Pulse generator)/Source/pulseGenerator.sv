module pulseGenerator(
    input logic clk,
    input logic reset,
    input logic in,      
    output logic  out
);

    // State encoding
    typedef enum logic  {
        S0, S1
      
    } state;

    state current_state, next_state;

    // Combinational logic for state transitions and output
    always_comb begin
        case (current_state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S1 : S0;
            
            default: next_state = S0;
        endcase
    end

    // Sequential logic for state updates
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end
    always_comb begin
         case (current_state)
             S0: out = in ? 1:0;
             S1: out = in ? 0:0;
        
      default: out = 0;
   endcase
  end

endmodule

