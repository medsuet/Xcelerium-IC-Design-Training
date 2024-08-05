
module control_unit (
    input  logic clk,   
    input  logic rst,   
    input  logic Src_valid,                             //This was initialy start 
    input  logic dd_ready,
    input  logic done, 
    output logic Src_ready,                             //ready for inputs
    output logic dd_valid,                              //
    output logic load,        
    output logic calc        
);


    //Initializing the states
    typedef enum logic [2:0] {
        IDLE,  
        CALC,
        FINISH
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
                if (Src_valid) begin
                    Src_ready=0;
                    dd_valid=0;
                    load=1;                                     //for loading outputs
                    next_state = CALC;
                end else begin
                    load = 0;
                    calc = 0;
                    Src_ready=1;
                    dd_valid=0;
                    next_state = IDLE;
                end
            end
            CALC: begin
                calc = 1;
                if (done & dd_ready) begin
                    load = 0;
                    calc = 0;
                    Src_ready=1;
                    dd_valid=1;
                    next_state = IDLE;
                end else if (done)
                begin
                    calc = 0;
                    load = 0;
                    Src_ready=0;
                    dd_valid=1;
                    next_state=FINISH;
                end
                else begin
                    next_state = CALC;
                end
            end
            FINISH:
                if (dd_ready) begin
                    load = 0;
                    calc = 0;
                    Src_ready=1;
                    dd_valid=0;
                    next_state = IDLE;
                end 
                else begin
                    calc = 0;
                    load = 0;
                    Src_ready=0;
                    dd_valid=1;
                    next_state=FINISH;
                end
        endcase
    end
endmodule