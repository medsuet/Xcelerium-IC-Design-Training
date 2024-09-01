module controller (
    input logic src_valid,
    input logic dest_ready,
    input logic clk,
    input logic reset,
    input logic [4:0] SCval,
    output logic divisor_en,
    output logic dividend_en,
    output logic SCEn,
    output logic restore_reg,
    output logic sh_en,
    output logic acc_en,
    output logic dest_valid,
    output logic src_ready
);

    typedef enum logic [1:0] {
        S0, // Start State
        S1, // Divison State
        S2  // Wait State
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
        divisor_en = 0;
        dividend_en = 0;
        SCEn = 0;
        sh_en = 0;
        acc_en = 0;
        restore_reg = 0;
        src_ready = 0;
        dest_valid = 0;

        case (current_state)
             S0: begin
                 src_ready = 1;
                 restore_reg = 1;

                 if (src_valid) begin
                     divisor_en = 1;
                     dividend_en = 1;
                     next_state = S1;
                 end else begin
                     next_state = S0;
                 end
             end

             S1: begin
                 if (SCval != 5'h11) begin
                     sh_en = 1;
                     acc_en = 1;
                     SCEn = 1;
                     dest_valid = 0;
                     next_state = S1;
                 end else begin
                     if (SCval == 5'h11) begin
                         sh_en = 1;
                         acc_en = 1;
                         SCEn = 1;
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
                 SCEn = 0;
                 sh_en = 0;
                 acc_en = 0;
                 restore_reg = 1;
                 if (dest_ready) begin
                     next_state = S0;
                 end else begin
                     next_state = S2; 
                 end
             end

             default: begin
                divisor_en = 0;
                dividend_en = 0;
                SCEn = 0;
                sh_en = 0;
                acc_en = 0;
                restore_reg = 0;
                src_ready = 0;
                dest_valid = 0;
            end
         endcase
     end

endmodule

