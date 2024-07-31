module Controller (
    input logic       clk,          // Clock signal
    input logic       rst_n,        // Active-low reset signal
    input logic       start,        // Start signal
    input logic       count_done,   // Count complete signal
    input logic       Q0,           // Input Q0
    input logic       Q_1,           // Input Q1

    output logic      ready,        // Ready signal indicating completion
    output logic      en_multr,     // Enable multiplier
    output logic      en_mltd,      // Enable multiplicand
    output logic      en_count,     // Enable counter
    output logic      en_ac,        // Enable accumulator
    output logic [1:0]alu_op,       // ALU operation code
    output logic      selQ,         // Select Q
    output logic      selA,         // Select A
    output logic      selQ_1,       // Select Q_1
    output logic      en_out,       // Enable output
    output logic      clear         // Clear signal
);

// Define states
typedef enum logic {
    IDLE = 1'b0,  // Idle state
    RUN  = 1'b1   // Run state
} state_t;

state_t current_state, next_state;

// Sequential logic for state transition
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)  begin
        current_state <= IDLE; // Reset to IDLE state
    end
    else begin
        current_state <= next_state; // Transition to next state
    end
end

// Combinational logic for output logic and next state logic
always_comb begin
    case (current_state)
        IDLE: begin
            if (!start) begin
                next_state = IDLE;   // Remain in IDLE state
                en_ac      = 1'b0;   // Disable accumulator
                en_mltd    = 1'b0;   // Disable multiplicand
                en_multr   = 1'b0;   // Disable multiplier
                en_count   = 1'b0;   // Disable counter
                en_out     = 1'b1;   // Enable output
                alu_op     = 2'bxx;  // Undefined ALU operation
                selQ       = 1'bx;   // Undefined Q select
                selA       = 1'bx;   // Undefined A select
                selQ_1     = 1'bx;   // Undefined Q_1 select
                clear      = 1'bx;   // Undefined clear
                ready      = 1'b0;   // Not ready
            end else begin
                next_state = RUN;    // Move to RUN state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b1;   // Enable counter
                en_out     = 1'b1;   // Enable output
                alu_op     = 2'b00;  // ALU operation: no operation
                selQ       = 1'b0;   // Select Q
                selA       = 1'b0;   // Select A
                selQ_1     = 1'b0;   // Select Q_1
                clear      = 1'b0;   // No clear
                ready      = 1'b0;   // Not ready
            end
        end
        RUN: begin
            if (count_done) begin
                if (Q0 & !Q_1) begin
                next_state = IDLE;   // Transition to IDLE state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b1;   // Enable counter
                en_out     = 1'b0;   // Enable output
                alu_op     = 2'b01;  // ALU operation
                selQ       = 1'b1;   // Q select
                selA       = 1'b1;   // A select
                selQ_1     = 1'b1;   // Q_1 select
                clear      = 1'b1;   // Clear signal active
                ready      = 1'b1;   // Ready signal active
                end else if(!Q0 & Q_1) begin
                    next_state = IDLE;   // Transition to IDLE state
                    en_ac      = 1'b1;   // Enable accumulator
                    en_mltd    = 1'b1;   // Enable multiplicand
                    en_multr   = 1'b1;   // Enable multiplier
                    en_count   = 1'b1;   // Enable counter
                    en_out     = 1'b0;   // Enable output
                    alu_op     = 2'b10;  // ALU operation
                    selQ       = 1'b1;   // Q select
                    selA       = 1'b1;   // A select
                    selQ_1     = 1'b1;   // Q_1 select
                    clear      = 1'b1;   // Clear signal active
                    ready      = 1'b1;   // Ready signal active
                end else begin
                    next_state = IDLE;   // Transition to IDLE state
                    en_ac      = 1'b0;   // Disable accumulator
                    en_mltd    = 1'b0;   // Disable multiplicand
                    en_multr   = 1'b0;   // Disable multiplier
                    en_count   = 1'b0;   // Disable counter
                    en_out     = 1'b0;   // Disable output
                    alu_op     = 2'bxx;  // Undefined ALU operation
                    selQ       = 1'bx;   // Undefined Q select
                    selA       = 1'bx;   // Undefined A select
                    selQ_1     = 1'bx;   // Undefined Q_1 select
                    clear      = 1'b1;   // Clear signal active
                    ready      = 1'b1;   // Ready signal active
                end
            end else if((Q0 & Q_1) | (!Q0 & !Q_1)) begin
                next_state = RUN;    // Remain in RUN state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b1;   // Enable counter
                en_out     = 1'b1;   // Enable output
                alu_op     = 2'b00;  // ALU operation: no operation
                selQ       = 1'b1;   // Select Q
                selA       = 1'b1;   // Select A
                selQ_1     = 1'b1;   // Select Q_1
                clear      = 1'b0;   // No clear
                ready      = 1'b0;   // Not ready
            end else if(Q0 & !Q_1) begin
                next_state = RUN;    // Remain in RUN state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b1;   // Enable counter
                en_out     = 1'b1;   // Enable output
                alu_op     = 2'b01;  // ALU operation: subtract
                selQ       = 1'b1;   // Select Q
                selA       = 1'b1;   // Select A
                selQ_1     = 1'b1;   // Select Q_1
                clear      = 1'b0;   // No clear
                ready      = 1'b0;   // Not ready
            end else begin
                next_state = RUN;    // Remain in RUN state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b1;   // Enable counter
                en_out     = 1'b1;   // Enable output
                alu_op     = 2'b10;  // ALU operation: add
                selQ       = 1'b1;   // Select Q
                selA       = 1'b1;   // Select A
                selQ_1     = 1'b1;   // Select Q_1
                clear      = 1'b0;   // No clear
                ready      = 1'b0;   // Not ready
            end
        end
        default: begin
            next_state = IDLE; // Default to IDLE on undefined state
        end
    endcase
end

endmodule
