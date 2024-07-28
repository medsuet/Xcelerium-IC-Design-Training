module seq_adder_4bit(
    input  logic clk,
    input  logic reset,
    input  logic [3:0] number,
    output logic out      
);

    // Define state constants using parameters
    parameter IDLE = 3'b000, LSB = 3'b001, CARRY0_BIT1   = 3'b010, CARRY1_BIT1   = 3'b011, CARRY0_BIT2   = 3'b100;
    parameter CARRY1_BIT2   = 3'b101, CARRY0_BIT3   = 3'b110, CARRY1_BIT3   = 3'b111;

    logic [2:0] state, next_state;
    logic in;    // Holds the input bit being processed

    // Sequential circuit state register
    always_ff @(posedge clk or posedge reset) 
    begin
        if (reset) 
        begin
            state <= #1 IDLE;  
        end 
        else 
        begin
            state <= #1 next_state;
        end
    end

    // Combinational circuit for state transitions and output logic
    always_comb 
    begin
        case (state)
            IDLE: // start the states
            begin
                next_state = LSB; // Move to CHECK_LSB state
            end

            LSB: 
            begin
                in = number[0]; // Check the LSB of the input
                if (in) 
                begin
                    next_state = CARRY1_BIT1; // Move to CARRY1_BIT1 if LSB is 1
                    out = 1'b0;               // Set output to 0 in this state
                end 
                else 
                begin
                    next_state = CARRY0_BIT1; // Move to CARRY0_BIT1 if LSB is 0
                    out = 1'b1;               // Set output to 1 in this state
                end
            end

            CARRY0_BIT1: 
            begin
                in = number[1]; // Check the second bit of the input
                if (in) 
                begin
                    next_state = CARRY0_BIT2; // Move to CARRY0_BIT2 if bit is 1
                    out = 1'b1;               // Set output to 1
                end 
                else 
                begin
                    next_state = CARRY0_BIT2; // Remain in the same state
                    out = 1'b0;               // Set output to 0
                end
            end

            CARRY1_BIT1: 
            begin
                in = number[1]; // Check the second bit of the input
                if (in) 
                begin
                    next_state = CARRY1_BIT2; // Move to CARRY1_BIT2 if bit is 1
                    out = 1'b0;               // Set output to 0
                end 
                else 
                begin
                    next_state = CARRY0_BIT2; // Resolve carry
                    out = 1'b1;               // Set output to 1
                end
            end

            CARRY0_BIT2: 
            begin
                in = number[2]; // Check the third bit of the input
                if (in) 
                begin
                    next_state = CARRY0_BIT3; // Move to CARRY0_BIT3 if bit is 1
                    out = 1'b1;               // Set output to 1
                end 
                else 
                begin
                    next_state = CARRY0_BIT3; // Remain in the same state
                    out = 1'b0;               // Set output to 0
                end
            end

            CARRY1_BIT2: 
            begin
                in = number[2]; // Check the third bit of the input
                if (in) 
                begin
                    next_state = CARRY1_BIT3; // Move to CARRY1_BIT3 if bit is 1
                    out = 1'b0;               // Set output to 0
                end 
                else 
                begin
                    next_state = CARRY0_BIT3; // Resolve carry
                    out = 1'b1;               // Set output to 1
                end
            end

            CARRY0_BIT3: 
            begin
                in = number[3]; // Check the fourth bit of the input
                if (in) 
                begin
                    next_state = LSB; // Return to CHECK_LSB
                    out = 1'b1;             // Set output to 1
                end 
                else 
                begin
                    next_state = LSB; // Return to CHECK_LSB
                    out = 1'b0;             // Set output to 0
                end
            end

            CARRY1_BIT3:
            begin
                in = number[3]; // Check the fourth bit of the input
                if (in) 
                begin
                    next_state = LSB; // Return to CHECK_LSB
                    out = 1'b0;             // Set output to 0
                end 
                else 
                begin
                    next_state = LSB; // Return to CHECK_LSB
                    out = 1'b1;             // Set output to 1
                end
            end

            default: 
            begin
                next_state = IDLE; // Default to IDLE state
                in = 1'b0;
                out = 1'b0;        // Default output to 0
            end
        endcase
    end

endmodule
