module controller (
    input logic clk,           // Clock signal
    input logic rst_n,         // Asynchronous active-low reset
          
    input logic src_valid,
    input logic dst_ready,
    input logic cmp,           // Compare signal
    output logic reset,        // Reset signal
    output logic enA, enB,M4_sel,
   
    output logic   src_ready , dst_valid      // Ready signal
);

    // State encoding
    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010
        
    } state_t;

    state_t current_state, next_state;

    // State transition
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            S0: if ( src_valid) next_state = S1;
                else next_state = S0;
            S1: if (!cmp) next_state = S1;
                else if((!dst_ready)&cmp) next_state = S2;
                else if(dst_ready&cmp) next_state = S0;                
            S2: if (dst_ready&cmp) next_state = S0;
                else if((!dst_ready)&cmp) next_state = S2;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always_comb begin
        // Default values
        reset = 1;
        enA = 1;
        enB = 1;
        dst_valid = 0;
        src_ready = 0;

        case (current_state)
            S0: begin 
                      if(src_valid)begin
                          enA = 1;
                          enB = 1;
                          M4_sel = 1;
                          dst_valid = 0;
                          src_ready = 1;
                      end
                      else begin
                          enA = 1;
                          enB = 1;
                          M4_sel = 1;
                          dst_valid = 0;
                          src_ready = 1;
                      end
            end
            S1: begin
                if(~cmp)begin
                          enA = 1;
                          enB = 1;
                          M4_sel = 0;
                          dst_valid = 0;
                          src_ready = 0;
                end 
                else if(cmp && dst_ready) begin
                          enA = 0;
                          enB = 0;
                          M4_sel = 0;	
                          dst_valid = 1;
                          src_ready = 1;
                end
                else if(cmp && ~dst_ready) begin
                          enA = 0;
                          enB = 0;
                          M4_sel = 0;
                          dst_valid = 1;
                          src_ready = 0;
                end
            end
            S2: begin
                if(dst_ready && cmp)begin
                          enA = 0;
                          enB = 0;
                          M4_sel = 0;
                          dst_valid = 0;
                          src_ready = 1;
                      end
                else begin
                          enA = 0;
                          enB = 0;
                          M4_sel = 0;
                          dst_valid = 1;
                          src_ready = 1;
                      end
            end
            
        endcase
    end
endmodule

