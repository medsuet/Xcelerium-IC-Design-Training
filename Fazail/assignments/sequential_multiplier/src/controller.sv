module controller (
    input logic clk,
    input logic n_rst,

    // input by the user
    input logic start,

    // Datapath -> Controller
    input logic bit_01,
    input logic count_14,
    input logic count_15,

    // Controller -> Datapath
    output logic en_in,
    output logic bit_sel,
    output logic count_lb,
    output logic count_en,
    output logic clr,

    // product ready signal
    output logic ready
);

localparam WIDTH = 16;

localparam IDLE = 1'b0, CALC = 1'b1;
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
            if (count_15) n_state = IDLE;
            else n_state = CALC;
        end

        default: begin
            n_state = IDLE;
        end

    endcase
end

always_comb begin
    case (c_state)

        IDLE: begin
            if (start) begin
                en_in = 1'b1;
                bit_sel = 1'b0;
                count_lb = 1'b0;
                count_en = 1'b0;
                clr = 1'b0;
                ready = 1'b0;
            end
            else begin
                en_in = 1'b0;
                bit_sel = 1'b0;
                count_lb = 1'b0;
                count_en = 1'b0;
                clr = 1'b0;
                ready = 1'b0;
            end
        end

        CALC: begin
            if (bit_01 & !count_15 & !count_14) begin
                en_in = 1'b0;
                bit_sel = 1'b1;
                count_lb = 1'b0;
                count_en = 1'b1;
                clr = 1'b0;
                ready = 1'b0;
            end
            else if (!bit_01 & !count_15 & !count_14) begin
                en_in = 1'b0;
                bit_sel = 1'b0;
                count_lb = 1'b0;
                count_en = 1'b1;
                clr = 1'b0;
                ready = 1'b0;
            end
            else if (count_14 & !bit_01 & !count_15 ) begin
                en_in = 1'b0;
                bit_sel = 1'b0;
                count_lb = 1'b1;
                count_en = 1'b1;
                clr = 1'b0;
                ready = 1'b0;
            end
            else if (count_14 & bit_01 & !count_15 ) begin
                en_in = 1'b0;
                bit_sel = 1'b1;
                count_lb = 1'b1;
                count_en = 1'b1;
                clr = 1'b0;
                ready = 1'b0;
            end
            else if (count_15) begin
                en_in = 1'b0;
                bit_sel = 1'b0;
                count_lb = 1'b0;
                count_en = 1'b0;
                clr = 1'b1;
                ready = 1'b1;
            end

        end
        
    endcase
end

endmodule