module seq_adder_inverter_logic (
    input logic clk,
    input logic reset,
    input logic bit_in,
    output logic bit_out
);

    typedef enum logic [1:0] {
        S0, // Initial state, processing first bit
        S1, // Processing second bit
        S2, // Processing third bit
        S3  // Processing fourth bit
    } state_t;

    state_t current_state, next_state;
    logic first_zero_detected;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= #1 S0;
            first_zero_detected <= #1 1'b0;
        end else begin
            current_state <= #1 next_state;
            if (next_state == S0) begin
                first_zero_detected <= #1 1'b0;
            end else if (!first_zero_detected && bit_in == 1'b0) begin
                first_zero_detected <= #1 1'b1;
            end
        end
    end

    always_comb begin
        case (current_state)
            S0: begin
                bit_out = first_zero_detected ? bit_in : ~bit_in;
                next_state = S1;
            end
            S1: begin
                bit_out = first_zero_detected ? bit_in : ~bit_in;
                next_state = S2;
            end
            S2: begin
                bit_out = first_zero_detected ? bit_in : ~bit_in;
                next_state = S3;
            end
            S3: begin
                bit_out = first_zero_detected ? bit_in : ~bit_in;
                next_state = S0;
            end
        endcase
    end

endmodule

