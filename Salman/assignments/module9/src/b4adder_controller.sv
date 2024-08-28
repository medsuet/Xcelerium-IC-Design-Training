module b4adder_controller (
    input logic CLK,
    input logic RESET,
    input logic bit_in,
    output logic bit_out
);

logic [2:0] c_state, n_state;
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;
parameter S6 = 3'b110;

// state register
always_ff @(posedge CLK or negedge RESET)
begin
    if (!RESET)         
    // Reset is active low
        c_state <= #1 S0;
    else
        c_state <= #1 n_state;
end


// next state always block
always_comb 
begin
    // next state logic
    case (c_state)
        S0: begin 
                if (bit_in) n_state = S2;
                else n_state = S1; 
            end
        S1: begin 
                n_state = S3;
            end
        S2: begin 
                if (bit_in) n_state = S4;
                else n_state = S3;
            end
        S3: begin 
                n_state = S5;
            end
        S4: begin 
                if (bit_in) n_state = S6;
                else n_state = S5; 
            end
        S5: begin 
                n_state = S0;
            end
        S6: begin 
                n_state = S0;
            end
        default: n_state = S0;
    endcase

    // output logic
    case (c_state)
        S0: begin 
                if (bit_in) bit_out = 0;
                else bit_out = 1; 
            end
        S1: begin 
                bit_out = bit_in;
            end
        S2: begin 
                if (bit_in) bit_out = 0;
                else bit_out = 1;
            end
        S3: begin 
                bit_out = bit_in;
            end
        S4: begin 
                if (bit_in) bit_out = 0;
                else bit_out = 1; 
            end
        S5: begin 
                bit_out = bit_in;
            end
        S6: begin 
                if (bit_in) bit_out = 0;
                else bit_out = 1; 
            end
        default: bit_out = 1'bx;
    endcase
end
    
endmodule