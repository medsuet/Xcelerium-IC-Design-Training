module seq_multiplier_con
(
    input  logic clk, rst,
    input  logic valid_src,
    input  logic count_sh,
    input  logic last_bit,
    input  logic stop,
    input  logic b_val,
    output logic ready_src,

    output logic load_en,
    output logic shift_en,
    output logic count_en,
    output logic m1_sel,
    output logic m2_sel,
    output logic valid_des,
    output logic pp_clear,
    input  logic ready_des
);
    
parameter IDEL         = 0;
parameter CALCULATION  = 1;
parameter WAITING      = 2;

logic [1:0] c_state, n_state;

//state register
always_ff @ (posedge clk or negedge rst)
begin
    //reset is active low
    if (!rst)  c_state <= IDEL;
    else       c_state <= n_state;
end

//next_state always block
always_comb
begin
    case (c_state)
        IDEL:
        begin
            if (valid_src) n_state = CALCULATION;
            else           n_state = IDEL;     
        end

        CALCULATION:
        begin
            if(stop && ready_des)       n_state = IDEL;
            else if(stop && !ready_des) n_state = WAITING;
            else                        n_state = CALCULATION;
        end
        WAITING:
        begin
            if (ready_des) n_state = IDEL;
            else           n_state = WAITING;
        end
        default: 
        begin
            n_state = IDEL;
        end
    endcase
end

//Output logic 
always_comb
begin
    case (c_state)
        IDEL:
        begin
            pp_clear  = 1'b0;
            count_en  = 1'b0;
            valid_des = 1'b0;
            ready_src  = 1'b1;
            if (valid_src) begin load_en = 1'b1; end
            else          begin load_en = 1'b0; end     
        end

        CALCULATION:
        begin
            load_en  = 1'b0;
            count_en = 1'b1;
            ready_src  = 1'b0;
            if(b_val)     m1_sel   = 1'b1;
            else          m1_sel   = 1'b0;
            if(count_sh)  shift_en = 1'b1;
            else          shift_en = 1'b0;
            if(last_bit)  m2_sel   = 1'b1;
            else          m2_sel   = 1'b0;
            if(stop && ready_des) pp_clear = 1'b1;
            if(stop)      valid_des   = 1'b1;
            else          valid_des   = 1'b0;
        end
        
        WAITING:
        begin
            valid_des = 1'b1;
            count_en = 1'b0;
            if (ready_des) pp_clear = 1'b1;
            else           pp_clear = 1'b0;
        end
    endcase
end

endmodule