//==============Author: Masooma Zia==============
//==============Date: 23-07-2024==============
//==============Description:Test bench for 16-bit Binary Multiplier(Array Multiplier)==============
/* verilator lint_off UNOPTFLAT */
`include "halfAdder.sv"
`include "fullAdder.sv"

//===================================Multiplier===================================
module multiplier(input logic [15:0] a, input logic [15:0] b, output logic [31:0] pro);
    reg sum1;
    reg [31:0] carry[31:0];
    reg [31:0] sum[31:0];
    //column 0
    assign pro[0] = a[0] & b[0];
    //column 1
    halfAdder HA(.bit1(a[1] & b[0]), .bit2( a[0] & b[1]), .sum(pro[1]), .carry(carry[0][0]));
    //column 2
    fullAdder FA(.bit1(a[2] & b[0]), .bit2(a[1] & b[1]), .carry_in(carry[0][0]), .sum(sum1), .carry_out(carry[1][0]));
    halfAdder HA1(.bit1(a[0] & b[2]), .bit2(sum1), .sum(pro[2]), .carry(carry[1][1])); 
    //column 15
        generate
            genvar i,j;
            for (i=3;i<16;i++) begin
                if (i==15) begin
                    fullAdder FA0(.bit1(~(a[i] & b[0])), .bit2(a[i-1] & b[1]), .carry_in(carry[i-2][0]), .sum(sum[i][0]), .carry_out(carry[i-1][0]));
                end else begin
                    fullAdder FA1(.bit1(a[i] & b[0]), .bit2(a[i-1] & b[1]), .carry_in(carry[i-2][0]), .sum(sum[i][0]), .carry_out(carry[i-1][0]));
                end
                for (j=2;j<i;j++) begin
                    fullAdder FA2(.bit1(a[i-j] & b[j]), .bit2(sum[i][j-2]), .carry_in(carry[i-2][j-1]), .sum(sum[i][j-1]), .carry_out(carry[i-1][j-1]));
                end
            if (i==15) begin
                halfAdder HA2(.bit1(~(a[0] & b[i])), .bit2(sum[i][i-2]), .sum(pro[i]), .carry(carry[i-1][i-1]));
            end else begin
                halfAdder HA3(.bit1(a[0] & b[i]), .bit2(sum[i][i-2]), .sum(pro[i]), .carry(carry[i-1][i-1])); 
            end
            end
        endgenerate
        //column 16
        fullAdder FA3(.bit1(~(a[15] & b[1])), .bit2(1'b1), .carry_in(carry[14][0]), .sum(sum[16][0]), .carry_out(carry[15][0]));
        generate
            genvar x;
            for (x=15;x>1;x--) begin
                    if (x==2) begin
                        fullAdder FA4(.bit1(~(a[x-1] & b[17-x])), .bit2(sum[16][15-x]), .carry_in(carry[14][16-x]), .sum(pro[16]), .carry_out(carry[15][16-x]));
                    end else begin
                        fullAdder FA5(.bit1(a[x-1] & b[17-x]), .bit2(sum[16][15-x]), .carry_in(carry[14][16-x]), .sum(sum[16][16-x]), .carry_out(carry[15][16-x]));
                    end
            end
           
        endgenerate
        
        //column 17
        fullAdder FA13(.bit1(~(a[15] & b[2])), .bit2(carry[15][0]), .carry_in(carry[15][1]), .sum(sum[17][0]), .carry_out(carry[16][0]));
        generate
            genvar w;
            for (w=0;w<13;w++) begin
                    if (w==12) begin
                        fullAdder FA7(.bit1(~(a[14-w] & b[w+3])), .bit2(sum[17][w]), .carry_in(carry[15][w+2]), .sum(pro[17]), .carry_out(carry[16][w+1]));
                    end else begin
                        fullAdder FA8(.bit1(a[14-w] & b[w+3]), .bit2(sum[17][w]), .carry_in(carry[15][w+2]), .sum(sum[17][w+1]), .carry_out(carry[16][w+1]));
                    end
            end
           
        endgenerate
        //column 18-29
        generate
            genvar z,v;
        for (z=0;z<12;z++) begin
                fullAdder FA9(.bit1(~(a[15] & b[z+3])), .bit2(carry[z+16][0]), .carry_in(carry[z+16][1]), .sum(sum[z+18][0]), .carry_out(carry[z+17][0]));
                for (v=14;v>(z+2);v--) begin
                    if (v==z+3) begin
                        fullAdder FA10(.bit1(~(a[v] & b[(18-v)+z])), .bit2(sum[z+18][14-v]), .carry_in(carry[z+16][16-v]), .sum(pro[z+18]), .carry_out(carry[z+17][15-v]));
                    end else begin
                        fullAdder FA12(.bit1(a[v] & b[(18-v)+z]), .bit2(sum[z+18][14-v]), .carry_in(carry[z+16][16-v]), .sum(sum[z+18][15-v]), .carry_out(carry[z+17][15-v]));
                end
        end
        end
        endgenerate
        //column 30
        fullAdder FA14(.bit1(a[15] & b[15]), .bit2(carry[28][0]), .carry_in(carry[28][1]), .sum(pro[30]), .carry_out(carry[29][0]));
        //column 31
        halfAdder HA4(.bit1(1'b1), .bit2(carry[29][0]), .sum(pro[31]), .carry(carry[30][0])); 

endmodule
/* verilator lint_on UNOPTFLAT */