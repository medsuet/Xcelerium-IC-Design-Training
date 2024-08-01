module Controller (
    input logic       clk,          // Clock signal
    input logic       rst_n,        // Active-low reset signal
    input logic       src_valid,    // Source ready
    input logic       dest_ready,   // Destination ready signal
    input logic       count_done,   // Count complete signal
    input logic       Q0,           // Input Q0
    input logic       Q_1,          // Input Q1

    output logic      src_ready,    // source ready indicating multiplier is ready to acccept new value
    output logic      dest_valid,   // Destination valid signal
    output logic      en_multr,     // Enable multiplier
    output logic      en_mltd,      // Enable multiplicand
    output logic      en_count,     // Enable counter
    output logic      en_ac,        // Enable accumulator
    output logic [1:0]alu_op,       // ALU operation code
    output logic      selQ,         // Select Q
    output logic      selA,         // Select A
    output logic      selQ_1,       // Select Q_1
    output logic      en_out,       // Enable to store the product until destination handshake is complete
    output logic      en_final,     // The product will be provided when destination handshake is complete
    output logic      clear         // Clear signal
);

// Define states
typedef enum logic[1:0]{
    IDLE = 2'b00,  // Idle state
    RUN  = 2'b01,  // Run state
    WAIT = 2'b10,  // Wait state
    DONE = 2'b11   // Done state
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
            en_ac      = 1'b0;
            en_mltd    = 1'b0;
            en_multr   = 1'b0;
            en_count   = 1'b0;
            en_out     = 1'b0;
            en_final   = 1'b0;
            alu_op     = 2'b00;
            selQ       = 1'b0;
            selA       = 1'b0;
            selQ_1     = 1'b0;
            clear      = 1'b0;
            src_ready  = 1'b1;
            dest_valid = 1'b0;

            // Transition to RUN state if src_valid is high
            if (src_valid) begin
                next_state = RUN;
                en_ac      = 1'b1;
                en_mltd    = 1'b1;
                en_multr   = 1'b1;
                en_count   = 1'b1;
                en_out     = 1'b0;
            end else begin
                next_state = IDLE;
            end
        end

        RUN: begin
            // Default outputs for RUN state
            en_ac      = 1'b1;
            en_mltd    = 1'b1;
            en_multr   = 1'b1;
            en_count   = 1'b1;
            en_out     = 1'b0;
            en_final   = 1'b0;
            alu_op     = 2'b00;
            selQ       = 1'b1;
            selA       = 1'b1;
            selQ_1     = 1'b1;
            clear      = 1'b0;
            src_ready  = 1'b0;
            dest_valid = 1'b0;

            // Transition based on count_done and Q0, Q_1 values
            if (count_done) begin
                if (Q0 & !Q_1) begin
                    next_state = WAIT;
                    alu_op     = 2'b01;  // Subtract operation
                    en_count   = 1'b0;
                    en_out     = 1'b1;
                    clear      = 1'b1;
                    dest_valid = 1'b1;
                end else if (!Q0 & Q_1) begin
                    next_state = WAIT;
                    alu_op     = 2'b10;  // Add operation
                    en_count   = 1'b0;
                    en_out     = 1'b1;
                    clear      = 1'b1;
                    dest_valid = 1'b1;
                end else begin
                    next_state = WAIT;
                    alu_op     = 2'b00;  // No operation
                    en_count   = 1'b0;
                    en_out     = 1'b1;
                    clear      = 1'b1;
                    dest_valid = 1'b1;
                end
            end else if ((Q0 & Q_1) | (!Q0 & !Q_1)) begin
                next_state = RUN;
            end else if (Q0 & !Q_1) begin
                next_state = RUN;
                alu_op = 2'b01;  // Subtract operation
            end else begin
                next_state = RUN;
                alu_op = 2'b10;  // Add operation
            end
        end

        WAIT: begin
            // Default outputs for WAIT state
            en_ac      = 1'b1;
            en_mltd    = 1'b1;
            en_multr   = 1'b1;
            en_count   = 1'b0;
            en_out     = 1'b0;
            en_final   = 1'b0;
            alu_op     = 2'b10;
            selQ       = 1'b1;
            selA       = 1'b1;
            selQ_1     = 1'b1;
            clear      = 1'b1;
            src_ready  = 1'b0;
            dest_valid = 1'b1;

            // Transition to DONE state if dest_ready is high
            if (dest_ready) begin
                next_state = DONE;
                en_final   = 1'b1;
            end else begin
                next_state = WAIT;
            end
        end

        DONE: begin
            // Default outputs for DONE state
            en_ac      = 1'b1;
            en_mltd    = 1'b1;
            en_multr   = 1'b1;
            en_count   = 1'b0;
            en_out     = 1'b0;
            en_final   = 1'b0;
            alu_op     = 2'b10;
            selQ       = 1'b1;
            selA       = 1'b1;
            selQ_1     = 1'b1;
            clear      = 1'b1;
            src_ready  = 1'b0;
            dest_valid = 1'b0;

            // Transition back to IDLE state
            next_state = IDLE;
        end

        default: begin
            next_state = IDLE; // Default to IDLE on undefined state
        end
    endcase
end

endmodule
