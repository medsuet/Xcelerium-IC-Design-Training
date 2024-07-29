module Sequential4BitAdder(
    input wire clk,
    input wire reset,
    input wire  in,
    output reg out
);
    // State encoding
    parameter S0 = 3'h0, S1 = 3'h1, S2 = 3'h2,S3 = 3'h3, S4 = 3'h4, S5 = 3'h5, S6 = 3'h6,S7 = 3'h7;
    
    reg [2:0] state, next_state;

    always @(posedge clk or posedge reset) 
    begin
        if (reset) 
        begin
            state <= S7;
        end 
        else 
        begin
            state <= next_state;
        end
    end
    
    
    always @(*) 
    begin
        case (state)
            S7:begin
                next_state = S0;
            end
            S0: begin
                if(in ==0)
                begin 
                    out = 1'b1;
                    next_state   = S1;
                end
                
                else begin
                    out = 1'b0;
                    next_state   = S2;
                end
            end
            S1: begin
                if(in==0)
                begin
                  out = 1'b0;
                  next_state =S3;
                end 
                else
                begin
                  out = 1'b1;
                  next_state =S3;  
                end
               end
            S2: begin
                if(in==0)
                begin
                  out = 1'b1;
                  next_state =S3;
                end 
                else
                begin
                  out = 1'b0;
                  next_state =S4;  
                end
               end
            S3: begin
                if(in==0)
                begin
                  out = 1'b0;
                  next_state =S5;
                end 
                else
                begin
                  out = 1'b1;
                  next_state =S5;  
                end
               end
            S4: begin
                if(in==0)
                begin
                  out = 1'b1;
                  next_state =S5;
                end 
                else
                begin
                  out = 1'b0;
                  next_state =S6;  
                end
               end
            S5: begin
                if(in==0)
                begin
                  out = 1'b0;
                  next_state =S0;
                end 
                else
                begin
                  out = 1'b1;
                  next_state =S0;  
                end
               end
            S6: begin
                if(in==0)
                begin
                  out = 1'b1;
                  next_state =S0;
                end 
                else
                begin
                  out = 1'b0;
                  next_state =S0;  
                end
               end
            default: begin
                next_state = S7;
            end
        endcase
    end
endmodule
