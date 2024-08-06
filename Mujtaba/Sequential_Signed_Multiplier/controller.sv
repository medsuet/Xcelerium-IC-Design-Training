module controller (
    input logic start,
    input logic clk,
    input logic reset,
    input logic [3:0] SCval,
    output logic mupdEn,
    output logic muprEn,
    output logic SCEn,
    output logic restore_reg,
    output logic muxsel,
    output logic psEn,
    output logic resEn,
    output logic ready
);

    logic count;
    typedef enum logic [1:0] {
        S0,
        S1,
        S2
    } state_e;

    state_e current_state, next_state;

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            current_state <= S0;
            count  <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin 
        if (!reset) begin
            mupdEn = 0;
            muprEn = 0;
            SCEn = 0;
            muxsel = 0;
            psEn = 0;
            restore_reg = 0;
            resEn = 0;
            ready = 0;
        end else begin
            case (current_state) 
                S0: begin
                    if (!start) begin
                        mupdEn = 0;
                        muprEn = 0;
                        SCEn = 0;
                        muxsel = 1'bx;
                        psEn = 0;
                        resEn = 0;
                        ready = 0;
                        next_state = S0;
                    end else begin
                        if (start) begin
                            mupdEn = 1;
                            muprEn = 1;
                            next_state = S1;
                        end
                    end 
                    restore_reg = 0;
                end

                S1: begin
                    if (SCval != 4'hF) begin
                        mupdEn = 1;
                        muprEn = 1;
                        SCEn = 1;
                        muxsel = 1'b0;
                        psEn = 1;
                        resEn = 0;
                        ready = 0;
                        next_state = S1;
                    end else begin
                        muxsel = 1;
                        if (SCval == 4'hF) next_state = S2;
                    end 
                    restore_reg = 0;
                end 

                S2: begin
                     mupdEn = 0;
                     muprEn = 0;
                     SCEn = 0;
                     muxsel = 1'bx;
                     psEn = 0;
                     resEn = 1;
                     ready = 1;
                     restore_reg = 1;
                     count = 0;
                     next_state = S0;
                 end
             endcase
         end
     end

endmodule
