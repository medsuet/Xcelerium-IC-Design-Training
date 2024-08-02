module control_unit (
    input  logic clk,   
    input  logic rst,   
    input  logic start,             //This will be the inputs ready
    input  logic in_valid,          //This will be the input valid you can load it 
    input  logic done,              
    output logic load,              
    output logic processing,        //This will be the output_valid  
    output logic calc        
);


    //Initializing the states
    typedef enum logic [2:0] {
        IDLE,
        LOAD,  
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
        processing=0;
        case (state)
            IDLE: 
            begin
                if (start) begin
                    next_state = LOAD;
                    end else begin
                    load = 0;
                    calc = 0;
                    processing=0;
                    next_state = IDLE;
                end
                    /*
                    if(in_valid) begin
                        $display("hey i am here");
                        load=1;
                        next_state = CALC;
                    end
                    else begin
                        load=0;
                        next_state = IDLE;
                    end  
                end else begin
                    load = 0;
                    calc = 0;
                    processing=0;
                    next_state = IDLE;
                end
                */
            end
            LOAD:                                       //new added state
            begin
                if (in_valid)  
                begin 
                    load=1;
                    next_state = CALC;
                end
                else begin
                    load = 0;
                    calc = 0;
                    processing=0;
                    next_state = IDLE;
                end
            end
            CALC: 
            begin
                calc = 1;
                processing=1;
                if (done) begin
                    next_state = IDLE;
                    load = 0;
                    calc=0;
                end else begin
                    next_state = CALC;
                    processing=1;
                end
            end
        endcase
    end
endmodule