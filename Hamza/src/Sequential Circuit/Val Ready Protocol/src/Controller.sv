module Controller(
    input logic clk,rst,count_comp,
    input logic [1:0] in,
    input logic src_valid, dest_ready,
    output logic QR_sel,clear, src_ready, dest_valid,
    output logic [1:0] data_sel
);

// Define states
typedef enum logic[1:0]{
    START = 2'b00,  
    PROCESS  = 2'b01,  
    WAIT = 2'b10
} state_t;

state_t state, next_state;

always @(posedge clk or negedge rst) 
    begin
        if (!rst) 
        begin
            state <= START;
        end 
        else 
        begin
            state <= next_state;
        end
    end
always @(*) 
    begin
        case (state) 
            START : begin
                if (!src_valid)begin
                    clear   = 1'b1;
                    QR_sel = 1'b0;
                    data_sel = 2'b0;
                    src_ready = 1'b1;
                    dest_valid = 1'b0;
                    next_state = START;
                end
                else begin
                    clear   = 1'b0;
                    QR_sel = 1'b0;
                    data_sel = 2'b0;
                    src_ready = 1'b1;
                    dest_valid = 1'b0;
                    next_state = PROCESS;
                end   
            end
            PROCESS : begin
                if ( count_comp == 1'b1)begin
                    clear   = 1'b1;
                    QR_sel = 1'b0;
                    data_sel = 2'b0;
                    src_ready = 1'b0;
                    dest_valid = 1'b1;
                    case (in)
                        2'b01 : data_sel = 2'b01;
                        2'b10 : data_sel = 2'b10;
                        2'b00 : data_sel = 2'b00;
                        2'b11 : data_sel = 2'b11;
                    endcase
                    if (dest_ready) begin
                        next_state = START;
                    end
                    else begin
                        next_state = WAIT;
                    end
                end
                else begin
                    clear   = 1'b0;
                    QR_sel = 1'b1;
                    src_ready = 1'b0;
                    dest_valid = 1'b0;
                    next_state = PROCESS;
                    case (in)
                        2'b01 : data_sel = 2'b01;
                        2'b10 : data_sel = 2'b10;
                        2'b00 : data_sel = 2'b00;
                        2'b11 : data_sel = 2'b11;
                    endcase
                end      
            end   
            WAIT: begin
                if(!dest_ready) begin
                    next_state = WAIT;
                    clear   = 1'b1;
                    QR_sel = 1'b0;
                    data_sel = 2'b0;
                    src_ready = 1'b0;
                    dest_valid = 1'b1;
                end
                else begin
                    next_state = START;
                    clear   = 1'b1;
                    QR_sel = 1'b0;
                    data_sel = 2'b0;
                    src_ready = 1'b0;
                    dest_valid = 1'b1; 
                end
            end
            default: begin
                next_state = START;
            end
        endcase
    end



endmodule