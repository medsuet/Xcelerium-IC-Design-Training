module seq_multiplier
(
    input logic  [15:0] A,
    input logic  [15:0] B,
    input logic  START,
    input logic  RST, CLK,
    output logic [31:0] PRODUCT,
    output logic READYO
);


logic  [15:0] a_c;
logic  [15:0] b_c;
logic  [15:0] b_c_out;
logic  [31:0] m1_out;
logic  [31:0] m2_out;
logic  [31:0] pp_in;
logic  [31:0] pp_out;
logic  [ 4:0] count;
logic  b_val;
logic  load_en;
logic  shift_en;
logic  count_en;
logic  m1_sel;
logic  m2_sel;
logic  count_sh;
logic  last_bit;
logic  stop    ;

seq_multiplier_con CONTROLLER 
(
    .CLK(CLK),
    .RST(RST),
    .START(START),
    .count_sh(count_sh),
    .last_bit(last_bit),
    .stop(stop),
    .b_val(b_val),

    .load_en(load_en),
    .shift_en(shift_en),
    .count_en(count_en),
    .m1_sel(m1_sel),
    .m2_sel(m2_sel),
    .READYO(READYO)
);

//reg of A and B, 
//output of A is a_c
//B is parallel input and serial output(b_val)
always_ff @(posedge CLK or negedge RST) 
begin
    if(!RST) 
    begin
        a_c <= '0;
        b_c <= '0;
    end
    else if (load_en) 
    begin
        a_c <= A;
        b_c <= B;    
    end
    else 
    begin
        a_c <= a_c;
        b_c <= b_c;
    end
    
end

// Counter-ff
always_ff @(posedge CLK or negedge RST) 
begin
    if      (!RST || !count_en) count <= '0;
    else if (count_en)          count <= count + 1;
    else                        count <= count;      
end

// combinational component
always_comb
begin

    if(shift_en) b_c_out = b_c >> count;
    else         b_c_out = b_c;
    //LSB of output of shifted B
    b_val = b_c_out[0]; 
    
    //m1_sel is 1 if the lsb of B is 1
    m1_out = m1_sel ? { {16{a_c[15]}}  , a_c} : 32'h0 ;

    m2_out = m2_sel ? (((~m1_out)+1) << count) : (m1_out << count) ;

    pp_in = pp_out + m2_out;

    count_sh = (count >= 1) || (count <= 15);
    last_bit = (count == 15);
    stop     = (count == 16); 
end

always_ff @(posedge CLK or negedge RST) 
begin
    if (!RST || READYO ) pp_out <= '0;  
    else                 pp_out <= pp_in;    
end

always_comb
    PRODUCT = READYO ? pp_out : '0 ;




endmodule