module add_1(
    input logic in,

    input logic clk, reset,
    
    output logic out
);

logic [2:0]c_state, n_state;
parameter S0=3'h0, S1=3'b1, S2=3'h2, S3=3'h3;
parameter S4=3'h4, S5=3'h5, S6=3'h6;

always_ff @ (posedge clk or negedge reset) begin
    //reset is active high
    if (!reset) 
    c_state <= S0;
    else
    c_state <= n_state;
end
    
//next_state always block
always_comb begin
  case (c_state)
    S0: begin   
        if (in) n_state = S2;
        else n_state = S1;
    end

    S1: begin
        n_state = S3;
    end

    S2: begin
        if(in) n_state = S4;
        else n_state = S3;    
    end

    S3: begin
        n_state = S5;
    end

    S4: begin
        if (in) n_state = S6;
        else n_state = S5;
    end

    S5: begin
        n_state = S0;
    end

    S6: begin
        n_state = S0;
    end

    default: n_state = S0;
  endcase
end

//output always block
always_comb begin
  case (c_state)
    S0: begin 
        if (in) out = 0;
        else out = 1;
    end

    S1: begin 
        out = in;
    end

    S2: begin 
        if (in) out = 0;
        else out = 1;
    end

    S3: begin 
        out = in;
    end

    S4: begin 
        if (in) out = 0;
        else out = 1;
    end

    S5: begin 
        out = in;
    end

    S6: begin 
        out = ~in;
    end

    default:begin 
        out = 0;
    end
  endcase
end

endmodule