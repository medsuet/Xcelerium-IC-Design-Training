module binary_adder(
    input logic clk,           // Clock signal
    input logic reset,         // Reset signal
    input logic increment,     // Increment signal
    output logic [3:0] count   // 4-bit counter output
);

    // Define state parameters
    parameter IDLE = 2'b00;
    parameter CHECK_LSB = 2'b01;
    parameter PROPAGATE_CARRY = 2'b10;
    parameter WRAP_AROUND = 2'b11;

    // Internal signals
    logic [1:0] state, next_state;
    logic carry;
    logic [3:0] next_count;

    // State and count update
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'b0000;
        end else begin
            state <= next_state;
            count <= next_count;
        end
    end

    // State transition logic
    always_comb begin
        case (state)
            IDLE: begin
                if (increment) begin
                    next_state = CHECK_LSB;
                end else begin
                    next_state = IDLE;
                end
            end

            CHECK_LSB: begin
                if (count[0] == 1'b0) begin
                    next_state = IDLE;
                end else begin
                    next_state = PROPAGATE_CARRY;
                end
            end

            PROPAGATE_CARRY: begin
                if (carry) begin
                    if (count == 4'b1111) begin
                        next_state = WRAP_AROUND;
                    end else begin
                        next_state = PROPAGATE_CARRY;
                    end
                end else begin
                    next_state = IDLE;
                end
            end

            WRAP_AROUND: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Signal transition logic
    always_comb begin
        next_count = count;
        carry = 1'b0;

        case (state)
            IDLE: begin
                // No changes needed in IDLE state for count
            end

            CHECK_LSB: begin
                if (increment) begin
                    if (count[0] == 1'b0) begin
                        next_count[0] = 1'b1;
                    end else begin
                        next_count[0] = 1'b0;
                        carry = 1'b1;
                    end
                end
            end

            PROPAGATE_CARRY: begin
                if (carry) begin
                    if (count[1] == 1'b0) begin
                        next_count[1] = 1'b1;
                        carry = 1'b0;
                    end else begin
                        next_count[1] = 1'b0;
                        carry = 1'b1;
                    end

                    if (count[2] == 1'b0) begin
                        next_count[2] = 1'b1;
                        carry = 1'b0;
                    end else begin
                        next_count[2] = 1'b0;
                        carry = 1'b1;
                    end

                    if (count[3] == 1'b0) begin
                        next_count[3] = 1'b1;
                        carry = 1'b0;
                    end else begin
                        next_count[3] = 1'b0;
                        carry = 1'b1;
                    end
                end
            end

            WRAP_AROUND: begin
                next_count = 4'b0000;  // Reset count to 0
            end

            default: begin
                next_count = count;
            end
        endcase
    end

endmodule
