module Controller (
    input logic       clk,          // Clock signal
    input logic       rst_n,        // Ative-low reset signal
    input logic       src_valid,    // Source ready
    input logic       dest_ready,   // Destination ready signal
    input logic       count_done,   // Count complete signal
    input logic       sub_msb,

    output logic      src_ready,    // source ready indicating multiplier is ready to Accept new value
    output logic      dest_valid,   // Destination valid signal
    output logic      en_M,     
    output logic      en_Q,      
    output logic      en_count,     
    output logic      en_A,        
    output logic      alu_op,       // ALU operation code
    output logic      sel_Q,         // Select Q
    output logic      sel_A,         // Select A       
    output logic      en_out,       // Enable to store the product until destination handshake is complete
    output logic      en_final,     // The product will be provided when destination handshake is complete
    output logic      clear         // Clear signal
);

// Define states
typedef enum logic [1:0]{
    IDLE = 2'b00,  // Idle state
    RUN  = 2'b01,  // Run state
    WAIT = 2'b10  // Wait state
} state_t;

state_t current_state, next_state;  // Current and next state variables

// Sequential logic for state transition
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        current_state <= IDLE; // Reset to IDLE state on reset
    end else begin
        current_state <= next_state; // Transition to next state
    end
end

// Combinational logic for output logic and next state logic
always_comb begin
    case (current_state)
        IDLE: begin
            // Default outputs for IDLE state
            en_A       = 1'b0;
            en_Q       = 1'b0;
            en_M       = 1'b0;
            en_count   = 1'b0;
            en_out     = 1'b0;
            en_final   = 1'b0;
            alu_op     = 1'b0;
            sel_Q      = 1'b0;
            sel_A      = 1'b0;
            clear      = 1'b0;
            src_ready  = 1'b1;
            dest_valid = 1'b0;

            // Transition to RUN state if src_valid is high
            if (src_valid) begin
                next_state = RUN;
                en_A       = 1'b1;
                en_Q       = 1'b1;
                en_M       = 1'b1;
                en_count   = 1'b1;
            end else begin
                next_state = IDLE;
            end
        end

        RUN: begin
            // Default outputs for RUN state
            en_A       = 1'b1;
            en_Q       = 1'b1;
            en_M       = 1'b1;
            en_count   = 1'b1;
            en_out     = 1'b0;
            en_final   = 1'b0;
            alu_op     = 1'b0;
            sel_Q      = 1'b1;
            sel_A      = 1'b1;
            clear      = 1'b0;
            src_ready  = 1'b0;
            dest_valid = 1'b0;

            // if (count_done && dest_ready && src_valid) begin
            //     clear = 1'b1;
            //     case(sub_msb)
            //         1'b0: begin
            //             next_state = RUN;
            //             en_count   = 1'b1;
            //             sel_Q      = 1'b0;
            //             sel_A      = 1'b0;
            //             en_A       = 1'b1;
            //             en_Q       = 1'b1;
            //             en_M       = 1'b1;
            //             alu_op     = 1'b1;
            //             dest_valid = 1'b1;
            //             src_ready  = 1'b1;
            //         end
            //         1'b1: begin
            //             next_state = RUN;
            //             en_count   = 1'b1;
            //             sel_Q      = 1'b0;
            //             sel_A      = 1'b0;
            //             en_A       = 1'b1;
            //             en_Q       = 1'b1;
            //             en_M       = 1'b1;
            //             alu_op     = 1'b0;
            //             dest_valid = 1'b1;
            //             src_ready  = 1'b1;
            //         end
            //     endcase 
            if (count_done && !dest_ready) begin
                case(sub_msb) 
                    1'b0: begin
                        next_state = WAIT;
                        en_count   = 1'b0;
                        clear      = 1'b1;
                        dest_valid = 1'b1;
                        en_out     = 1'b1;
                        alu_op     = 1'b1;
                    end
                    1'b1: begin
                        next_state = WAIT;
                        en_count   = 1'b0;
                        clear      = 1'b1;
                        dest_valid = 1'b1;
                        en_out     = 1'b1;
                        alu_op     = 1'b0;
                    end
                endcase
            end else if(count_done && dest_ready) begin
                case(sub_msb) 
                    1'b0: begin
                        next_state = IDLE;
                        en_A       = 1'b0;
                        en_Q       = 1'b0;
                        en_M       = 1'b0;
                        en_count   = 1'b0;
                        clear      = 1'b1;
                        dest_valid = 1'b1;
                        en_out     = 1'b1;
                        en_final   = 1'b1;
                        alu_op     = 1'b1;
                        src_ready  = 1'b1;
                    end
                    1'b1: begin
                        next_state = IDLE;
                        en_A       = 1'b0;
                        en_Q       = 1'b0;
                        en_M       = 1'b0;
                        en_count   = 1'b0;
                        clear      = 1'b1;
                        dest_valid = 1'b1;
                        en_out     = 1'b1;
                        en_final   = 1'b1;
                        alu_op     = 1'b0;
                        src_ready  = 1'b1;
                    end
                endcase
            end else begin
                next_state = RUN;
                case(sub_msb)
                    1'b0: alu_op = 1'b1;
                    1'b1: alu_op = 1'b0;
                endcase
            end
        end

        WAIT: begin
            // Default outputs for WAIT state
            en_A       = 1'b1;
            en_Q       = 1'b1;
            en_M       = 1'b1;
            en_count   = 1'b0;
            en_out     = 1'b0;
            en_final   = 1'b0;
            alu_op     = 1'b0;
            sel_Q      = 1'b1;
            sel_A      = 1'b1;
            clear      = 1'b1;
            src_ready  = 1'b0;
            dest_valid = 1'b1;

            // Transition to DONE state if dest_ready is high
            if (dest_ready) begin
                next_state = IDLE;
                en_final   = 1'b1;
                src_ready  = 1'b1;
            end else begin
                next_state = WAIT;
            end
        end
        
        default: begin
            next_state = IDLE; // Default to IDLE on undefined state
        end
    endcase
end

endmodule
