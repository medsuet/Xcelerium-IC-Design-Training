module controller #(
    WIDTH = 16
) (
    input logic clk,
    input logic n_rst,

    // input by the user
    //input logic start,
    input logic src_valid_i,
    output logic src_ready_o,

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
    output logic en_fp,

    // product ready signal
    //output logic ready
    input logic dst_ready_i,
    output logic dst_valid_o
);
parameter IDLE = 2'h0, CALC = 2'h1, WAIT_DST_RDY = 2'h2, WAIT_VLD = 2'h3;
logic [1:0]c_state, n_state;

always_ff @( posedge clk or negedge n_rst ) begin : state_register
    if (!n_rst) begin
        c_state <= IDLE;
    end
    else begin 
        c_state <= n_state;
    end
end

always_comb begin
    case (c_state)

        IDLE: begin
            if (src_valid_i) n_state = CALC;
            else n_state = IDLE;
        end

        WAIT_DST_RDY: begin
            if (dst_ready_i) n_state = IDLE;
            else n_state = WAIT_DST_RDY; 
        end

        CALC: begin
            if (count_15 & !dst_ready_i) n_state = WAIT_DST_RDY;
            else if (count_15 & dst_ready_i) n_state = IDLE;
            else n_state = CALC;
        end

        default: begin
            n_state = IDLE;
        end

    endcase
end

always_comb begin
    en_fp = 0;
    case (c_state)

        IDLE: begin
            if (src_valid_i) begin
                en_in       = 1'b1;
                src_ready_o = 1'b1;
                bit_sel     = 1'b0;
                count_lb    = 1'b0;
                count_en    = 1'b0;
                clr         = 1'b1;
                dst_valid_o = 1'b0;
            end
            else begin
                en_in       = 1'b0;
                src_ready_o = 1'b1;
                bit_sel     = 1'b0;
                count_lb    = 1'b0;
                count_en    = 1'b0;
                clr         = 1'b0;
                dst_valid_o = 1'b0;
            end
        end

        WAIT_DST_RDY: begin
            if (dst_ready_i) begin
                en_in       = 1'b0;
                bit_sel     = 1'b0;
                count_lb    = 1'b0;
                count_en    = 1'b0;
                clr         = 1'b0;
                dst_valid_o = 1'b1;
                en_fp       = 1'b1;
                src_ready_o = 1'b0;
            end

            else begin
                en_in       = 1'b0;
                bit_sel     = 1'b0;
                count_lb    = 1'b0;
                count_en    = 1'b0;
                clr         = 1'b0;
                en_fp       = 1'b1;
                dst_valid_o = 1'b1;
                src_ready_o = 1'b0;
            end            
        end

        CALC: begin
            if (bit_01 & !count_15 & !count_14) begin
                en_in       = 1'b0;
                bit_sel     = 1'b1;
                count_lb    = 1'b0;
                count_en    = 1'b1;
                clr         = 1'b0;
                dst_valid_o = 1'b0;
                src_ready_o = 1'b0;
            end
            else if (!bit_01 & !count_15 & !count_14) begin
                en_in       = 1'b0;
                bit_sel     = 1'b0;
                count_lb    = 1'b0;
                count_en    = 1'b1;
                clr         = 1'b0;
                dst_valid_o = 1'b0;
                src_ready_o = 1'b0;
            end
            else if (count_14 & !bit_01 & !count_15) begin
                en_in       = 1'b0;
                bit_sel     = 1'b0;
                count_lb    = 1'b1;
                count_en    = 1'b1;
                clr         = 1'b0;
                dst_valid_o = 1'b0;
                src_ready_o = 1'b0;
            end
            else if (count_14 & bit_01 & !count_15) begin
                en_in       = 1'b0;
                bit_sel     = 1'b1;
                count_lb    = 1'b1;
                count_en    = 1'b1;
                clr         = 1'b0;
                dst_valid_o = 1'b0;
                src_ready_o = 1'b0;
            end
            else if (count_15 & !dst_ready_i) begin
                en_in       = 1'b0;
                bit_sel     = 1'b0;
                count_lb    = 1'b0;
                count_en    = 1'b0;
                clr         = 1'b0;
                dst_valid_o = 1'b1;
                en_fp       = 1'b1;
                src_ready_o = 1'b0;
            end
            else if (count_15 & dst_ready_i) begin
                en_in       = 1'b0;
                bit_sel     = 1'b0;
                count_lb    = 1'b0;
                count_en    = 1'b0;
                clr         = 1'b0;
                dst_valid_o = 1'b1;
                en_fp       = 1'b1;
                src_ready_o = 1'b0;
            end
        end

        default: begin
                en_in       = 1'b1;
                src_ready_o = 1'b1;
                bit_sel     = 1'b0;
                count_lb    = 1'b0;
                count_en    = 1'b0;
                clr         = 1'b1;
                dst_valid_o = 1'b0;
            end
    endcase
end

endmodule