module controller (
    input logic src_valid,
    input logic dest_ready,
    input logic clk,
    input logic reset,
    input logic [3:0] SCval,
    output logic mupdEn,
    output logic muprEn,
    output logic SCEn,
    output logic restore_reg,
    output logic muxsel,
    output logic psEn,
    output logic dest_valid,
    output logic src_ready
);

    typedef enum logic [1:0] {
        S0, // Start State
        S1, // Multiplication State
        S2  // Result State
    } state_e;

    state_e current_state, next_state;

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        // Default values
        mupdEn = 0;
        muprEn = 0;
        SCEn = 0;
        muxsel = 0;
        psEn = 0;
        restore_reg = 0;
        src_ready = 0;
        dest_valid = 0;

        case (current_state)
             S0: begin
                 src_ready = 1;
                 restore_reg = 1;

                 if (src_valid) begin
                     mupdEn = 1;
                     muprEn = 1;
                     next_state = S1;
                 end else begin
                     next_state = S0;
                 end
             end

             S1: begin
                 if (SCval != 4'hF) begin
                     mupdEn = 1;
                     muprEn = 1;
                     SCEn = 1;
                     muxsel = 0;
                     psEn = 1;
                     dest_valid = 0;
                     next_state = S1;
                 end else begin
                     if (SCval == 4'hF) begin
                         mupdEn = 1;
                         muprEn = 1;
                         SCEn = 1;
                         muxsel = 1;
                         psEn = 1;
                         dest_valid = 1;
                         if (dest_ready) begin
                            next_state = S0;
                        end else begin
                            next_state = S2;
                        end
                     end
                 end
             end

             S2: begin
                 dest_valid = 1;
                 mupdEn = 0;
                 muprEn = 0;
                 SCEn = 0;
                 muxsel = 1'bx;
                 psEn = 0;
                 restore_reg = 1;
                 if (dest_ready) begin
                     next_state = S0;
                 end else begin
                     next_state = S2; 
                 end
             end

             default: begin
                mupdEn = 0;
                muprEn = 0;
                SCEn = 0;
                muxsel = 0;
                psEn = 0;
                restore_reg = 0;
                src_ready = 0;
                dest_valid = 0;
            end
         endcase
     end

endmodule

