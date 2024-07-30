module Controller(
    input logic clk,rst,start,count_comp,
    input logic [1:0] in,
    output logic ready,QR_sel,clear,
    output logic [1:0] data_sel
);

parameter Start = 1'b0;
parameter Process = 1'b1;
logic state,next_state;

always @(posedge clk or negedge rst) 
    begin
        if (!rst) 
        begin
            state <= Start;
        end 
        else 
        begin
            state <= next_state;
        end
    end
always @(*) 
    begin
        case (state) 
            Start : begin
                if (!start)begin
                    clear   = 1'b1;
                    ready   = 1'b0;
                    QR_sel = 1'bx;
                    data_sel = 2'bx;
                    next_state = Start;
                end
                else begin
                    clear   = 1'b0;
                    ready   = 1'b0;
                    QR_sel = 1'b0;
                    data_sel = 2'bx;
                    next_state = Process;
                end   
            end
            Process : begin
                if ( count_comp == 1'b1)begin
                    clear   = 1'b1;
                    ready   = 1'b1;
                    QR_sel = 1'bx;
                    data_sel = 2'bx;
                    next_state = Start;
                end
                else begin
                    clear   = 1'b0;
                    ready   = 1'b0;
                    QR_sel = 1'b1;
                    next_state = Process;
                    case (in)
                    2'b01 : data_sel = 2'b01;
                    2'b10 : data_sel = 2'b10;
                    2'b00 : data_sel = 2'b00;
                    2'b11 : data_sel = 2'b11;
                    endcase
                end
                
            end   
        endcase
    end



endmodule