module restoring_division 
#(
    parameter BITS = 16
) 
(
    input logic clk,rst,

    input logic [BITS-1:0] divisor, //M -- md
    input logic [BITS-1:0] dividend, //Q -- qd
    input logic valid_src,

    output logic [BITS-1:0] reminder,
    output logic [BITS-1:0] quotient,
    output logic valid_des
);

logic [BITS:0] ac;
logic [BITS:0] md;
logic [BITS-1:0] qd;
logic load_en;

logic [(2*BITS):0] ac_qd;
logic [BITS:0] ac_s;
logic [BITS-1:0] qd_s;

logic [BITS:0] ac_p;

logic [BITS:0] ac_in;
logic [BITS-1:0] qd_in;
logic update_en;

logic [$clog2(BITS):0] counter;    
logic counter_en;
logic clear;

logic stop;


restoring_division_con CON (clk,rst,valid_src, stop, load_en, update_en, counter_en, ans_sel, valid_des,clear);



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
            md <= {0,divisor};
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
    stop  = (counter == BITS);
    ac_qd = ({ac, qd}) << 1;
    ac_s  =  ac_qd[((2*BITS)): BITS];
    qd_s  =  ac_qd[BITS-1 : 0];

    ac_p  = ac_s - md;

    case (ac_p[BITS])
        1'b0: 
        begin
            ac_in = ac_p;
            qd_in = qd_s | ({ { (BITS-1){1'b0} }, 1'b1});;
        end

        1'b1: 
        begin
            ac_in = ac_s;
            qd_in = qd_s & ({ { (BITS-1){1'b1} }, 1'b0});
        end

    endcase

    quotient = ans_sel? qd : '0;
    reminder = ans_sel? ac[BITS-1:0] : '0;
end


endmodule