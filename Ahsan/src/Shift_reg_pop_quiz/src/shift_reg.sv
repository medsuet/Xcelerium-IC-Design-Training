module shift_reg(
    input logic clk,
    input logic rst,
    input logic D,
    output logic A);

logic Q1,Y,B;
//First register
always_ff @( posedge clk or negedge rst ) 
begin
    if (~rst)
       Q1 <= #1 0;
    else
       Q1 <= #1 D;   
end
//logic of and
assign Y = ~Q1;

//second register
always_ff @( posedge clk or negedge rst ) 
begin
    if (~rst)
       B <= #1 0;
    else
       B <= #1 Y;   
end

//third register
always_ff @( posedge clk or negedge rst ) 
begin
    if (~rst)
       A <= #1 0;
    else
       A <= #1 B;   
end

endmodule