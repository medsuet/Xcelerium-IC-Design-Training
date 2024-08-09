module Control_Unit(
    input logic clk,
    input logic reset,
    input logic src_valid,
    input logic dst_ready,
    input logic [32:0] regA_next,
    input logic [5:0] count,
    output logic enReg,
    output logic enCount,
    output logic enShift,
    output logic dst_valid,
    output logic src_ready,
    output logic mux_sel,
    output logic clear
);

    typedef enum logic [1:0] {IDLE, CALC, WAIT} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        enReg = 0;
        enCount = 0;
        enShift = 0;
        mux_sel = 0;
        src_ready = 0;
        dst_valid = 0;
        clear = 0;
        next_state = state;

        case (state)
            IDLE: begin 
                src_ready = 1;
                if (src_valid) begin
                    enReg = 1;
                    next_state = CALC;
                end
                else begin
                    next_state=IDLE;
                end
            end 
            CALC: begin
                src_ready = 0;
                enShift = 1;
                enCount = 1;
                mux_sel = regA_next[32];
                if (count == 32) begin
                    clear = 1;
                    dst_valid = 1;
                    next_state = WAIT;
                end
            end
            WAIT: begin
                if (dst_ready) begin
                    next_state = IDLE;
                end else begin
                    dst_valid = 1;
                    next_state = WAIT;
                end
            end
        endcase
    end

endmodule
