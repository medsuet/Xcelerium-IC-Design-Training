module Controller(clk,rst,ready,start,clear,enable,count_comp,msb,mux_sel_msb,mux_sel_quotient);
input logic clk,rst,msb,start,count_comp;
output logic ready,clear,enable,mux_sel_msb,mux_sel_quotient;

//intermediate wires
parameter S0 = 1'b0, S1 = 1'b1;
logic state,n_state;
always @(posedge clk or negedge rst) 
    begin
        if (!rst) 
        begin
            state <= S0;
        end 
        else 
        begin
            state <= n_state;
        end
    end
always_comb begin 
    begin
        case (state)
        S0 : begin
            if(!rst)
            begin
                n_state = 0;
                clear   = 1;
                ready   = 0;
                enable  = 0;
            mux_sel_msb = 1'bx;
        mux_sel_quotient= 1'bx; 
            end
            else 
            begin
                n_state = S1;
                clear   = 0;
                ready   = 0;
                enable  = 1;
        mux_sel_quotient= 0;
                 case ( msb)
                 1'b0 : mux_sel_msb = 1'b0;
                 1'b1 : mux_sel_msb = 1'b1;
                 endcase 
            end
        end
        S1 : begin
            if (count_comp == 1'b1)
            begin
                n_state = S0;
                clear   = 1;
                ready   = 1;
                enable  = 0;
        mux_sel_quotient= 1;
                case ( msb)
                 1'b0 : mux_sel_msb = 1'b0;
                 1'b1 : mux_sel_msb = 1'b1;
                endcase    
            end
            else  
            begin
                n_state = S1;
                clear   = 0;
                ready   = 0;
                enable  = 1;
        mux_sel_quotient= 1;
                case ( msb)
                 1'b0 : mux_sel_msb = 1'b0;
                 1'b1 : mux_sel_msb = 1'b1;
                endcase     
            end
        end    
        endcase
    end
    
end
endmodule