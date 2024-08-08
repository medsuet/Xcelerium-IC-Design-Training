module datapath(
    input logic CLK,
    input logic RST,
    input logic START,
    input logic [15:0] A,
    input logic [15:0] M,
    input logic [15:0] Q,
    //input logic [3:0] N,
    output logic READY,
    output logic [15:0] QUOTIENT,
    output logic [15:0] REMAINDER
);

logic a_val;
logic STOP;
logic mux_sel;
logic en_A;
logic en_M;
//logic en_N;
logic en_Q;
logic [4:0] count = 5'd16;
logic [15:0] reg_A;
logic [15:0] reg_M;
logic [15:0] reg_Q;
//logic [3:0] reg_N;
logic CLEAR;
//logic QUOTIENT = 1'd0;
//logic REMAINDER = 1'd0;
//logic [3:0] D;
logic [15:0] updated_A;
logic [15:0] updated_Q;
logic [15:0] new_updated_A;
logic [31:0] AQ;
logic count_en;

// Instantiate the controller
controller controller(
    .RST(RST),
    .CLK(CLK),
    .START(START),
    .STOP(STOP),
    .a_val(a_val),
    .en_A(en_A),
    .en_M(en_M),
    //.en_N(en_N),
    .en_Q(en_Q),
    .mux_sel(mux_sel),
    .CLEAR(CLEAR),
    .count_en(count_en),
    .READY(READY)
);

assign STOP = (count == 5'b00000);
// Sequential block for register updates
always_ff @(posedge CLK or negedge RST) 
begin
    if(!RST)
    begin
        reg_A <= #1 16'd0;
        reg_M <= #1 16'd0;
        reg_Q <= #1 16'd0;
        //QUOTIENT <= #1 1'd0;
        //REMAINDER <= #1 1'd0;
    end
    else 
    begin
        if(en_A)
        begin
            reg_A <= #1 A;
        end
        else
        begin
            reg_A <= #1 new_updated_A;
        end
        if(en_M)
        begin
            reg_M <= #1 M;
        end
        if(en_Q)
        begin
            reg_Q <= #1 Q;
        end
        else
        begin
            reg_Q <= #1 updated_Q;
        end
    end
end
//always_comb
//begin
//    AQ = {reg_A,reg_Q}<<1;
//    updated_A = AQ[31:16];
//    updated_Q = AQ[15:0];
//    new_updated_A = updated_A - reg_M;   
//    a_val = new_updated_A[15];
//end

//assign AQ = {reg_A,reg_Q}<<1;
//assign updated_A = AQ[31:16];
//assign updated_Q = AQ[15:0];
//assign new_updated_A = updated_A - reg_M;   
//assign a_val = new_updated_A[15];
always_comb 
begin
    AQ = {reg_A,reg_Q}<<1;
    updated_A = AQ[31:16];
    updated_Q = AQ[15:0];
    new_updated_A = updated_A - reg_M;   
    a_val = new_updated_A[15];
    if(mux_sel)
    begin
        updated_Q[0] = 1'b0;
        new_updated_A = updated_A; 
    end
    else
    begin
        updated_Q[0] = 1'b1;
    end
end


always_ff @(posedge CLK or negedge RST) 
begin
    if(!RST)
    begin
        count <= #1 5'd16;
    end
    else if(count_en)
    begin
        count <= #1 count-1;
    end
end

always_comb 
begin
    if(READY)
    begin
        QUOTIENT = updated_Q;
        REMAINDER = new_updated_A;
    end
end

endmodule
