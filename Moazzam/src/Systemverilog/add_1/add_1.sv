module add_1
(
    input logic clk,
    input logic reset,
    input logic in,
    output logic out 
);


logic [2:0] c_state;
logic [2:0] n_state;
parameter IDLE  =   3'h0;
parameter S1    =   3'h1;
parameter S2    =   3'h2;
parameter S3    =   3'h3;
parameter S4    =   3'h4;
parameter S5    =   3'h5;
parameter S6    =   3'h6;
parameter S7    =   3'h7;


//state register
always_ff @ (posedge clk or posedge reset)
begin
    //reset is active high
    if (reset)  c_state <= S1;
    else        c_state <= n_state;
end

//next_state always block
always_comb
begin
    case (c_state)
        //IDLE:
        //begin 
        //    if (en) n_state = S1;
        //    else    n_state = IDLE ; 
        //end

        S1:
        begin 
            if (in) n_state = S3;
            else    n_state = S2 ; 
        end

        S2:
        begin 
            n_state = S4;
        end

        S3:
        begin 
            if (in) n_state = S5;
            else    n_state = S4 ; 
        end

        S4:
        begin 
            n_state = S6;
        end

        S5:
        begin 
            if (in) n_state = S7;
            else    n_state = S6 ; 
        end

        S6:
        begin 
            n_state = S1;
        end

        S7:
        begin 
            n_state = S1;
        end
    endcase
end
//Output logic 
always_comb 
begin
    case (c_state)
        //IDLE:
        //begin 
        //    out = 1'bx;
        //end

        S1:
        begin 
            if(reset)out = 1'bx;
            else if (in) out = 1'b0;
            else    out = 1'b1; 
        end

        S2:
        begin 
            out = in;
        end

        S3:
        begin 
            if (in) out = 1'b0;
            else    out = 1'b1; 
        end

        S4:
        begin 
            out = in;
        end

        S5:
        begin 
            if (in) out = 1'b0;
            else    out = 1'b1; 
        end

        S6:
        begin 
            out = in;
        end

        S7:
        begin 
            if (in) out = 1'b0;
            else    out = 1'b1; 
        end          
        default: 
        begin
            out = 1'bx;
        end

    endcase
end


endmodule
