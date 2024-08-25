module counter_4bit(
    input logic clk,
    input logic reset,
    output logic [3:0] count
);

// intermediate signals
logic [3:0] adder_out; // output of adder
logic [3:0] reg_in; // input of counter
logic [3:0] reg_out; // output of counter 
logic comp_out; // output of comparator
 
// adder 
always_comb 
begin
    adder_out = reg_out + 1;
end

// comparator
always_comb
begin
    comp_out = (reg_out == 4'b1101); // check reg_out is equal to 13
end

// mux
always_comb
begin 
    if(comp_out)
    begin
        reg_in = 4'b0000;
    end
    else
    begin
        reg_in = adder_out;
    end
end

// asynchrouns active high reset counter
always_ff @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        reg_out <= #1 4'b0000;
    end
    else
    begin
        reg_out <= #1 reg_in;
    end
end

always_comb
begin
    count = reg_out;
end
endmodule