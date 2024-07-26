module sequential_adder (
    input logic        clk,      // Clock input
    input logic        reset,    // Reset input
    input logic [3:0]  number,   // 4-bit input number
    output logic [3:0] sum       // 4-bit output sum
);

    // Internal shift register to hold intermediate values
    logic [3:0] shift_reg;
    // Control signals for shifting and state transitions
    logic       control_in;
    logic       control_out;
    logic       sum_lsb;
    
    // State registers to hold the current and next state
    logic [1:0] state, next_state;

    // Define state encodings
    parameter IDLE       = 2'b00;
    parameter CHECK_LSB  = 2'b01;
    parameter LSB_0      = 2'b10;
    parameter LSB_1      = 2'b11;

    // Shift register logic: shifts right and initializes with the input number
    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            shift_reg  <= #1 number;   // Initialize shift register with input number on reset
            control_in <= #1 1'b0;     // Initialize control input to 0 on reset
        end else begin
            shift_reg  <= #1 {1'b0, shift_reg[3:1]}; // Shift right with zero-fill
            control_in <= #1 shift_reg[0];           // Update control input with the LSB of shift register
        end
    end

    // Sequential logic for state transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= #1 IDLE;   // Set state to IDLE on reset
        end else begin
            state <= #1 next_state;  // Update state with next state on clock edge
        end
    end

    // Combinational logic for next state and output
    always_comb begin
        // Default assignments to avoid latches
        next_state  = state;
        control_out = 1'b0;
        
        case (state)
            IDLE: begin
                next_state = CHECK_LSB;  // Move to CHECK_LSB state from IDLE
            end
            CHECK_LSB: begin
                if (control_in) begin
                    next_state  = LSB_1;  // Transition to LSB_1 if control_in is 1
                    control_out = 1'b0;   // Set control_out to 0
                end else begin
                    control_out = 1'b1;   // Set control_out to 1
                    next_state  = LSB_0;  // Transition to LSB_0 if control_in is 0
                end
            end
            LSB_0: begin
                if (control_in) begin
                    next_state  = LSB_0;  // Remain in LSB_0 if control_in is 1
                    control_out = 1'b1;   // Set control_out to 1
                end else begin
                    next_state  = LSB_0;  // Remain in LSB_0 if control_in is 0
                    control_out = 1'b0;   // Set control_out to 0
                end
             end
            LSB_1: begin
                if (control_in) begin
                    next_state  = LSB_1;  // Remain in LSB_1 if control_in is 1
                    control_out = 1'b0;   // Set control_out to 0
                end else begin
                    next_state  = LSB_0;  // Transition to LSB_0 if control_in is 0
                    control_out = 1'b1;   // Set control_out to 1
                end
            end
            default: begin
                next_state  = IDLE;  // Default to IDLE in case of unknown state
                control_out = 1'b0;  // Set control_out to 0
            end
        endcase
    end
    assign sum_lsb = control_out; 
    // Update sum register with control_out
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            sum <= #1 4'b0000;  // Initialize sum to 0 on reset
        end else begin
            sum <= #1 {sum[2:0], control_out};  // Shift sum left and insert control_out bit at the LSB
        end
    end

endmodule
