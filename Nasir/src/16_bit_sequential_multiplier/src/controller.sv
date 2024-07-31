module controller(
    input logic clk,reset,start,count16,
    input logic [1:0] operation, // qn qn+1
    output logic ready,selectMultiplier,enable,
    output logic [1:0] selectAccumulator
);

parameter IDLE = 1'b0, PROCESS = 1'b1;
logic currentState,nextState;

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

// combinational block we use only one comb block for present currentState and output
always_comb 
    begin
        case (currentState) 
            IDLE : begin
                if (!start)
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

                    nextState = IDLE;
                end
                else 
                begin
                    nextState = PROCESS;
                
                end   
            end
        endcase
    end

// combinational block we use only one comb block for present currentState and output
always_comb 
    begin
        case (currentState) 
            IDLE : begin
                if (!start)
                begin
                    enable   = 1'b0;
                    ready   = 1'b0;
                    selectMultiplier = 1'b0;
                    selectAccumulator = 2'b00;
                end
                else begin
                    enable   = 1'b1;
                    ready   = 1'b0;
                    selectMultiplier = 1'b0;
                    selectAccumulator = 2'b00;
                end   
            end
            PROCESS : begin
                // check if we reached our limit then enable and ready the bit
                if ( count16 == 1'b1) // here we reached our limit 16
                begin
                    enable   = 1'b0;
                    ready   = 1'b1;
                    selectMultiplier = 1'b1;
                    selectAccumulator = 2'b00;
                end
                else 
                begin
                    enable   = 1'b1;
                    ready   = 1'b0;
                    selectMultiplier = 1'b1;
                    case (operation) // check Qn and Qn+1 bit
                    2'b01 : selectAccumulator = 2'b01; // A+M
                    2'b10 : selectAccumulator = 2'b10; // A-M
                    2'b00 : selectAccumulator = 2'b00; // A
                    2'b11 : selectAccumulator = 2'b11; // A
                    endcase
                end
                
            end   
        endcase
    end

endmodule