/* verilator lint_off LATCH */

module sequential_adder (
    input logic        clk,       // Clock input
    input logic        reset,     // Reset input
    input logic [3:0]  number,    // 4-bit input number
    output logic       output_lsb // Single bit output
);

    // Control signal for shifting and state transitions
    logic control_in;
    
    // State encoding for the finite state machine (FSM)
    typedef enum logic [2:0] {
        IDLE       = 3'd0, // IDLE state
        LSB        = 3'd1, // State to check the least significant bit (LSB)
        LSB_0      = 3'd2, // State for LSB being 0
        LSB_1      = 3'd3, // State for LSB being 1
        CARRY_01   = 3'd4, // State for handling carry when LSB was 0 or next bit was 1 or 0
        CARRY_11   = 3'd5, // State for handling carry when LSB was 1 and next bit was 1
        CARRY_02   = 3'd6, // State for handling carry when carry_01 was 0 or 1 and carry_11 was 0
        CARRY_12   = 3'd7  // State for handling carry when carry_11 was 1 
    } state_t;

    state_t state, next_state; // State variables

    // Sequential logic for state transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;   // Set state to IDLE on reset
        end else begin
            state <= next_state;  // Update state with next state on clock edge
        end
    end

    // Combinational logic for next state and output
    always_comb begin
        case (state)
            IDLE: begin
                next_state = LSB;  // Move to LSB state from IDLE
            end
            LSB: begin
                control_in = number[0];   // Set control_in to the least significant bit of number
                if(control_in) begin
                    next_state  = LSB_1;  // Move to LSB_1 state if control_in is 1
                    output_lsb  = 1'b0;   // Set output_lsb to 0
                end else begin
                    next_state  = LSB_0;  // Move to LSB_0 state if control_in is 0
                    output_lsb  = 1'b1;   // Set output_lsb to 1
                end
            end
            LSB_0: begin
                control_in = number[1];  // Set control_in to the next bit of number
                next_state = CARRY_01;   // Move to CARRY_01 state
                output_lsb = control_in; // Set output_lsb to control_in
            end
            LSB_1: begin
                control_in = number[1];   // Set control_in to the next bit of number
                if (control_in) begin
                    next_state  = CARRY_11;  // Move to CARRY_11 state if control_in is 1
                    output_lsb  = 1'b0;      // Set output_lsb to 0
                end else begin
                    next_state  = CARRY_01;  // Move to CARRY_01 state if control_in is 0
                    output_lsb  = 1'b1;      // Set output_lsb to 1
                end
             end
            CARRY_01: begin
                control_in = number[2];  // Set control_in to the next bit of number
                next_state = CARRY_02;   // Move to CARRY_02 state
                output_lsb = control_in; // Set output_lsb to control_in
            end
            CARRY_11: begin
                control_in = number[2]; // Set control_in to the next bit of number
                if(control_in) begin
                    next_state  = CARRY_12;  // Move to CARRY_12 state if control_in is 1
                    output_lsb  = 1'b0;      // Set output_lsb to 0
                end else begin
                    next_state  = CARRY_02;  // Move to CARRY_02 state if control_in is 0
                    output_lsb  = 1'b1;      // Set output_lsb to 1
                end
            end
            CARRY_02: begin
                control_in = number[3];  // Set control_in to the most significant bit (MSB) of number
                next_state = LSB;        // Move to LSB state
                output_lsb = control_in; // Set output_lsb to control_in
            end
            CARRY_12: begin
                control_in = number[3];   // Set control_in to the MSB of number
                next_state = LSB;         // Move to LSB state
                output_lsb = ~control_in; // Set output_lsb to the inverse of control_in
            end

            default: begin
                control_in = number[0]; // Default control_in to the LSB of number
                next_state = LSB;       // Default to LSB state in case of unknown state
                output_lsb = 1'b0;      // Set output_lsb to 0
            end
        endcase
    end

endmodule

/* verilator lint_on LATCH */
