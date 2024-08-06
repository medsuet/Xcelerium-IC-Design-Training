module adder (
    input   logic clk,reset,
    input   logic data,
    output  logic out
);

logic [2:0] c_state, n_state;

parameter  S0 = 3'b000 , S1 = 3'b001 , S2 = 3'b010 , S3 = 3'b011 , S4 = 3'b100 , S5 = 3'b101 , S6 = 3'b110  ;

//state register
always_ff @( posedge clk or negedge reset ) begin 
    if ( !reset)begin
        c_state <= S0;
    end
    else 
        c_state <= n_state;
    
end


//next state always block
always_comb begin 

    case (c_state)

        S0    :  begin
            if (data) n_state = S4;
            else n_state = S1;
        end
        S1    :  begin
            if (data) n_state = S2;
            else n_state = S2;
        end 
        S2    :  begin
            if (data) n_state = S3;
            else n_state = S3;
        end 
        S3    :  begin
            if (data) n_state = S0;
            else n_state = S0;
        end 
        S4    :  begin
            if (data) n_state = S5;
            else n_state = S2;
        end 
        S5    :  begin
            if (data) n_state = S6;
            else n_state = S3;
        end 
        S6    :  begin
            if (data) n_state = S0;
            else n_state = S0;
        end 

        default:    n_state = S0;
    endcase
    
end

//output always block
always_comb begin

    case (c_state)

        S0    : begin
            if (data) out = 1'b0;
            else out = 1'b1; 
        end
        S1    : begin
            if (data) out = data;
            else out = data; 
        end 
        S2    : begin
            if (data) out = data;
            else out = data; 
        end
        S3    : begin
            if (data) out = data;
            else out = data; 
        end
        S4    : begin
            if (data) out = 1'b0;
            else out = 1'b1; 
        end
        S5    : begin
            if (data) out = 1'b0;
            else out = 1'b1; 
        end
        S6    : begin
            if (data) out = ~data;
            else out = ~data; 
        end
        default: out = 1'bx;
    endcase
end


endmodule