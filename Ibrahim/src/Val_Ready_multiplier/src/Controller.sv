module Controller (
    input logic       clk,          // Clock signal
    input logic       rst_n,        // Active-low reset signal
    input logic       src_valid,        // Start signal
    input logic       dest_ready,
    input logic       count_done,   // Count complete signal
    input logic       Q0,           // Input Q0
    input logic       Q_1,           // Input Q1

    output logic      src_ready,        // Ready signal indicating completion
    output logic      dest_valid,
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
typedef enum logic[1:0]{
    IDLE = 2'b00,  // Idle state
    RUN  = 2'b01,  // Run state
    WAIT = 2'b10,
    DONE = 2'b11
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
            if (!src_valid) begin
                next_state     = IDLE;   // Remain in IDLE state
                en_ac          = 1'b0;   // Disable accumulator
                en_mltd        = 1'b0;   // Disable multiplicand
                en_multr       = 1'b0;   // Disable multiplier
                en_count       = 1'b0;   // Disable counter
                en_out         = 1'b0;   // Enable output
                alu_op         = 2'b00;  // Undefined ALU operation
                selQ           = 1'b0;   // Undefined Q select
                selA           = 1'b0;   // Undefined A select
                selQ_1         = 1'b0;   // Undefined Q_1 select
                clear          = 1'b0;   // Undefined clear
                src_ready      = 1'b1;   
                dest_valid     = 1'b0;
            end else begin
                next_state = RUN;    // Move to RUN state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b1;   // Enable counter
                en_out     = 1'b0;   // Enable output
                alu_op     = 2'b00;  // ALU operation: no operation
                selQ       = 1'b0;   // Select Q
                selA       = 1'b0;   // Select A
                selQ_1     = 1'b0;   // Select Q_1
                clear      = 1'b0;   // No clear
                src_ready      = 1'b1;   
                dest_valid     = 1'b0;
            end
        end
        RUN: begin
            if (count_done) begin
                if (Q0 & !Q_1) begin
                next_state = WAIT;   // Transition to WAIT state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b0;   // Enable counter
                en_out     = 1'b1;   // Enable output
                alu_op     = 2'b01;  // ALU operation
                selQ       = 1'b1;   // Q select
                selA       = 1'b1;   // A select
                selQ_1     = 1'b1;   // Q_1 select
                clear      = 1'b1;   // Clear signal active
                src_ready      = 1'b0;   
                dest_valid     = 1'b1;
                end else if(!Q0 & Q_1) begin
                    next_state = WAIT;   // Transition to WAIT state
                    en_ac      = 1'b1;   // Enable accumulator
                    en_mltd    = 1'b1;   // Enable multiplicand
                    en_multr   = 1'b1;   // Enable multiplier
                    en_count   = 1'b0;   // Enable counter
                    en_out     = 1'b1;   // Enable output
                    alu_op     = 2'b10;  // ALU operation
                    selQ       = 1'b1;   // Q select
                    selA       = 1'b1;   // A select
                    selQ_1     = 1'b1;   // Q_1 select
                    clear      = 1'b1;   // Clear signal active
                    src_ready  = 1'b0;   
                    dest_valid = 1'b1;
                end else begin
                    next_state = WAIT;   // Transition to WAIT state
                    en_ac      = 1'b0;   // Disable accumulator
                    en_mltd    = 1'b0;   // Disable multiplicand
                    en_multr   = 1'b0;   // Disable multiplier
                    en_count   = 1'b0;   // Disable counter
                    en_out     = 1'b1;   
                    alu_op     = 2'b00;  // Undefined ALU operation
                    selQ       = 1'b1;   // Undefined Q select
                    selA       = 1'b1;   // Undefined A select
                    selQ_1     = 1'b1;   // Undefined Q_1 select
                    clear      = 1'b1;   // Clear signal active
                    src_ready      = 1'b0;   
                dest_valid     = 1'b1;
                end
            end else if((Q0 & Q_1) | (!Q0 & !Q_1)) begin
                next_state = RUN;    // Remain in RUN state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b1;   // Enable counter
                en_out     = 1'b0;   
                alu_op     = 2'b00;  // ALU operation: no operation
                selQ       = 1'b1;   // Select Q
                selA       = 1'b1;   // Select A
                selQ_1     = 1'b1;   // Select Q_1
                clear      = 1'b0;   // No clear
                src_ready  = 1'b0;   
                dest_valid = 1'b0;
            end else if(Q0 & !Q_1) begin
                next_state = RUN;    // Remain in RUN state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b1;   // Enable counter
                en_out     = 1'b0;   
                alu_op     = 2'b01;  // ALU operation: subtract
                selQ       = 1'b1;   // Select Q
                selA       = 1'b1;   // Select A
                selQ_1     = 1'b1;   // Select Q_1
                clear      = 1'b0;   // No clear
                src_ready      = 1'b0;   
                dest_valid     = 1'b0;
            end else begin
                next_state = RUN;    // Remain in RUN state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b1;   // Enable counter
                en_out     = 1'b0;   
                alu_op     = 2'b10;  // ALU operation: 
                selQ       = 1'b1;   // Select Q
                selA       = 1'b1;   // Select A
                selQ_1     = 1'b1;   // Select Q_1
                clear      = 1'b0;   // No clear
                src_ready      = 1'b0;   
                dest_valid     = 1'b0;
            end
        end
        WAIT: begin
            if(!dest_ready) begin
                next_state = WAIT;    // Remain in RUN state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b0;   // Enable counter
                en_out     = 1'b0;   
                alu_op     = 2'b10;  // ALU operation: 
                selQ       = 1'b1;   // Select Q
                selA       = 1'b1;   // Select A
                selQ_1     = 1'b1;   // Select Q_1
                clear      = 1'b1;   
                src_ready      = 1'b0;   
                dest_valid     = 1'b1;
            end else begin
                next_state = DONE;    // Remain in RUN state
                en_ac      = 1'b1;   // Enable accumulator
                en_mltd    = 1'b1;   // Enable multiplicand
                en_multr   = 1'b1;   // Enable multiplier
                en_count   = 1'b0;   // Enable counter
                en_out     = 1'b0;   
                alu_op     = 2'b10;  // ALU operation: 
                selQ       = 1'b1;   // Select Q
                selA       = 1'b1;   // Select A
                selQ_1     = 1'b1;   // Select Q_1
                clear      = 1'b1;   
                src_ready  = 1'b0;   
                dest_valid = 1'b1;
            end
        end
        DONE: begin
            next_state = IDLE;    // Remain in RUN state
            en_ac      = 1'b1;   // Enable accumulator
            en_mltd    = 1'b1;   // Enable multiplicand
            en_multr   = 1'b1;   // Enable multiplier
            en_count   = 1'b0;   // Enable counter
            en_out     = 1'b0;   
            alu_op     = 2'b10;  // ALU operation: 
            selQ       = 1'b1;   // Select Q
            selA       = 1'b1;   // Select A
            selQ_1     = 1'b1;   // Select Q_1
            clear      = 1'b1;   
            src_ready      = 1'b0;   
            dest_valid     = 1'b0;
        end

        default: begin
            next_state = IDLE; // Default to IDLE on undefined state
        end
    endcase
end

endmodule
