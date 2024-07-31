module seq_multiplier_con
(
    input logic CLK, RST,
    input logic START,
    input logic count_sh,
    input logic last_bit,
    input logic stop,
    input logic b_val,

    output logic load_en,
    output logic shift_en,
    output logic count_en,
    output logic m1_sel,
    output logic m2_sel,
    output logic READYO
);
    
parameter S0    =   0;
parameter S1    =   1;

logic c_state, n_state;

//state register
always_ff @ (posedge CLK or negedge RST)
begin
    //reset is active low
    if (!RST)  c_state <= S0;
    else       c_state <= n_state;
end

//next_state always block
always_comb
begin
    case (c_state)
        S0:
        begin
            if (START) n_state = S1;
            else       n_state = S0;     
        end

        S1:
        begin
            if(stop) n_state = S0;
            else     n_state = S1;
        end
    endcase
end

//Output logic 
always_comb
begin
    case (c_state)
        S0:
        begin
            count_en = 1'b0;
            READYO   = 1'b0;
            if (START) begin load_en = 1'b1; end
            else       begin load_en = 1'b0; end     
        end

        S1:
        begin
            load_en = 1'b0;
            count_en = 1'b1;
            if(b_val)     m1_sel   = 1'b1;
            else          m1_sel   = 1'b0;
            if(count_sh)  shift_en = 1'b1;
            else          shift_en = 1'b0;
            if(last_bit)  m2_sel   = 1'b1;
            else          m2_sel   = 1'b0;
            if(stop)      READYO   = 1'b1;
            else          READYO   = 1'b0;
        end
    endcase
end

endmodule