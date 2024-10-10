module restore_ctrl(input logic clk, input logic rst, input logic clear, input logic [31:0] A_shift_opr, input logic src_valid, dest_ready, output logic src_ready, dest_valid,
en_A, en_dd, en_ds, en_ct, A_sel, dd_sel, MSB_set);
logic [1:0] current_state, next_state;
logic done=0;
localparam S0=2'b00;
localparam S1=2'b01;
localparam S2=2'b10;
always_ff @(posedge clk, negedge rst) begin
    if (~rst) begin
        current_state <= S0;
    end else begin
        current_state <= next_state;
    end
end
always@(*) begin
    next_state=current_state;
    case (current_state)
    S0: begin
        src_ready=1;
        dest_valid=0;
        if (~src_valid) begin
            en_A=0;
            en_dd=0;
            en_ds=0;
            en_ct=0;
            next_state=S0;
        end else begin
            en_A=1;
            en_dd=1;
            en_ds=1;
            en_ct=1;
            A_sel=0;
            dd_sel=0;
            next_state=S1;
        end
    end
    S1: begin
        src_ready=0;
        dest_valid=0;
        if (A_shift_opr[31]==1) begin
                MSB_set=1;
            end else if (A_shift_opr[31]==0) begin
                MSB_set=0;
        end
        if (clear) begin
            done=1;
        end
        if (~clear) begin
            en_A=1;
            en_dd=1;
            en_ds=0;
            A_sel=1;
            en_ct=1;
            dd_sel=1;
            next_state=S1;
        end
        else if (done) begin
            dest_valid=1;
            if (dest_ready) begin
                en_dd=0;
                en_A=0;
                en_ct=1;
                done=0;
                next_state=S0;
            end else begin
                en_dd=0;
                en_A=0;
                en_ct=1;
                next_state=S2;
            end
        end
    end
    S2: begin
        src_ready=1;
        dest_valid=0;
        done=0;
        if (dest_ready) begin
            en_dd=0;
            en_A=0;
            en_ct=0;
            next_state=S0;
        end else begin
            en_dd=0;
            en_A=0;
            en_ct=0;
            next_state=S2;
        end
    end
    default: next_state=S0;
    endcase
end
endmodule

