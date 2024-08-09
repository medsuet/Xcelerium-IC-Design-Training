module Control_unit (
    input  logic          clk,
    input  logic          rst,
    input  logic          done,
    input  logic          src_valid,
    input  logic          dd_ready,

    output logic          selc_A,
    input  logic          temp,

    output logic          enable_count,
    output logic          enable_registers,
    output logic          src_ready,
    output logic          dd_valid

);

    typedef enum logic [2:0] { 
        IDLE,
        CALC,
        WAIT
    } state_t;

    state_t state, next_state;


    always@(*) 
    begin 
        case (state)
            IDLE:
                begin
                    if(src_valid)
                    begin
                        enable_registers=1;     
                        dd_valid=0;
                        enable_count=0;
                        src_ready=0;
                        next_state=CALC;
                    end
                    else 
                    begin
                        enable_registers=0;
                        enable_count=0;  
                        dd_valid=0;
                        src_ready=1;
                        next_state=IDLE;
                    end
                end
            CALC:
                begin if (done) begin
                        enable_registers=0;
                        src_ready=0;
                        dd_valid=1;
                        selc_A=0;
                        enable_count=0;
                        next_state=WAIT;
                    end else begin
                        src_ready=0;
                        dd_valid=0;
                        //selc_A=0;
                        enable_registers=0;
                        enable_count=1;
                        if (temp) begin
                            selc_A=1;
                        end 
                        else begin
                            selc_A=0;
                        end
                        next_state=CALC;
                    end
                end 
            WAIT:
                begin
                    if (dd_ready) begin
                        enable_registers=0;
                        src_ready=0;
                        dd_valid=1;
                        enable_count=0;
                        next_state=IDLE;
                    end
                    else 
                    begin
                        next_state=IDLE;
                    end
                end
        endcase
    end



    //This is the state machine
    always_ff @( posedge clk or posedge rst ) 
    begin 
    if (rst)
        begin
            state<=IDLE;
        end
    else
        begin
            state<= next_state;
        end
    end

endmodule