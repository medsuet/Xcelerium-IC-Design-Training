module Controller (
    input logic       clk,          // Clock signal
    input logic       rst_n,        // Active-low reset signal
    input logic       start,        // Start signal
    input logic       count_done,   // Count complete signal
    input logic       Q0,           // Input Q0
    input logic       Q_1,           // Input Q1

    output logic      ready,
    output logic      en_multr, 
    output logic      en_mltd, 
    output logic      en_count, 
    output logic      en_ac,
    output logic [1:0]alu_op,
    output logic      selQ, 
    output logic      selA,
    output logic      selQ_1, 
    output logic      en_out,
    output logic      clear
);

// Define states
typedef enum logic {
    IDLE = 1'b0,
    RUN  = 1'b1
} state_t;

state_t current_state, next_state;

// Sequential logic for state transition
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)  begin
        current_state <= IDLE;
    end
    else begin
        current_state <= next_state;
    end
end

// Combinational logic for output logic and next state logic
always_comb begin
    case (current_state)
        IDLE: begin
            if (!start) begin
                next_state = IDLE;
                en_ac      = 1'b0;
                en_mltd    = 1'b0;
                en_multr   = 1'b0;
                en_count   = 1'b0;
                en_out     = 1'b1;
                alu_op     = 2'bxx;
                selQ       = 1'bx;
                selA       = 1'bx;
                selQ_1     = 1'bx;
                clear      = 1'bx;
                ready      = 1'b0;
            end else begin
                next_state = RUN;
                en_ac      = 1'b1;
                en_mltd    = 1'b1;
                en_multr   = 1'b1;
                en_count   = 1'b1;
                en_out     = 1'b1;
                alu_op     = 2'b00;
                selQ       = 1'b0;
                selA       = 1'b0;
                selQ_1     = 1'b0;
                clear      = 1'b0;
                ready      = 1'b0;
            end

            // else if((Q0 && Q_1) || (Q0 && Q_1)) begin
            //     next_state = RUN;
            //     en_ac      = 1'b1;
            //     en_mltd    = 1'b1;
            //     en_multr   = 1'b1;
            //     en_count   = 1'b1;
            //     en_out     = 1'b1;
            //     alu_op     = 2'b00;
            //     selQ       = 1'b0;
            //     selQ_1     = 1'b0;
            //     clear      = 1'b0;
            //     ready      = 1'b0;
            // end else if (Q0 && !Q_1) begin
            //     next_state = RUN;
            //     en_ac      = 1'b1;
            //     en_mltd    = 1'b1;
            //     en_multr   = 1'b1;
            //     en_count   = 1'b1;
            //     en_out     = 1'b1;
            //     alu_op     = 2'b01;
            //     selQ       = 1'b0;
            //     selQ_1     = 1'b0;
            //     clear      = 1'b0;
            //     ready      = 1'b0;
            // end else begin
            //     next_state = RUN;
            //     en_ac      = 1'b1;
            //     en_mltd    = 1'b1;
            //     en_multr   = 1'b1;
            //     en_count   = 1'b1;
            //     en_out     = 1'b1;
            //     alu_op     = 2'b10;
            //     selQ       = 1'b0;
            //     selQ_1     = 1'b0;
            //     clear      = 1'b0;
            //     ready      = 1'b0;
            // end
        end
        RUN: begin
            if (count_done) begin
                next_state = IDLE;
                en_ac      = 1'b0;
                en_mltd    = 1'b0;
                en_multr   = 1'b0;
                en_count   = 1'b0;
                en_out     = 1'b0;
                alu_op     = 2'bxx;
                selQ       = 1'bx;
                selA       = 1'bx;
                selQ_1     = 1'bx;
                clear      = 1'b1;
                ready      = 1'b1;
            end else if((Q0 & Q_1) | (Q0 & Q_1)) begin
                next_state = RUN;
                en_ac      = 1'b1;
                en_mltd    = 1'b1;
                en_multr   = 1'b1;
                en_count   = 1'b1;
                en_out     = 1'b1;
                alu_op     = 2'b00;
                selQ       = 1'b1;
                selA       = 1'b1;
                selQ_1     = 1'b1;
                clear      = 1'b0;
                ready      = 1'b0;
            end else if(Q0 & !Q_1) begin
                next_state = RUN;
                en_ac      = 1'b1;
                en_mltd    = 1'b1;
                en_multr   = 1'b1;
                en_count   = 1'b1;
                en_out     = 1'b1;
                alu_op     = 2'b01;
                selQ       = 1'b1;
                selA       = 1'b1;
                selQ_1     = 1'b1;
                clear      = 1'b0;
                ready      = 1'b0;
            end else begin
                next_state = RUN;
                en_ac      = 1'b1;
                en_mltd    = 1'b1;
                en_multr   = 1'b1;
                en_count   = 1'b1;
                en_out     = 1'b1;
                alu_op     = 2'b10;
                selQ       = 1'b1;
                selA       = 1'b1;
                selQ_1     = 1'b1;
                clear      = 1'b0;
                ready      = 1'b0;
            end
        end
        default: begin
            next_state = IDLE; // Default to IDLE on undefined state
        end
    endcase
end

endmodule
