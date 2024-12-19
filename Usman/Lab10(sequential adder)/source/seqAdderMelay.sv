module SeqAdderMealy (
    input logic clk,
    input logic reset,
    input logic in,      
    output logic  out
);

    // State encoding
    typedef enum logic [2:0] {
        S0, S1, S2, S3, S4, S5, S6, S7
      
    } state;

    state current_state, next_state;

    // Combinational logic for state transitions and output
    always_comb begin
        case (current_state)
            S0: next_state = in ? S5 : S1;
            S1: next_state = in ? S2 : S2;
            S2: next_state = in ? S3 : S3;
            S3: next_state = in ? S0 : S0;
            S5: next_state = in ? S6 : S2;
            S6: next_state = in ? S7 : S3;
            S7: next_state = in ? S0 : S0;
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
             S0: out = in ? 0:1;
             S1: out = in ? 1:0;
             S2: out = in ? 1:0;
             S3: out = in ? 1:0;
             S5: out = in ? 0:1;
             S6: out = in ? 0:1;
             S7: out = in ? 0:1;
      default: out = 0;
   endcase
  end

endmodule

