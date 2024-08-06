//==============Author: Masooma Zia==============
//==============Date: 29-07-2024==============
//==============Description:Controller for 16-bit signed sequential multiplier==============
module mul_ctrl(input logic clk, input logic rst, input logic start, input logic [16:0] q_shift_out, input logic clear, output logic ready,
output logic q_sel, A_sel, m_mux_sel, A_mux_sel, en_shift_q, en_m, en_shift_A, m_sel, en_q, en_A, en_ct);
logic current_state, next_state;
localparam S0=1'b0;
localparam S1=1'b1;
always_ff@(posedge clk, negedge rst) begin
    if (~rst) begin
        current_state <= S0;
    end else begin
        current_state <= next_state;
    end
end
//State machine
always@(*) begin
    case(current_state)
    S0: begin
        if (start==0) begin
            next_state=S0;
            en_m=0;
            en_q=0;
            en_A=0;
            en_ct=0;
            ready=0;
        end else begin
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
                //en_p=0;
            end else if (~q_shift_out[1]&q_shift_out[0]) begin
                next_state=S1;
                m_mux_sel=0;
                A_mux_sel=0;
                en_shift_q=1;
                en_shift_A=1;
                //en_p=0;
            end else if (~(q_shift_out[1]^q_shift_out[0])) begin
                next_state=S1;
                A_mux_sel=1;
                en_shift_q=1;
                en_shift_A=1;
                //en_p=0;
            end
        end
        else begin
            next_state=S0;
            ready=1;
            en_m=0;
            en_q=1;
            en_A=0;
            en_ct=1;
        end
    end
    endcase
end
endmodule

