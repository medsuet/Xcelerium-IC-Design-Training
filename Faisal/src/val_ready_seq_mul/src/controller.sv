module Controller(
    input logic clk,rst,count_comp,
    input logic [1:0] in,
    input logic src_valid, dest_ready,
    output logic QR_sel,clear, src_ready, dest_valid,
    output logic [1:0] data_sel
);

// Define states S0, S1, sS2
typedef enum logic[1:0]{
    S0 = 2'b00,  
    S1  = 2'b01,  
    S2 = 2'b10
} state_t;

state_t state, next_state;

// sequential circuit
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

// combinational cicuit
always @(*) 
    begin
        case (state) 
            S0 : begin
                if (!src_valid)
                begin
                    clear   = 1'b1;
                    QR_sel = 1'b0;
                    data_sel = 2'b0;
                    src_ready = 1'b1;
                    dest_valid = 1'b0;
                    next_state = S0;
                end
                else 
                begin
                    clear   = 1'b0;
                    QR_sel = 1'b0;
                    data_sel = 2'b0;
                    src_ready = 1'b1;
                    dest_valid = 1'b0;
                    next_state = S1;
                end   
            end
            S1 : begin
                if ( count_comp == 1'b1)
                begin
                    clear   = 1'b1;
                    QR_sel = 1'b0;
                    data_sel = 2'b0;
                    src_ready = 1'b0;
                    dest_valid = 1'b1;
                    case (in)
                        2'b00 : data_sel = 2'b00; // Accumulator   Qn,Qn+1 ---> 00 do nothing
                        2'b01 : data_sel = 2'b01; // Accumulator + Multiplicand  Qn,Qn+1 ---> 01
                        2'b10 : data_sel = 2'b10; // Accumulator - Multiplicand  Qn,Qn+1 ---> 10  
                        2'b11 : data_sel = 2'b11; // Accumulator   Qn,Qn+1 ---> 11 do nothing
                    endcase
                    if (dest_ready) begin
                        next_state = S0;
                    end
                    else begin
                        next_state = S2;
                    end
                end
                else 
                begin
                    clear   = 1'b0;
                    QR_sel = 1'b1;
                    src_ready = 1'b0;
                    dest_valid = 1'b0;
                    next_state = S1;
                    case (in)
                        2'b00 : data_sel = 2'b00; // Accumulator   Qn,Qn+1 ---> 00 do nothing
                        2'b01 : data_sel = 2'b01; // Accumulator + Multiplicand  Qn,Qn+1 ---> 01
                        2'b10 : data_sel = 2'b10; // Accumulator - Multiplicand  Qn,Qn+1 ---> 10  
                        2'b11 : data_sel = 2'b11; // Accumulator   Qn,Qn+1 ---> 11 do nothing
                    endcase
                end      
            end   
            S2: begin
                if(!dest_ready) 
                begin
                    next_state = S2;
                    clear   = 1'b1;
                    QR_sel = 1'b0;
                    data_sel = 2'b0;
                    src_ready = 1'b0;
                    dest_valid = 1'b1;
                end
                else 
                begin
                    next_state = S0;
                    clear   = 1'b1;
                    QR_sel = 1'b0;
                    data_sel = 2'b0;
                    src_ready = 1'b0;
                    dest_valid = 1'b1; 
                end
            end
            default: begin
                next_state = S0;
            end
        endcase
    end



endmodule