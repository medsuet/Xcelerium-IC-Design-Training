module restoring_division_con
(
    input logic clk,rst,
    input logic valid_src, 
    input logic stop, 
    output logic load_en, 
    output logic update_en, 
    output logic counter_en, 
    output logic ans_sel,
    output logic valid_des,
    output logic clear
);

logic c_state, n_state;
parameter S0    =   0;
parameter S1    =   1;

always_ff @(posedge clk or negedge rst) begin
    if(!rst)  c_state <= S0;
    else      c_state <= n_state;  
end

always_comb 
begin
    case (c_state)
        S0:
        begin
            if(valid_src) n_state = S1;
            else          n_state = S0;
        end

        S1:
        begin
            if(stop)    n_state = S0;
            else        n_state = S1;
        end
    endcase
end


always_comb 
begin
    case (c_state)
        S0:
        begin
            counter_en = 1'b0;
            clear = 1'b1;
        
            if(valid_src) 
            begin 
                load_en = 1'b1;
            end
            else
            begin 
                load_en = 1'b0;
            end
        end

        S1:
        begin
            load_en = '0;
            counter_en = 1'b1;
            clear = '0;
            if(stop) 
            begin 
                valid_des = 1'b1;
                update_en = 1'b0;
                ans_sel   = 1'b1;
            end
            else
            begin 
                valid_des = 1'b0;
                update_en = 1'b1;
                ans_sel   = 1'b0;
            end
        end
    endcase
end

endmodule