module controller(
    input logic CLK,
    input logic RST,
    input logic STOP,
    input logic b_val,
    input logic src_valid_in,   // Source to multiplier valid signal
    input logic dist_ready_out,   // Destination to multiplier ready signal
    output logic enable_A,
    output logic enable_B,
    output logic a_sel,
    output logic comp_sel,
    output logic count_en,
    output logic clear_product,
    output logic CLEAR,
    output logic dist_valid_out, // Multiplier to destination valid signal
    output logic src_ready_in // Multiplier to source ready signal
);

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
logic [1:0] n_state;
logic [1:0] c_state;

always_ff @(posedge CLK or negedge RST)
begin
    if (!RST)
        c_state <= #1 S0;
    else
        c_state <= #1 n_state;
end

always_comb
begin 
    case(c_state)
        S0 : begin 
            if (src_valid_in)
                n_state = S1;
            else
                n_state = S0;
        end

        S1 : begin 
            if (STOP)
                n_state = S2;
            else
                n_state = S1;
        end
        S2 : begin
            if(dist_ready_out)
            begin
                n_state = S0;
            end
            else
            begin
                n_state = S2;
            end
        end
        default : n_state = S0;
    endcase
end

// Assign output values.
always_comb
begin
    case(c_state)
        S0 : begin
            if (src_valid_in)
            begin 
                enable_A = 1'b1;
                enable_B = 1'b1;
                a_sel    = 1'b0;
                count_en = 1'b0;
                comp_sel = 1'b0;
                CLEAR    = 1'b0;
                clear_product = 1'b1;
               // src_ready_in = 1'b1;
                dist_valid_out = 1'b0;
            end
            else
            begin
                enable_A = 1'b0;
                enable_B = 1'b0;
                a_sel    = 1'b0;
                count_en = 1'b0;
                comp_sel = 1'b0;
                CLEAR    = 1'b0;
                clear_product = 1'b0;
                //src_ready_in = 1'b0;
                dist_valid_out = 1'b0;
            end
        src_ready_in = 1'b1;

        end

        S1 : begin
            if ((b_val) & (STOP)) 
            begin
                enable_A = 1'b0;
                enable_B = 1'b0;
                a_sel    = 1'b1;
                count_en = 1'b0;
                comp_sel = 1'b1;
                CLEAR    = 1'b1;
                clear_product = 1'b0;
                src_ready_in = 1'b0;
                dist_valid_out = 1'b0;
            end
            else if ((!b_val) & (STOP)) // When STOP is 1 and b_val=0, output is ready
            begin
                enable_A = 1'b0;
                enable_B = 1'b0;
                a_sel    = 1'b0;
                count_en = 1'b0;
                comp_sel = 1'b1;
                CLEAR    = 1'b1;
                clear_product = 1'b0;
                src_ready_in = 1'b0;
                dist_valid_out = 1'b0;
            end
            else if ((!b_val) & (!STOP)) // Product is not ready
            begin
                enable_A = 1'b0;
                enable_B = 1'b0;
                a_sel    = 1'b0;
                count_en = 1'b1;
                comp_sel = 1'b0;
                CLEAR    = 1'b0;
                clear_product = 1'b0;
                src_ready_in = 1'b0;
                dist_valid_out = 1'b0;
            end
            else if (b_val & (!STOP)) // Product is being computed
            begin
                enable_A = 1'b0;
                enable_B = 1'b0;
                a_sel    = 1'b1;
                count_en = 1'b1;
                comp_sel = 1'b0;
                CLEAR    = 1'b0;
                clear_product = 1'b0;
                src_ready_in = 1'b0;
                dist_valid_out = 1'b0;
            end
        end
        S2 : begin 
                enable_A = 1'b0;
                enable_B = 1'b0;
                a_sel    = 1'b0;
                count_en = 1'b0;
                comp_sel = 1'b0;
                CLEAR    = 1'b0;
                clear_product = 1'b0;
                src_ready_in = 1'b0;
                dist_valid_out = 1'b1;
        end
        //default : n_state = S0;
    endcase
end
endmodule
