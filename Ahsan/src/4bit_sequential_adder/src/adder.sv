module serial_adder (
    input logic clk,
    input logic reset,
    input logic start,
    input logic [3:0] A,
    input logic [3:0] B,
    output logic [3:0] sum,
    output logic done
);

    // State parameters
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    logic [2:0] current_state, next_state;
    logic carry, carry_next;
    logic [3:0] shift_register;

    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= S0;
            carry <= 0;
            shift_register <= 0;
            done <= 0;
        end else begin
            current_state <= next_state;
            carry <= carry_next;
           
        end
    end

    // Next state logic and output logic
    always@(*) begin
        next_state = current_state;
        carry_next = carry;
        done = 0;

        case (current_state)
            S0: begin
                if (start) begin
                    next_state = S1;
                    shift_register = 0;
                    carry_next = 0;
                end
            end
            S1: begin
                {carry_next, shift_register[0]} = B[0] + A[0];
                next_state = S2;
            end
            S2: begin
                {carry_next, shift_register[1]} = B[1] + carry;
                next_state = S3;
            end
            S3: begin
                {carry_next, shift_register[2]} = B[2] + carry;
                next_state = S4;
            end
            S4: begin
                {carry_next, shift_register[3]} = B[3] + carry;
                next_state = S0;
                done = 1;
            end
            default: next_state = S0;
        endcase
    end

    always @* begin
        if (done)
            sum = shift_register;
        else
            sum = 4'b0;
    end


endmodule
