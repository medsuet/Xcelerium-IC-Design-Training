
`include "../param/sb_defs.svh"

module priority_encoder_high_8bit (
    input logic [7:0] in,
    output logic [2:0] out
);
    always_comb begin
        casex (in)
            'b1xxxxxxx: out = 'h7; 
            'b01xxxxxx: out = 'h6;
            'b001xxxxx: out = 'h5;
            'b0001xxxx: out = 'h4;
            'b00001xxx: out = 'h3;
            'b000001xx: out = 'h2;
            'b0000001x: out = 'h1;
            'b00000001: out = 'h0;
            default:    out = 'h0;
        endcase
    end
endmodule

module priority_encoder_low_8bit (
    input logic [7:0] in,
    output logic [2:0] out
);
    always_comb begin
        casex (in)
            'b10000000: out = 'h7;
            'bx1000000: out = 'h6; 
            'bxx100000: out = 'h5;
            'bxxx10000: out = 'h4;
            'bxxxx1000: out = 'h3;
            'bxxxxx100: out = 'h2;
            'bxxxxxx10: out = 'h1;
            'bxxxxxxx1: out = 'h0;
            default:    out = 'h0;
        endcase
    end
endmodule
