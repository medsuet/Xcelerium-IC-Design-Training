module controller(
    input logic clk,
    input logic reset,
    input logic start,
    input logic count_16,
    input logic msb_remainder,
    output logic ready,
    output logic select_aq,
    output logic update_quotient,
    output logic enable
);


typedef enum logic { 
    IDLE = 1'b0,
    PROCESS = 1'b1
} state_type;

state_type current_state,next_state;

// sequentional block
always @(posedge clk or negedge reset) 
    begin
        if (!reset) 
        begin
            current_state <= IDLE;
        end 
        else 
        begin
            current_state <= next_state;
        end
    end

// combinational block we use only one comb block for present current_state and output
always_comb 
    begin
        case (current_state) 
            IDLE : begin
                if (!start)
                begin
                    next_state = IDLE;
                end
                else begin
                    next_state = PROCESS;
                end   
            end
            PROCESS : begin
                // check if we reached our limit then enable and ready the bit
                if ( count_16 == 1'b1) // here we reached our limit 16
                begin

                    next_state = IDLE;
                end
                else 
                begin
                    next_state = PROCESS;
                
                end   
            end
        endcase
    end

// combinational block we use only one comb block for present current_state and output
always_comb 
    begin
        case (current_state) 
            IDLE : begin
                if (!start)
                begin
                    enable   = 1'b0;
                    ready   = 1'b0;
                    select_aq = 1'b0;
                    update_quotient = 1'b0;
                end
                else begin
                    enable   = 1'b1;
                    ready   = 1'b0;
                    select_aq = 1'b0;
                    update_quotient = 1'b0;
                    // case (msb_remainder) 
                    // 1'b0 : update_quotient = 1'b0; 
                    // 1'b1 : update_quotient = 1'b1; 
                    // endcase
                end   
            end
            PROCESS : begin
                // check if we reached our limit then enable and ready the bit
                if ( count_16 == 1'b1) // here we reached our limit 16
                begin
                    enable   = 1'b1;
                    ready   = 1'b1;
                    select_aq = 1'b0;
                    case (msb_remainder) 
                    1'b0 : update_quotient = 1'b0; 
                    1'b1 : update_quotient = 1'b1; 
                    endcase
                end
                else 
                begin
                    enable   = 1'b1;
                    ready   = 1'b0;
                    select_aq = 1'b1;
                    case (msb_remainder) 
                    1'b0 : update_quotient = 1'b0; 
                    1'b1 : update_quotient = 1'b1; 
                    endcase
                end
                
            end   
        endcase
    end

endmodule

// controller controller_design (.clk(clk),
//                               .reset(reset),
//                               .start(start),
//                               .count_16(count_16),
//                               .msb_remainder(msb_remainder),
//                               .ready(ready),
//                               .select_aq(select_aq),
//                               .update_quotient(update_quotient),
//                               .enable(enable));
