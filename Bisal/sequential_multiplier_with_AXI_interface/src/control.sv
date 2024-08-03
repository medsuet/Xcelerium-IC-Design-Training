module Control_Unit(
    input logic clk,
    input logic reset,
    input logic src_valid,
    input logic dst_ready,
    input logic [3:0] count,
    output logic enReg,
    output logic enCount,
    output logic enShift,
    output logic dst_valid,
    output logic src_ready
);

    typedef enum logic [1:0] {IDLE,START, CALC, WAIT} state_t;
    state_t state, next_state;

    always_ff @(posedge clk /*or posedge reset*/) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        enReg = 0;
        enCount = 0;
        enShift = 0;
        src_ready=0;
        dst_valid=0;
        next_state = state;

        case (state)
            IDLE: begin
                src_ready=1;
                next_state=START;
            end 
            START: begin
                if (src_valid) begin 
                    enReg = 1;
                    next_state = CALC;
                end
            end
            CALC: begin
                if (count == 15) begin        
                    enShift = 0;
                    enCount = 0;
                    dst_valid = 1;
                    if (dst_ready) begin
                        dst_valid=1;
                        next_state = IDLE;
                    end else begin
                        next_state = WAIT;
                    end
                end
                else begin
                    enShift = 1;
                    enCount=1;
                    next_state = CALC;
                end
            end
            WAIT: begin
                if(dst_ready) begin
                    dst_valid=1;
                    next_state=IDLE;
                end
            end
        endcase
    end

endmodule


