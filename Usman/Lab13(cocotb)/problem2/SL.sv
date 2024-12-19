module SL(input logic clk,input logic [31:0]A,Q, output logic [31:0] AM,QM);
logic [63:0] conc;
always_ff@(posedge clk) 
begin
    conc = {A,Q};
    conc = conc<<1;
    QM = conc[31:0];
    AM = conc[63:32];
end
endmodule