module sequential_adder (
    input logic        clk,
    input logic        reset,
    input logic [3:0]  number,
    output logic [3:0] sum
);
    logic [3:0] shift_reg;
    logic       input_LSB;
    logic       output_LSB;
    
    // State registers
    logic [1:0] state, next_state;

    // Define state encodings
    parameter IDLE       = 2'b00;
    parameter CHECK_LSB      = 2'b01;
    parameter LSB_0      = 2'b10;
    parameter LSB_1 = 2'b11;

    // Sequential logic for state transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= #1 IDLE;
        end else begin
            state <= #1 next_state;
        end
    end

    // Combinational logic for next state and output
    always_comb begin
        case (state)
            IDLE: begin
                next_state = CHECK_LSB;
            end
            CHECK_LSB: begin
                if (input_LSB) begin
                    next_state  = LSB_1;  // Transition to S1   
                    output_LSB = 1'b0;
                end else begin
                    next_state  = LSB_0;  // Stay in S0
                    output_LSB = 1'b1;
                end
            end
            LSB_0: begin
                if (input_LSB) begin
                    next_state  = LSB_0;  // Transition to S1
                    output_LSB = 1'b1;
                end else begin
                    next_state  = LSB_0;
                    output_LSB = 1'b0;  
                end
             end
            LSB_1: begin
                if (input_LSB) begin
                    next_state  = LSB_1;  // Transition to S1
                    output_LSB = 1'b0;
                end else begin
                    next_state  = LSB_0;  // Stay in S0
                    output_LSB = 1'b1;
                end
            end
            default: begin
                next_state  = IDLE;  // Default to S0 in case of unknown state
                output_LSB = 1'b0;
            end
        endcase
    end

    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            shift_reg  <= #1 number;
            input_LSB <= #1 1'b0;
        end
        else begin
            shift_reg  <= #1 {1'b0, shift_reg[3:1]};
            input_LSB <= #1 shift_reg[0];
        end
    end

    // Update sum register with output_LSB
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            sum <= #1 4'b0000; 
        end else begin
            // Shift sum left and insert output_LSB bit at the LSB
            sum <= #1 {sum[2:0], output_LSB};
        end
    end

endmodule