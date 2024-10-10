//==============Author: Masooma Zia==============
//==============Date: 1-08-2024==============
//==============Description:Controller for 16-bit signed sequential multiplier with ready-val interface==============
module mul_ctrl(input logic clk, input logic rst, input logic src_valid, dest_ready, input logic [16:0] q_shift_out, input logic clear, output logic src_ready, dest_valid,
output logic q_sel, A_sel, m_mux_sel, A_mux_sel, en_shift_q, en_m, en_shift_A, m_sel, en_q, en_A, en_ct);
logic [1:0] current_state, next_state;
logic done;
localparam S0=2'b10;
localparam S1=2'b00;
localparam S2=2'b01;
always_ff@(posedge clk, negedge rst) begin
    if (~rst) begin
        current_state <= S0;
    end else begin
        current_state <= next_state;
    end
end
//state machine
always@(*) begin
    case(current_state)
    S0: begin
        done=0;
        dest_valid=0;
        src_ready=1;
        dest_valid=0;
        if (src_valid==0) begin
            next_state=S0;
            en_m=0;
            en_q=0;
            en_A=0;
            en_ct=0;
        end else if (src_valid==1)begin
            next_state=S1;
            q_sel=1;
            A_sel=1;
            en_ct=1;
            m_sel=1;
            en_shift_q=0;
            en_shift_A=0;
            en_m=1;
            en_q=1;
            en_A=1;
        end
    end
    S1: begin
        src_ready=0;
        dest_valid=0;
        if (~clear) begin
            q_sel=0;
            A_sel=0;
            m_sel=0;
            en_m=1;
            en_q=1;
            en_A=1;
            en_ct=1;
            if (q_shift_out[1]&~q_shift_out[0]) begin
                next_state=S1;
                m_mux_sel=1;
                A_mux_sel=0;
                en_shift_q=1;
                en_shift_A=1;
            end else if (~q_shift_out[1]&q_shift_out[0]) begin
                next_state=S1;
                m_mux_sel=0;
                A_mux_sel=0;
                en_shift_q=1;
                en_shift_A=1;
            end else if (~(q_shift_out[1]^q_shift_out[0])) begin
                next_state=S1;
                A_mux_sel=1;
                en_shift_q=1;
                en_shift_A=1;
            end
        end
        else if (done|~dest_ready)begin
            next_state=S2;
            dest_valid=1;
            en_m=0;
            en_q=0;
            en_A=0;
            en_ct=1;
        end
        else if (done|dest_ready)begin
            done=0;
            dest_valid=1;
            next_state=S0;
            en_m=0;
            en_q=0;
            en_A=0;
            en_ct=1;
        end
        if (clear) begin
            done=1;
        end
    end
    S2: begin
        src_ready=0;
        dest_valid=1;
        if (dest_ready) begin
            next_state=S0;
            done=0;
            en_m=0;
            en_q=0;
            en_A=0;
            en_ct=0;
        end else begin
            next_state=S2;
            en_m=0;
            en_q=0;
            en_A=0;
            en_ct=0;
        end
    end
    default:
        next_state=S0;
    endcase
end
endmodule

