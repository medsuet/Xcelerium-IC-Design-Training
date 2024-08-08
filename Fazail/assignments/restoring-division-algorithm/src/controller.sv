module controller (
    input logic clk,
    input logic n_rst,

    // input by the user
    input logic start,

    // datapath -> controller
    input logic a_msb,
    input logic n_count,

    // controller -> datapath
    output logic en_in,
    output logic en_aq,
    output logic sel_a,
    output logic count_en,
    output logic clr,
    output logic en_qr,

    // ready signal
    output logic ready
);

parameter IDLE = 1'b0, CALC = 1'b1;
logic c_state, n_state;

always_ff @( posedge clk or negedge n_rst ) begin : state_register
    if (!n_rst) c_state <= IDLE;
    else c_state <= n_state;
end

always_comb begin
    case (c_state)

        IDLE: begin
            if (start) n_state = CALC;
            else n_state = IDLE;
        end

        CALC: begin
            if (n_count) n_state = IDLE;
            else n_state = CALC;
        end

        default: begin
            n_state = IDLE;
        end

    endcase
end

always_comb begin

    // controller -> datapath
    en_in    = 1'b0;
    en_aq    = 1'b0;
    sel_a    = 1'b0;
    count_en = 1'b0;
    clr      = 1'b0;
    ready    = 1'b0;
    en_qr    = 1'b0;

    case (c_state)

        IDLE: begin
            if (start) begin
                en_in = 1'b1;
                en_aq = 1'b1;
                clr = 1'b0;
            end
            else begin
                en_in = 1'b0;
                en_aq = 1'b0;
                clr = 1;
            end
        end

        CALC: begin
            if (a_msb & !n_count) begin
                sel_a = 1'b1;
                count_en = 1'b1;
            end
            
            else if (!a_msb & !n_count) begin
                sel_a = 1'b0;
                count_en = 1'b1;
            end

            else if (n_count) begin
                clr = 1'b0;
                ready = 1'b1;
                en_qr = 1'b1;
                count_en = 1'b0;
            end
        end

        default: begin
            en_in    = 1'b0;
            en_aq    = 1'b0;
            sel_a    = 1'b0;
            count_en = 1'b0;
            clr      = 1'b0;
            en_qr    = 1'b0;
        end
        
    endcase
end

endmodule