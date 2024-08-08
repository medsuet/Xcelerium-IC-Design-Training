module controller (
    input logic       clk,          // Clock signal
    input logic       reset,        // Active-low reset signal
    input logic       src_valid,    // Source valid signal
    input logic       dest_ready,   // Destination ready signal
    input logic       count_comp,   // Count complete signal
    input logic       sub_msb,      // Most significant bit of the subtraction result (A-M)

    output logic      src_ready,    // Source ready signal indicating the divider is ready to accept new value
    output logic      dest_valid,   // Destination valid signal indicating the quotient and remainder are ready
    output logic      en_M,         // Enable signal for M register
    output logic      en_Q,         // Enable signal for Q register
    output logic      en_count,     // Enable signal for count register
    output logic      en_A,         // Enable signal for A register
    output logic      alu_op,       // ALU operation code
    output logic      sel_Q,        // Select signal for Q register
    output logic      sel_A,        // Select signal for A register
    output logic      en_out,       // Enable signal to store the quotient and remainder until destination handshake is complete
    output logic      en_final,     // Final enable signal to provide the quotient and remainder when destination handshake is complete
    output logic      clear         // Clear signal
);

// Define states
typedef enum logic [1:0]{
    S0 = 2'b00,  // Idle state
    S1  = 2'b01,  // run state
    S2 = 2'b10   // wait state
} state_t;
state_t state, next_state; 

// Sequential logic for state transition
always_ff @(posedge clk or negedge reset) // active low asychronous reset
begin
    if (!reset) 
    begin
        state <= S0; 
    end 
    else 
    begin
        state <= next_state; 
    end
end

// Combinational logic for output logic and next state logic
always_comb begin
    case (state)
        S0: begin
            // Default outputs for S0 state
            // At reset state src_valid is low
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

            // Transition to S1 state if src_valid is high
            if (src_valid) begin // src_valid is high mean we want sending some valid data
                next_state = S1;
                en_A       = 1'b1;
                en_Q       = 1'b1;
                en_M       = 1'b1;
                en_count   = 1'b1;
            end 
            else // if src_valid is low then remain the same state
            begin
                next_state = S0;
            end
        end

        S1: begin
            // Default outputs for S1 state
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

            if (count_comp && !dest_ready) // check count complete is 16 and dest_ready is low move next state (wait)
            begin
                // Transition to S2 state and determine ALU operation based on sub_msb
                case(sub_msb) 
                    1'b0: 
                    begin
                        next_state = S2;
                        en_count   = 1'b0;
                        clear      = 1'b1;
                        dest_valid = 1'b1;
                        en_out     = 1'b1;
                        alu_op     = 1'b1; // alu_op is 1, retain remainder and set LSB of quotient
                    end
                    1'b1: 
                    begin
                        next_state = S2;
                        en_count   = 1'b0;
                        clear      = 1'b1;
                        dest_valid = 1'b1;
                        en_out     = 1'b1;
                        alu_op     = 1'b0; // alu_op is 0, perform addition and clear LSB of quotient
                    end
                endcase
            end 
            else if (count_comp && dest_ready) // check count to 16 and dest_ready is high move idle state 
            begin
                // Transition to S0 state when the destination is ready
                case(sub_msb) 
                    1'b0: 
                    begin
                        next_state = S0;
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
                    1'b1: 
                    begin
                        next_state = S0;
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
            end 
            else 
            begin
                next_state = S1;
                // Determine ALU operation based on sub_msb
                case(sub_msb)
                    1'b0: alu_op = 1'b1;
                    1'b1: alu_op = 1'b0;
                endcase
            end
        end

        S2: begin
            // Default outputs for S2 state
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

            // Transition to S0 state if dest_ready is high
            if (dest_ready) 
            begin
                next_state = S0;
                en_final   = 1'b1;
                src_ready  = 1'b1;
            end 
            else 
            begin
                next_state = S2;
            end
        end
        default: 
        begin
            next_state = S0; // Default to S0 on undefined state
        end
    endcase
end
endmodule
