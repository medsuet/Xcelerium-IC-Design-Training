module restoring_division  
(
    input logic clk,rst,

    input logic [16-1:0] divisor, //M -- md
    input logic [16-1:0] dividend, //Q -- qd
    input logic valid_src,

    output logic [16-1:0] reminder,
    output logic [16-1:0] quotient,
    output logic valid_des
);

logic [16:0] ac;
logic [16:0] md;
logic [16-1:0] qd;
logic load_en;
logic sel;
logic [(2*16):0] ac_qd;
logic [16:0] ac_s;
logic [16-1:0] qd_s;

logic [16:0] ac_p;

logic [16:0] ac_in;
logic [16-1:0] qd_in;
logic update_en;

logic [$clog2(16):0] counter;    
logic counter_en;
logic clear;

logic stop;


restoring_division_con CON (clk,rst,valid_src, stop, load_en, update_en, counter_en, ans_sel, valid_des,clear);

//assert (divisor == 0) else $fatal("Maths error! no number is divided by zero.");


always_ff @(posedge clk or negedge rst) 
begin
    if(!rst )
    begin
        ac <= '0;
        md <= '0;
        qd <= '0;
    end
    else 
    begin
        if (load_en) 
        begin
            ac <= '0;
            md <= {1'b0,divisor};
            qd <= dividend;
        end
        else if (update_en) 
        begin
            ac <= ac_in;
            qd <= qd_in;
        end
        else
        begin
            ac <= ac;
            md <= md;
            qd <= qd;
        end
    end

    if (!rst || clear)               counter <= '0;
    else if (counter_en)    counter <= counter + 1;
    else                    counter <= counter;
end

always_comb begin
    stop  = (counter == 16);
    ac_qd = ({ac, qd}) << 1;
    ac_s  =  ac_qd[32: 16];
    qd_s  =  ac_qd[16-1 : 0];

    ac_p  = ac_s - md;

    sel = ac_p[16];
    case (sel)
        1'b0: 
        begin
            ac_in = ac_p;
            qd_in = qd_s | 16'h0001;
        end

        1'b1: 
        begin
            ac_in = ac_s;
            qd_in = qd_s & 16'hfffe;
        end

    endcase

    quotient = ans_sel? qd : '0;
    reminder = ans_sel? ac[16-1:0] : '0;
end


endmodule