
module control_unit (
    input  logic clk,   
    input  logic rst,   
    input  logic start, 
    input  logic done,          
    output logic load,        
    output logic calc        
);


    //Initializing the states
    typedef enum logic [2:0] {
        IDLE,  
        CALC
    } state_t;
    state_t state, next_state;
    

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        //some signals
        load = 0;
        calc = 0;
        case (state)
            IDLE: begin
                if (start) begin
                    load=1;
                    next_state = CALC;
                end else begin
                    load = 0;
                    calc = 0;
                    next_state = IDLE;
                end
            end
            CALC: begin
                calc = 1;
                if (done) begin
                    next_state = IDLE;
                end else begin
                    next_state = CALC;
                end
            end
        endcase
    end
endmodule