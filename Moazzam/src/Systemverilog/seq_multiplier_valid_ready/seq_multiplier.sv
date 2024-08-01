module seq_multiplier
(
    input logic  rst, clk,
    input logic  [15:0] multiplier,
    input logic  [15:0] multiplicant,
    input logic  valid_in,
    output logic ready_in,

    output logic [31:0] product,
    output logic valid_out,
    input logic ready_out
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
logic  pp_clear;

seq_multiplier_con CONTROLLER 
(
    .clk(clk),
    .rst(rst),
    .valid_in(valid_in),
    .count_sh(count_sh),
    .last_bit(last_bit),
    .stop(stop),
    .b_val(b_val),
    .ready_in(ready_in),

    .load_en(load_en),
    .shift_en(shift_en),
    .count_en(count_en),
    .m1_sel(m1_sel),
    .m2_sel(m2_sel),
    .valid_out(valid_out),
    .pp_clear(pp_clear),
    .ready_out(ready_out)
);

//reg of multiplier and multiplicant, 
//output of multiplier is a_c
//multiplicant is parallel input and serial output(b_val)
always_ff @(posedge clk or negedge rst) 
begin
    if(!rst) 
    begin
        a_c <= '0;
        b_c <= '0;
    end
    else if (load_en) 
    begin
        a_c <= multiplier;
        b_c <= multiplicant;    
    end
    else 
    begin
        a_c <= a_c;
        b_c <= b_c;
    end
    
end

// Counter-ff
always_ff @(posedge clk or negedge rst) 
begin
    if      (!rst || !count_en) count <= '0;
    else if (count_en)          count <= count + 1;
    else                        count <= count;      
end

// combinational component
always_comb
begin

    if(shift_en) b_c_out = b_c >> count;
    else         b_c_out = b_c;
    //LSB of output of shifted multiplicant
    b_val = b_c_out[0]; 
    
    //m1_sel is 1 if the lsb of multiplicant is 1
    m1_out = m1_sel ? { {16{a_c[15]}}  , a_c} : 32'h0 ;

    m2_out = m2_sel ? (((~m1_out)+1) << count) : (m1_out << count) ;

    pp_in = pp_out + m2_out;

    count_sh = (count >= 1) || (count <= 15);
    last_bit = (count == 15);
    stop     = (count == 16); 
end

always_ff @(posedge clk or negedge rst) 
begin
    if (!rst || pp_clear ) pp_out <= '0;
    else if (valid_out)    pp_out <= pp_out;  
    else                   pp_out <= pp_in;    
end

always_comb
    product = valid_out ? pp_out : '0 ;

endmodule
