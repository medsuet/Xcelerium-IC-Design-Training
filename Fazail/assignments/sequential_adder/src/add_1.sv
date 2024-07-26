module add_1 (
    input logic in,
    input logic a,          // constant 1

    input logic clk,
    input logic reset,      // active low

    output logic value_out
);

logic carry;
logic c_state, n_state;
logic [1:0] count;
parameter S0=1'b0, S1=1'b1;

//assign a = 1;
//assign carry = 0;
//assign count = 0;

always_ff @ (posedge clk or negedge reset) begin
    //reset is active high
    if (!reset) 
    c_state <= #1 S0;
    else
    c_state <= #1 n_state;
end

//next_state always block
always_comb begin
  case (c_state)
    S0: begin   
      if (a & in) n_state = S1;
      else if (a & ~in) n_state = S1;
      //else if () n_state = S0; 
    end
    S1: begin   
      if (count == 3 & ~a) n_state = S0;
      else if (~carry & ~in & (count != 3)) n_state = S1;
      else if (carry & in & (count != 3)) n_state = S1;
      else if (carry & ~in & (count != 3)) n_state = S1;
      else if (~carry & in & (count != 3)) n_state = S1;
      //else n_state = S1;
    end

    default: n_state = S0;
  endcase
end

//output always block
always_comb begin
    value_out = 0;
    carry = 0;
    count = 0;
  case (c_state)
    S0: begin 
        if (a & ~in) begin
            value_out = 1;
            carry = 0;
            count = 0;
        end
        else if (a & in) begin
            value_out = 0;
            carry = 1;
            count = 0;
        end
    end

    S1: begin 
        if (carry & in & (count != 3)) begin
            value_out = 0;
            carry = 1;
            count = count + 1;
        end

        else if(~carry & ~in & (count != 3)) begin
            value_out = 0;
            carry = 0;
            count = count + 1;
        end

        else if (carry & ~in & (count != 3)) begin
            value_out = 1;
            carry = 0;
            count = count + 1;
        end

        else if (~carry & in & (count != 3)) begin
            value_out = 1;
            carry = 0;
            count = count + 1;
        end
    end
  endcase
end

endmodule