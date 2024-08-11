module controller(
    input logic RST,
    input logic CLK,
    input logic START,
    input logic STOP,
    input logic a_val,
    output logic en_A,
    output logic en_M,
   // output logic en_N,
    output logic en_Q,
    output logic mux_sel,
    output logic CLEAR,
    output logic count_en,
    output logic READY
);


parameter S0 = 1'b0;
parameter S1 = 1'b1;
logic c_state;
logic n_state;

always_ff @(posedge CLK or negedge RST) 
begin
    if(!RST)
    begin
        c_state <= #1 S0;
    end
    else
    begin
        c_state <= #1 n_state;
    end
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
        default : n_state = S0;
    endcase
end

//assign output values.


always_comb 
begin
    case(c_state)
        S0 : begin
            if(START)
            begin
                en_A = 1'b1;
                en_M = 1'b1;
               // en_N = 1'b1;
                en_Q = 1'b1;
                mux_sel = 1'b0;
                CLEAR = 1'b0;
                count_en = 1'b1;
                READY = 1'b0;
            end
            else
            begin
                en_A = 1'b0;
                en_M = 1'b0;
               // en_N = 1'b0;
                en_Q = 1'b0;
                mux_sel = 1'b0;
                CLEAR = 1'b0;
                count_en = 1'b0;
                READY = 1'b0;
            end
        end

        S1 : begin
            if ((STOP) & (a_val))   //when my STOP and a_val are 1 its mean output is ready
            begin
                en_A = 1'b0;
                en_M = 1'b0;
               // en_N = 1'b0;
                en_Q = 1'b0;
                mux_sel = 1'b1;
                CLEAR = 1'b1;
                count_en = 1'b0;
                READY = 1'b1;
            end
            if( (STOP) & (!a_val))
            begin
                en_A = 1'b0;
                en_M = 1'b0;
               // en_N = 1'b0;
                en_Q = 1'b0;
                mux_sel = 1'b0;
                CLEAR = 1'b1;
                count_en = 1'b0;
                READY = 1'b1;
            end
            if( (!STOP) & (a_val))
            begin
                en_A = 1'b0;
                en_M = 1'b0;
               // en_N = 1'b0;
                en_Q = 1'b0;
                mux_sel = 1'b1;
                CLEAR = 1'b0;
                count_en = 1'b1;
                READY = 1'b0;
            end
            if( (!STOP) & (!a_val))
            begin
                en_A = 1'b0;
                en_M = 1'b0;
               // en_N = 1'b0;
                en_Q = 1'b0;
                mux_sel = 1'b0;
                CLEAR = 1'b0;
                count_en = 1'b1;
                READY = 1'b0;
            end
        end
    endcase
end
endmodule



                


        
