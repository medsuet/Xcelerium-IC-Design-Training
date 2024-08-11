module Controller (
    input logic       clk,         
    input logic       reset,       
    input logic       src_valid,   
    input logic       dest_ready,  
    input logic       count_comp,  
    input logic       sub_msb,     

    output logic      src_ready,   
    output logic      dest_valid,  
    output logic      en_M,        
    output logic      en_Q,        
    output logic      en_count,    
    output logic      en_A,        
    output logic      alu_op,      
    output logic      sel_Q,       
    output logic      sel_A,       
    output logic      en_out,      
    output logic      en_final,    
    output logic      clear        
);

// Define states
typedef enum logic [1:0]{
    S0 = 2'b00, 
    S1  = 2'b01,
    S2 = 2'b10  
} state_t;
state_t state, next_state; 

// Sequential logic for state transition
always_ff @(posedge clk or negedge reset) begin
    if (!reset) 
        begin
            state <= S0; 
        end 
    else 
        begin
            state <= next_state; 
        end
end

// Combinational logic for output logic and next state logic
always_comb begin
    case (state)
        S0: begin
            en_A       = 1'b0;
            en_Q       = 1'b0;
            en_M       = 1'b0;
            en_count   = 1'b0;
            en_out     = 1'b0;
            en_final   = 1'b0;
            alu_op     = 1'b0;
            sel_Q      = 1'b0;
            sel_A      = 1'b0;
            clear      = 1'b0;
            src_ready  = 1'b1;
            dest_valid = 1'b0;

            if (src_valid) begin // src_valid is high mean we want sending some valid data
                next_state = S1;
                en_A       = 1'b1;
                en_Q       = 1'b1;
                en_M       = 1'b1;
                en_count   = 1'b1;
            end 
            else // if src_valid is low then remain the same state
            begin
                next_state = S0;
            end
        end

        S1: begin
            // Default outputs for S1 state
            en_A       = 1'b1;
            en_Q       = 1'b1;
            en_M       = 1'b1;
            en_count   = 1'b1;
            en_out     = 1'b0;
            en_final   = 1'b0;
            alu_op     = 1'b0;
            sel_Q      = 1'b1;
            sel_A      = 1'b1;
            clear      = 1'b0;
            src_ready  = 1'b0;
            dest_valid = 1'b0;

            if (count_comp && !dest_ready)
            begin
                case(sub_msb) 
                    1'b0: 
                    begin
                        next_state = S2;
                        en_count   = 1'b0;
                        clear      = 1'b1;
                        dest_valid = 1'b1;
                        en_out     = 1'b1;
                        alu_op     = 1'b1; // alu_op is 1, retain remainder and set LSB of quotient
                    end
                    1'b1: 
                    begin
                        next_state = S2;
                        en_count   = 1'b0;
                        clear      = 1'b1;
                        dest_valid = 1'b1;
                        en_out     = 1'b1;
                        alu_op     = 1'b0; 
                    end
                endcase
            end 
            else if (count_comp && dest_ready) 
            begin
                case(sub_msb) 
                    1'b0: 
                    begin
                        next_state = S0;
                        en_A       = 1'b0;
                        en_Q       = 1'b0;
                        en_M       = 1'b0;
                        en_count   = 1'b0;
                        clear      = 1'b1;
                        dest_valid = 1'b1;
                        en_out     = 1'b1;
                        en_final   = 1'b1;
                        alu_op     = 1'b1;
                        src_ready  = 1'b1;
                    end
                    1'b1: 
                    begin
                        next_state = S0;
                        en_A       = 1'b0;
                        en_Q       = 1'b0;
                        en_M       = 1'b0;
                        en_count   = 1'b0;
                        clear      = 1'b1;
                        dest_valid = 1'b1;
                        en_out     = 1'b1;
                        en_final   = 1'b1;
                        alu_op     = 1'b0;
                        src_ready  = 1'b1;
                    end
                endcase
            end 
            else 
            begin
                next_state = S1;
                // Determine ALU operation based on sub_msb
                case(sub_msb)
                    1'b0: alu_op = 1'b1;
                    1'b1: alu_op = 1'b0;
                endcase
            end
        end

        S2: begin
            // Default outputs for S2 state
            en_A       = 1'b1;
            en_Q       = 1'b1;
            en_M       = 1'b1;
            en_count   = 1'b0;
            en_out     = 1'b0;
            en_final   = 1'b0;
            alu_op     = 1'b0;
            sel_Q      = 1'b1;
            sel_A      = 1'b1;
            clear      = 1'b1;
            src_ready  = 1'b0;
            dest_valid = 1'b1;

            // Transition to S0 state if dest_ready is high
            if (dest_ready) 
            begin
                next_state = S0;
                en_final   = 1'b1;
                src_ready  = 1'b1;
            end 
            else 
            begin
                next_state = S2;
            end
        end
        default: 
        begin
            next_state = S0; // Default to S0 on undefined state
        end
    endcase
end
endmodule
