module sequential_adder(
    input  logic clk,
    input  logic reset,
    input  logic [3:0] num,  // 4-bit input data
    output logic out      
);

    // Define state constants using parameters
    parameter IDLE          = 3'b000;  // Idle state before operation starts
    parameter CHECK_LSB     = 3'b001;  // Initial state to check the LSB
    parameter CARRY0_BIT1   = 3'b010;  // State for Carry0 and processing Bit1
    parameter CARRY1_BIT1   = 3'b011;  // State for Carry1 and processing Bit1
    parameter CARRY0_BIT2   = 3'b100;  // State for Carry0 and processing Bit2
    parameter CARRY1_BIT2   = 3'b101;  // State for Carry1 and processing Bit2
    parameter CARRY0_BIT3   = 3'b110;  // State for Carry0 and processing Bit3
    parameter CARRY1_BIT3   = 3'b111;  // State for Carry1 and processing Bit3

    logic [2:0] state, next_state;
    logic in;    // Holds the input bit being processed

    // Sequential logic for state transition and register updates
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= #1 IDLE;  
        end else begin
            state <= #1 next_state;
        end
    end

    // Combinational logic for state transitions and output logic
    always_comb begin
        case (state)
            IDLE: begin
                next_state = CHECK_LSB; // Move to CHECK_LSB state
            end

            CHECK_LSB: begin
                in = num[0]; // Check the LSB of the input
                if (in) begin
                    next_state = CARRY1_BIT1; // Move to CARRY1_BIT1 if LSB is 1
                    out = 1'b0;               // Set output to 0 in this state
                end else begin
                    next_state = CARRY0_BIT1; // Move to CARRY0_BIT1 if LSB is 0
                    out = 1'b1;               // Set output to 1 in this state
                end
            end

            CARRY0_BIT1: begin
                in = num[1]; // Check the second bit of the input
                if (in) begin
                    next_state = CARRY0_BIT2; // Move to CARRY0_BIT2 if bit is 1
                    out = 1'b1;               // Set output to 1
                end else begin
                    next_state = CARRY0_BIT2; // Remain in the same state
                    out = 1'b0;               // Set output to 0
                end
            end

            CARRY1_BIT1: begin
                in = num[1]; // Check the second bit of the input
                if (in) begin
                    next_state = CARRY1_BIT2; // Move to CARRY1_BIT2 if bit is 1
                    out = 1'b0;               // Set output to 0
                end else begin
                    next_state = CARRY0_BIT2; // Resolve carry
                    out = 1'b1;               // Set output to 1
                end
            end

            CARRY0_BIT2: begin
                in = num[2]; // Check the third bit of the input
                if (in) begin
                    next_state = CARRY0_BIT3; // Move to CARRY0_BIT3 if bit is 1
                    out = 1'b1;               // Set output to 1
                end else begin
                    next_state = CARRY0_BIT3; // Remain in the same state
                    out = 1'b0;               // Set output to 0
                end
            end

            CARRY1_BIT2: begin
                in = num[2]; // Check the third bit of the input
                if (in) begin
                    next_state = CARRY1_BIT3; // Move to CARRY1_BIT3 if bit is 1
                    out = 1'b0;               // Set output to 0
                end else begin
                    next_state = CARRY0_BIT3; // Resolve carry
                    out = 1'b1;               // Set output to 1
                end
            end

            CARRY0_BIT3: begin
                in = num[3]; // Check the fourth bit of the input
                if (in) begin
                    next_state = CHECK_LSB; // Return to CHECK_LSB
                    out = 1'b1;             // Set output to 1
                end else begin
                    next_state = CHECK_LSB; // Return to CHECK_LSB
                    out = 1'b0;             // Set output to 0
                end
            end

            CARRY1_BIT3: begin
                in = num[3]; // Check the fourth bit of the input
                if (in) begin
                    next_state = CHECK_LSB; // Return to CHECK_LSB
                    out = 1'b0;             // Set output to 0
                end else begin
                    next_state = CHECK_LSB; // Return to CHECK_LSB
                    out = 1'b1;             // Set output to 1
                end
            end

            default: begin
                next_state = IDLE; // Default to IDLE state
                in = 1'b0;
                out = 1'b0;        // Default output to 0
            end
        endcase
    end

endmodule
