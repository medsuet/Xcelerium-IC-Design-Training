module controller(
    input logic clk,reset,count16,
    input logic [1:0] operation, // qn qn+1
    input logic src_valid, dest_ready, // valid_ready input signals
    output logic dest_valid, src_ready, // valid-ready output signals
    output logic selectMultiplier,enable,enable_product,
    output logic [1:0] selectAccumulator
);

typedef enum logic [1:0] { 
    IDLE = 2'b00,
    PROCESS = 2'b01,
    WAIT = 2'b10,
    DONE = 2'b11
 } state_type;

state_type currentState,nextState;

// sequentional block
always @(posedge clk or negedge reset) 
    begin
        if (!reset) 
        begin
            currentState <= IDLE;
        end 
        else 
        begin
            currentState <= nextState;
        end
    end

// combinational block for next state logic
always_comb 
    begin
        case (currentState) 
            IDLE : begin
                if (!src_valid)
                begin
                    nextState = IDLE;
                end
                else begin
                    nextState = PROCESS;
                end   
            end
            PROCESS : begin
                // check if we reached our limit then enable and ready the bit
                if ( count16 == 1'b1) // here we reached our limit 16
                begin

                    nextState = WAIT;
                end
                else 
                begin
                    nextState = PROCESS;
                
                end   
            end
            WAIT: begin
                if (!dest_ready) begin
                    nextState = WAIT;
                end
                else begin
                    nextState = DONE;
                end
            end
            DONE: begin
                nextState = IDLE;     
            end
        endcase
    end

// combinational block we use only one comb block for present currentState and output
always_comb 
    begin
        case (currentState) 
            IDLE : begin
                if (!src_valid)
                begin
                    enable   = 1'b0;
                    src_ready = 1'b1;
                    dest_valid = 1'b0;
                    enable_product = 1'b0;
                    selectMultiplier = 1'b0;
                    selectAccumulator = 2'b00;
                end
                else begin
                    enable   = 1'b1;
                    src_ready = 1'b1;
                    dest_valid = 1'b0;
                    enable_product = 1'b0;
                    selectMultiplier = 1'b0;
                    selectAccumulator = 2'b00;
                end   
            end
            PROCESS : begin
                // check if we reached our limit then enable and ready the bit
                if ( count16 == 1'b1) // here we reached our limit 16
                begin
                    enable   = 1'b0;
                    src_ready = 1'b0;
                    dest_valid = 1'b1;
                    enable_product = 1'b1;
                    selectMultiplier = 1'b1;
                    selectAccumulator = 2'b00;
                    case (operation) // check Qn and Qn+1 bit
                    2'b01 : selectAccumulator = 2'b01; // A+M
                    2'b10 : selectAccumulator = 2'b10; // A-M
                    2'b00 : selectAccumulator = 2'b00; // A
                    2'b11 : selectAccumulator = 2'b11; // A
                    endcase
                end
                else 
                begin
                    enable   = 1'b1;
                    src_ready = 1'b0;
                    dest_valid = 1'b0;
                    enable_product = 1'b0;
                    selectMultiplier = 1'b1;
                    case (operation) // check Qn and Qn+1 bit
                    2'b01 : selectAccumulator = 2'b01; // A+M
                    2'b10 : selectAccumulator = 2'b10; // A-M
                    2'b00 : selectAccumulator = 2'b00; // A
                    2'b11 : selectAccumulator = 2'b11; // A
                    endcase
                end
                
            end 
            WAIT: begin
                if (!dest_ready) begin
                    enable   = 1'b0;
                    src_ready = 1'b0;
                    dest_valid = 1'b1;
                    enable_product = 1'b0;
                    selectMultiplier = 1'b1;
                    case (operation) // check Qn and Qn+1 bit
                    2'b01 : selectAccumulator = 2'b01; // A+M
                    2'b10 : selectAccumulator = 2'b10; // A-M
                    2'b00 : selectAccumulator = 2'b00; // A
                    2'b11 : selectAccumulator = 2'b11; // A
                    endcase
                end
                else begin
                    enable   = 1'b0;
                    src_ready = 1'b0;
                    dest_valid = 1'b1;
                    enable_product = 1'b0;
                    selectMultiplier = 1'b1;
                    case (operation) // check Qn and Qn+1 bit
                    2'b01 : selectAccumulator = 2'b01; // A+M
                    2'b10 : selectAccumulator = 2'b10; // A-M
                    2'b00 : selectAccumulator = 2'b00; // A
                    2'b11 : selectAccumulator = 2'b11; // A
                    endcase
                end
            end 
            DONE: begin
                enable   = 1'b0;
                src_ready = 1'b0;
                dest_valid = 1'b0;
                enable_product = 1'b0;
                selectMultiplier = 1'b1;
                case (operation) // check Qn and Qn+1 bit
                2'b01 : selectAccumulator = 2'b01; // A+M
                2'b10 : selectAccumulator = 2'b10; // A-M
                2'b00 : selectAccumulator = 2'b00; // A
                2'b11 : selectAccumulator = 2'b11; // A
                    endcase
            end 
        endcase
    end

endmodule