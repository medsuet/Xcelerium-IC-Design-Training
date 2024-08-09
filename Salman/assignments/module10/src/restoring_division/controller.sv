module controller (
    input logic clk,
    input logic reset,
    // Controller I/O's
    input logic msb_a,
    input logic stop,
    output logic mux_aq,
    output logic en_aq,
    output logic en_m,
    output logic sel_aq,
    output logic clear,
    output logic count_en,
    // Ready-valid signals
    input logic src_valid,
    output logic src_ready,
    input logic dst_ready,
    output logic dst_valid
);

localparam WIDTH = 16;
localparam S0 = 1'b0;
localparam S1 = 1'b1;
logic c_state, n_state;

always_ff @(posedge clk or negedge reset)
begin
    if (!reset)
        c_state <= #1 S0;
    else
        c_state <= #1 n_state;
end

always_comb
begin
    case (c_state)
        S0: begin
                if (src_valid)
                    n_state = S1;
                else
                    n_state = S0;
            end
        S1: begin
                if (stop & dst_ready)
                    n_state = S0;
                else
                    n_state = S1;
            end
    endcase
end

always_comb
begin
    case (c_state)
        S0: begin
                if (src_valid)
                begin
                    en_aq = 1;
                    en_m  = 1;
                    mux_aq = 1;
                end
                else
                begin
                    en_aq = 0;
                    en_m  = 0;
                    mux_aq = 0;
                end
                src_ready = 1;
                clear     = 1;
                sel_aq    = 0;
                count_en  = 0;
                dst_valid = 0;
            end
        S1: begin
                if (msb_a)
                    sel_aq = 1;
                else
                    sel_aq = 0;

                mux_aq = 0;
                en_m  = 0;
                clear = 0;
                src_ready = 0;

                en_aq     = !(stop);
                count_en  = !(stop);
                dst_valid = stop;
            end
    endcase
end
    
endmodule