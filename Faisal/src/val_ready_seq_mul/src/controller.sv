module Controller(
    input logic clk,rst,src_valid,dest_ready,count_comp,
    input logic [1:0] in,
    output logic src_ready,dest_valid,QR_sel,clear, en_pro,
    output logic [1:0] data_sel
);

parameter IDLE = 2'b00, S0 = 2'b01, S1 = 2'b10, S2 = 2'b11;
logic [1:0] state,next_state;

// sequentional block
always @(posedge clk or negedge rst) 
    begin
        if (!rst) 
        begin
            state <= #1 IDLE;
        end 
        else 
        begin
            state <= #1 next_state;
        end
    end

// combinational block we use only one comb block for present state and output
always_comb 
    begin
        case (state) 
            IDLE : begin
                if (!src_valid)
                begin
                    QR_sel = 1'bx;
                    clear          = 1'b1;   // Undefined clear
                    src_ready      = 1'b1;   
                    dest_valid     = 1'b0;
                    data_sel = 2'bx;
                    en_pro = 1'b0;
                    next_state = IDLE;
                end
                else begin
                    clear          = 1'b0;   // Undefined clear
                    src_ready      = 1'b1;   
                    dest_valid     = 1'b0;
                    QR_sel = 1'b0;
                    data_sel = 2'bx;
                    en_pro = 1'b0;
                    next_state = S0;
                end   
            end
            S0 : begin
                // check if we reached our limit then clear and ready the bit
                if ( count_comp == 1'b1) // here we reached our limit 16
                begin
                    clear          = 1'b1;   // Undefined clear
                    src_ready      = 1'b0;   
                    dest_valid     = 1'b1;
                    QR_sel = 1'bx;
                    data_sel = 2'bx;
                    en_pro = 1'b1;
                    next_state = S1;
                    case (in) // check Qn and Qn+1 bit
                    2'b01 : data_sel = 2'b01; // A+M
                    2'b10 : data_sel = 2'b10; // A-M
                    2'b00 : data_sel = 2'b00; // A
                    2'b11 : data_sel = 2'b11; // A
                    endcase
                end
                else 
                begin
                    clear          = 1'b0;   // Undefined clear
                    src_ready      = 1'b0;   
                    dest_valid     = 1'b0;
                    QR_sel = 1'b1;
                    en_pro = 1'b0;
                    next_state = S0;
                    case (in) // check Qn and Qn+1 bit
                    2'b01 : data_sel = 2'b01; // A+M
                    2'b10 : data_sel = 2'b10; // A-M
                    2'b00 : data_sel = 2'b00; // A
                    2'b11 : data_sel = 2'b11; // A
                    endcase
                end
                
            end  
            S1: begin
                if (!dest_ready) begin
                    dest_valid = 1'b1;
                    src_ready = 1'b0;
                    clear = 1'b1;
                    en_pro = 1'b0;
                    QR_sel = 1'bx;
                    data_sel = 2'bx;
                    next_state = S1;
                    case (in) // check Qn and Qn+1 bit
                    2'b01 : data_sel = 2'b01; // A+M
                    2'b10 : data_sel = 2'b10; // A-M
                    2'b00 : data_sel = 2'b00; // A
                    2'b11 : data_sel = 2'b11; // A
                    endcase
                    
                end
                else if (dest_ready) begin
                    dest_valid = 1'b1;
                    src_ready = 1'b0;
                    clear = 1'b1;
                    QR_sel = 1'bx;
                    en_pro = 1'b0;
                    data_sel = 2'bx;
                    next_state = S2;
                    case (in) // check Qn and Qn+1 bit
                    2'b01 : data_sel = 2'b01; // A+M
                    2'b10 : data_sel = 2'b10; // A-M
                    2'b00 : data_sel = 2'b00; // A
                    2'b11 : data_sel = 2'b11; // A
                    endcase

                end

            end
            S2: begin 
                next_state = IDLE;
                clear = 1'b1;
                src_ready      = 1'b0;   
                dest_valid     = 1'b0;
                QR_sel = 1'b1;
                en_pro = 1'b0;
                case (in) // check Qn and Qn+1 bit
                    2'b01 : data_sel = 2'b01; // A+M
                    2'b10 : data_sel = 2'b10; // A-M
                    2'b00 : data_sel = 2'b00; // A
                    2'b11 : data_sel = 2'b11; // A
                endcase
            end

        endcase
    end

endmodule