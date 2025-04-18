module controller (
    input logic clk,           // Clock signal
    input logic rst_n,         // Asynchronous active-low reset
    input logic start,         // Start signal
    input logic cmp,           // Compare signal
    output logic reset,        // Reset signal
    output logic enA, enB, enAA, enBB, // Enable signals
    output logic M1_sel, M2_sel, M3_sel,enP, // Multiplexer select signals
    output logic ready         // Ready signal
);

    // State encoding
    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S3_WAIT = 3'b100 // Intermediate wait state
    } state_t;

    state_t current_state, next_state;

    // State transition
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S0: if (start) next_state = S1;
                else next_state = S0;
            S1: if (!start) next_state = S2;
                else next_state = S1;
            S2: if (cmp) next_state = S3;
                else next_state = S2;
            S3: next_state = S3_WAIT; // Transition to wait state
            S3_WAIT: next_state = S0; // Transition back to S0 after wait
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_comb begin
        // Default values
        reset = 1;
        enA = 0;
        enB = 0;
        enAA = 0;
        enBB = 0;
        M1_sel = 0;
        M2_sel = 0;
        M3_sel = 0;
        ready = 0;

        case (current_state)
            S0: begin
                enA = 1;
                enB = 1;
            end
            S1: begin
                enA = 1;
                enB = 1;
                enAA = 1;
                enBB = 1;
                M1_sel = 1;
                M2_sel = 1;
                M3_sel = 0;
                enP = 1;
                ready = 0;
            end
            S2: begin
                enA = 0;
                enB = 0;
                enAA = 1;
                enBB = 1;
                M1_sel = 0;
                M2_sel = 0;
                M3_sel = 0;
                enP = 1;
                ready = 0;
            end
            S3: begin
                enA = 0;
                enB = 0;
                enAA = 0;
                enBB = 0;
                M3_sel = 1;
                enP = 1;
                ready = 0;
            end
            S3_WAIT: begin
                // Keep outputs same as S3 or set to default
                enA = 0;
                enB = 0;
                enAA = 0;
                enBB = 0;
                M3_sel = 0;
                enP = 0;
                ready = 1;
            end
        endcase
    end
endmodule

