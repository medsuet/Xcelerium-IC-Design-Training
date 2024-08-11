module controller(
    input logic CLK,
    input logic RST,
    input logic STOP,
    input logic b_val,
    input logic START,
    output logic enable_A,
    output logic enable_B,
    output logic a_sel,
    output logic comp_sel,
    output logic count_en,
    output logic clear_product,
    output logic CLEAR,
    output logic READY
);

parameter S0 = 1'b0;
parameter S1 = 1'b1;
logic n_state;
logic c_state;

always_ff @(posedge CLK or negedge RST)
begin
    if (!RST)
        c_state <= #1 S0;
    else
        c_state <= #1 n_state;
end

always_comb
begin 
    case(c_state)
        S0 : begin if(START) n_state = S1;
            else n_state = S0;
        end

        S1 : begin if(STOP) n_state = S0;
            else n_state = S1;
        end
    endcase
end

//ssign output values.


always_comb
begin
    case(c_state)
        S0 : begin
            if (START)
            begin 
                enable_A = 1'b1;
                enable_B = 1'b1;
                a_sel    = 1'b0;
                count_en = 1'b0;
                comp_sel = 1'b0;
                CLEAR    = 1'b0;
                clear_product = 1'b1;
                READY = 1'b0;
            end
            else
            begin
                enable_A = 1'b0;
                enable_B = 1'b0;
                a_sel    = 1'b0;
                count_en = 1'b0;
                comp_sel = 1'b0;
                CLEAR    = 1'b0;
                clear_product = 1'b0;
                READY = 1'b0;
            end
        end

        S1 : begin
            if( (b_val) & (STOP))     // when my STOP and b_val are 1 its mean output is ready
            begin
                enable_A = 1'b0;
                enable_B = 1'b0;
                a_sel    = 1'b1;
                count_en = 1'b0;
                comp_sel = 1'b1;
                CLEAR    = 1'b1;
                clear_product = 1'b0;
                READY = 1'b1;
            end

            if( (!b_val) & (STOP))     // when my STOP is 1 and b_val=0 its mean output is ready
            begin
                enable_A = 1'b0;
                enable_B = 1'b0;
                a_sel    = 1'b0;
                count_en = 1'b0;
                comp_sel = 1'b1;
                CLEAR    = 1'b1;
                clear_product = 1'b0;
                READY = 1'b1;
            end

            if( (!b_val) & (!STOP))    // product is not ready
            begin
                enable_A = 1'b0;
                enable_B = 1'b0;
                a_sel    = 1'b0;
                count_en = 1'b1;
                comp_sel = 1'b0;
                CLEAR    = 1'b0;
                clear_product = 1'b0;
                READY = 1'b0;
            end

            if( (b_val) & (!STOP))     // w
            begin
                enable_A = 1'b0;
                enable_B = 1'b0;
                a_sel    = 1'b1;
                count_en = 1'b1;
                comp_sel = 1'b0;
                CLEAR    = 1'b0;
                clear_product = 1'b0;
                READY = 1'b0;
            end
        end
    endcase
end
endmodule






