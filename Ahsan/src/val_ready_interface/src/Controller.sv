module controller(clk,rst,src_ready,src_val,dest_val,dest_ready,clear,count_comp,Qo_Q1,mux_sel_Mul,mux_sel_Shift,pro_en);
input logic clk,rst,src_val,dest_ready,count_comp;
input logic [1:0] Qo_Q1;
output logic dest_val,src_ready,mux_sel_Mul,clear,pro_en;
output logic [1:0] mux_sel_Shift;

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
logic [1:0] state,n_state;

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
always @(*) 
    begin
        case (state) 
            S0 : begin
                if (!src_val)begin
                    clear   = 1'b1;
                src_ready   = 1'b1;
                mux_sel_Mul = 1'b0;
              mux_sel_Shift = 2'bx;
                    n_state = S0;
                dest_val    = 1'b0;
                 pro_en     = 1'b0;
                end
                else begin
                    clear   = 1'b0;
                dest_val    = 1'b0;
                mux_sel_Mul = 1'b0;
              mux_sel_Shift = 2'bx;
                    n_state = S1;
                    pro_en  = 1'b1;
                src_ready   = 1'b0;
                end   
            end
            S1 : begin
                if ( count_comp == 1'b1)begin
                    clear   = 1'b1;
                    pro_en  = 1'b1;
                    dest_val= 1'b1;
                mux_sel_Mul = 1'b0;
                    n_state = S2;
                     case (Qo_Q1)
                    2'b01 : mux_sel_Shift = 2'b01 ;
                    2'b10 : mux_sel_Shift = 2'b10;
                    2'b00 : mux_sel_Shift = 2'b00;
                    2'b11 : mux_sel_Shift = 2'b11;
                    endcase
                end
                else begin
                    clear   = 1'b0;
                    dest_val= 1'b0;
                    pro_en  = 1'b1;
                mux_sel_Mul = 1'b1;
                    n_state = S1;
                    case (Qo_Q1)
                    2'b01 : mux_sel_Shift = 2'b01 ;
                    2'b10 : mux_sel_Shift = 2'b10;
                    2'b00 : mux_sel_Shift = 2'b00;
                    2'b11 : mux_sel_Shift = 2'b11;
                    endcase
                end
                
            end   
            S2 : begin
                if ( dest_ready == 1'b1)begin
                    clear   = 1'b1;
                    pro_en  = 1'b0;
                    dest_val= 1'b0;
                 mux_sel_Mul = 1'b0;
                    n_state = S0;
             case (Qo_Q1)
                    2'b01 : mux_sel_Shift = 2'b01 ;
                    2'b10 : mux_sel_Shift = 2'b10;
                    2'b00 : mux_sel_Shift = 2'b00;
                    2'b11 : mux_sel_Shift = 2'b11;
                    endcase
                end
                else begin
                    clear   = 1'b1;
                    dest_val= 1'b1;
                    pro_en  = 1'b0;
                mux_sel_Mul = 1'b0;
                    n_state = S2;
                 case (Qo_Q1)
                    2'b01 : mux_sel_Shift = 2'b01 ;
                    2'b10 : mux_sel_Shift = 2'b10;
                    2'b00 : mux_sel_Shift = 2'b00;
                    2'b11 : mux_sel_Shift = 2'b11;
                    endcase
                end
                
            end   
        endcase
    end



endmodule