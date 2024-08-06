//==============Author: Masooma Zia==============
//==============Date: 26-07-2024==============
//==============Description:4-bit Sequential Counter using State Machine==============

module adder(input logic clk, input logic reset, input logic b, output logic s);
//==============Internal Signals==============
logic [1:0] current_state;
logic [1:0] next_state;
logic [2:0] bit_counter;
logic clear;
//==============STATES==============
localparam S0=2'b00;
localparam S1=2'b11;
localparam S2=2'b10;
//==============Clear Signal (activate after 4-bit)==============
always_comb begin
    if (bit_counter==3) begin
        clear = 1;
    end else begin
        clear=0;
    end
end
//==============Flipflop(State Register)==============
always_ff@(posedge clk) begin
    if (~reset) begin
        current_state <= S0;
        bit_counter <= 3'd0;
    end else if (clear) begin
        current_state <= S0;
        bit_counter <= 3'd0;
    end else begin
        current_state <= next_state;
        bit_counter <= bit_counter+1;
    end
end
//==============State Machine(Mealy)==============
always_comb begin
    next_state=current_state;
    case(current_state)
        S0: begin
            if (b==1) begin
                next_state=S1;
                s=0;
            end else begin
                next_state=S2;
                s=1;
            end
        end
        S1: begin 
            if (b==1) begin
                next_state=S1;
                s=0;
            end else begin
                next_state=S2;
                s=1;
            end
            end
        S2: begin
            if (b==1) begin
                next_state=S2;
                s=1;
            end else begin
                next_state=S2;
                s=0;
            end
        end
        default:
            next_state=S0;
    endcase
end
endmodule



        
