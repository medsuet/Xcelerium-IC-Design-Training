`timescale 1ns / 1ps

module Sequential_Adder(
input logic clk,
input logic reset,
input logic tx_start,
input logic in,
output logic out);
    logic [3:0] c_state;
    logic [3:0] n_state;
    parameter IDLE=4'b0000, DATA0_CARRY0=4'b0001, DATA1_CARRY0=4'b0010,DATA2_CARRY0=4'b0011,DATA3_CARRY0=4'b0100, CARRY0=4'b0101,DATA0_CARRY1=4'b0110,DATA1_CARRY1=4'b0111,DATA2_CARRY1=4'b1000,DATA3_CARRY1=4'b1001,CARRY1=4'b1001;
    //state register
    always_ff @ (posedge clk or negedge reset)
    begin
    //reset is active low
    if (reset) begin
        c_state <= IDLE;
    end
    else begin
        c_state <= n_state;
    end
    end
    //next_state always block
    always_comb
    begin
        case (c_state)
        IDLE: begin if (!tx_start) n_state = IDLE;
        else if ((tx_start==1)&&(in==1)) n_state = DATA0_CARRY1;
        else if ((tx_start==1)&&(in==0)) n_state = DATA0_CARRY0;end
        DATA0_CARRY0: n_state = DATA1_CARRY0;
        DATA1_CARRY0: n_state = DATA2_CARRY0;
        DATA2_CARRY0: n_state = DATA3_CARRY0;
        DATA2_CARRY0: n_state = IDLE;
        DATA0_CARRY1:begin if (in) n_state = DATA1_CARRY1;
        else n_state = DATA1_CARRY0; end
        DATA1_CARRY1:begin if (in) n_state = DATA2_CARRY1;
        else n_state = DATA2_CARRY0; end
        DATA2_CARRY1:begin if (in) n_state = DATA3_CARRY1;
        else n_state = DATA3_CARRY0; end
        DATA3_CARRY1:n_state = IDLE;                                
        default: n_state = IDLE;
        endcase
    end
    //output always block
    always_comb
    begin
    case (c_state)
    IDLE:begin if ((tx_start==1)&&(in==1)) out=0;
    else if ((tx_start==1)&&(in==0)) out=1;
    else out=1'bx;end
    DATA0_CARRY0: out = in;
    DATA1_CARRY0: out = in;
    DATA2_CARRY0: out = in;
    DATA3_CARRY0: out = 0;
    DATA0_CARRY1: out = ~in;
    DATA1_CARRY1: out = ~in;
    DATA2_CARRY1: out = ~in;
    DATA3_CARRY1: out = 1'b1;
    default: out = 1'bx;
    endcase
    end
endmodule