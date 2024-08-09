module sequential_multiply_controller (
    input logic CLK,
    input logic RESET,
    input logic src_valid,
    input logic dst_ready,
    input logic b_val,
    input logic stop,
    output logic en_A,en_B,
    output logic sign_sel,
    output logic a_sel,
    output logic count_en,
    output logic clear,
    output logic prod_clear,
    output logic en_prod,
    output logic src_ready,
    output logic dst_valid
);

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
logic [1:0] n_state, c_state;

always_ff @(posedge CLK or negedge RESET)
begin
    if (!RESET)
        c_state <= #1 S0;
    else
        c_state <= #1 n_state;
end

always_comb 
begin
    case(c_state)
    S0: begin
            if (src_valid)
                n_state = S1;
            else
                n_state = S0;
        end
    S1: begin
            if (stop & (!dst_ready))
                n_state = S2;
            else if (stop & (dst_ready))
                n_state = S0;
            else
                n_state = S1;
        end
    S2: begin
            if (dst_ready)
                n_state = S0;
            else
                n_state = S2;
        end
    endcase
end
    
always_comb
begin
    case(c_state)
    S0: begin
            if (src_valid)                          // store A and B
                begin
                    en_A      = 1;
                    en_B      = 1;
                    sign_sel  = 0;
                    a_sel     = 0;
                    count_en  = 0;
                    clear     = 0;
                    prod_clear = 1;
                    en_prod   = 0;
                    dst_valid = 0;
                end
            else                                // stay idle
                begin
                    en_A      = 0;
                    en_B      = 0;
                    sign_sel  = 0;
                    a_sel     = 0;
                    count_en  = 0;
                    clear     = 0;
                    prod_clear = 0;
                    en_prod   = 0;
                    dst_valid = 0;
                end
            
            src_ready = 1;
        end
    S1: begin
            if ( (b_val) & (stop) )         // product is ready
                begin
                    en_A      = 0;
                    en_B      = 0;
                    sign_sel  = 1;
                    a_sel     = 1;
                    count_en  = 0;
                    clear     = 1;
                    prod_clear = 0;
                    en_prod   = 1;
                    src_ready = 0;
                    //dst_valid = 0;
                end
            else if ( (!b_val) & (stop) )    // product is ready
                begin
                    en_A      = 0;
                    en_B      = 0;
                    sign_sel  = 1;
                    a_sel     = 0;
                    count_en  = 0;
                    clear     = 1;
                    prod_clear = 0;
                    en_prod   = 1;
                    src_ready = 0;
                    //dst_valid = 0;
                end
            else if ( (!b_val) & (!stop) )   // product is not ready
                begin
                    en_A      = 0;
                    en_B      = 0;
                    sign_sel  = 0;
                    a_sel     = 0;
                    count_en  = 1;
                    clear     = 0;
                    prod_clear = 0;
                    en_prod   = 1;
                    src_ready = 0;
                    //dst_valid = 0;
                end
            else if ( (b_val) & (!stop) )    // product is not ready
                begin
                    en_A      = 0;
                    en_B      = 0;
                    sign_sel  = 0;
                    a_sel     = 1;
                    count_en  = 1;
                    clear     = 0;
                    prod_clear = 0;
                    en_prod   = 1;
                    src_ready = 0;
                    //dst_valid = 0;
                end
            dst_valid = stop;
        end
    S2: begin
            en_A      = 0;
            en_B      = 0;
            sign_sel  = 0;
            a_sel     = 0;
            count_en  = 0;
            clear     = 0;
            prod_clear = 0;
            en_prod   = 0;
            src_ready = 0;
            dst_valid = 1;
        end
    endcase
end
endmodule