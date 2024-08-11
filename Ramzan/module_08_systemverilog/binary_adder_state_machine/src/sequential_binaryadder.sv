module sequential_binaryadder(
    input logic CLK,
    input logic RST,
    //input logic ENABLE,
    input logic NUMBER,
    output logic OUTPUT
);

//parameter IDLE = 3'b000;
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;
parameter S6 = 3'b110;

logic [2:0] c_state;
logic [2:0] n_state;

always_ff @( posedge CLK or negedge RST) 
begin
    if(!RST)                    //reset is active low
    begin 
        c_state <= #1 S0;
    end
    else begin
        c_state <= #1 n_state;
    end
end

always_comb begin
    case(c_state)
        S0 : begin if (NUMBER ) n_state = S4;
            else n_state = S1;
        end
        S1 : begin  n_state = S2;
        end
        S2 : begin n_state = S3;
        end
        S3 : begin n_state = S0;
        end
        S4 : begin if(NUMBER) n_state = S5;
            else n_state = S2;
        end
        S5 : begin if(NUMBER) n_state = S6;
            else n_state = S3;
        end
        S6 : begin  n_state = S0;
        end
        default : n_state = S0;
    endcase
end

always_comb begin
    case(c_state)
        S0 : begin if (NUMBER) OUTPUT = 1'b0;
            else OUTPUT = 1'b1;
        end
        S1 : begin OUTPUT = NUMBER;
        end
        S2 : begin OUTPUT = NUMBER;
        end
        S3 : begin OUTPUT = NUMBER;
        end
        S4 : begin if(NUMBER) OUTPUT = 1'b0;
            else OUTPUT = 1'b1;
        end
        S5 : begin if(NUMBER) OUTPUT = 1'b0;
            else OUTPUT = 1'b1;
        end
        S6 : begin if(NUMBER) OUTPUT = 1'b0;
            else OUTPUT = 1'b1;
        end
        default : OUTPUT = 1'bx;
    endcase
end
endmodule



        


