module Controller(
    input logic clk,rst,start,count_comp,
    input logic [1:0] in,
    output logic ready,QR_sel,clear,
    output logic [1:0] data_sel
);

parameter S0 = 1'b0, S1 = 1'b1;
logic state,next_state;

// sequentional block
always @(posedge clk or negedge rst) 
    begin
        if (!rst) 
        begin
            state <= S0;
        end 
        else 
        begin
            state <= next_state;
        end
    end

// combinational block we use only one comb block for present state and output
always_comb 
    begin
        case (state) 
            S0 : begin
                if (!start)
                begin
                    clear   = 1'b1;
                    ready   = 1'b0;
                    QR_sel = 1'bx;
                    data_sel = 2'bx;
                    next_state = S0;
                end
                else begin
                    clear   = 1'b0;
                    ready   = 1'b0;
                    QR_sel = 1'b0;
                    data_sel = 2'bx;
                    next_state = S1;
                end   
            end
            S1 : begin
                // check if we reached our limit then clear and ready the bit
                if ( count_comp == 1'b1) // here we reached our limit 16
                begin
                    clear   = 1'b1;
                    ready   = 1'b1;
                    QR_sel = 1'bx;
                    data_sel = 2'bx;
                    next_state = S0;
                end
                else 
                begin
                    clear   = 1'b0;
                    ready   = 1'b0;
                    QR_sel = 1'b1;
                    next_state = S1;
                    case (in) // check Qn and Qn+1 bit
                    2'b01 : data_sel = 2'b01; // A+M
                    2'b10 : data_sel = 2'b10; // A-M
                    2'b00 : data_sel = 2'b00; // A
                    2'b11 : data_sel = 2'b11; // A
                    endcase
                end
                
            end   
        endcase
    end

endmodule