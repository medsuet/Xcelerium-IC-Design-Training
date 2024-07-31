module Datapath(
    input  logic [15:0] Multiplicand, Multiplier,
    input  logic clk, rst, QR_sel, clear,
    input  logic [1:0] data_sel,
    output logic [31:0] Product,
    output logic [1:0] in,
    output logic count_comp
);

// intermediate signals
logic [31:0] shifted_out, combined_out;
logic [15:0] M, A, Q, Q_in, A_in, data_out;
logic [4:0] count;
logic Q1, Q1_in;

//Register for Multiplicand
always_ff @( posedge clk or negedge rst) begin
    if (!rst || clear)
    begin
        M <= 0;
    end
    else 
    begin
        M <= Multiplicand;  
    end    
end

// Register for Multiplier
always_ff @( posedge clk or negedge rst) begin
    if (!rst || clear)
    begin
        Q <= 0;
    end
    else 
    begin
        Q <= Q_in;  
    end    
end

// Register for Q1
always_ff @( posedge clk or negedge rst) begin
    if (!rst || clear)
    begin
        Q1 <= 0;
    end
    else 
    begin
        Q1 <= Q1_in;  
    end    
end

// Register for Count
always_ff @( posedge clk or negedge rst) begin
    if (!rst || clear)
    begin
        count<= 0;
    end
    else 
    begin
        count<= count + 1;    
    end    
end

// Register for Accumulator
always_ff @( posedge clk or negedge rst) begin
    if (!rst || clear)
    begin
        A <= 0;
    end
    else 
    begin
        A <= A_in;   
    end    
end


// Combinational logic for Multiplier and Accumulator
always_comb begin
    Q_in = QR_sel ? shifted_out[15:0] : Multiplier;
    A_in = QR_sel ? shifted_out[31:16] : 16'b0;
end

// Combinational logic for in
always_comb begin
    in = {Q[0], Q1};
end

// Combinational logic for data out
always_comb begin
    case (data_sel)
        2'b01: data_out = A + M;
        2'b10: data_out = A - M;
        default: data_out = A; 
    endcase
end

// Combinational logic for concatenating, qin and shifted
always_comb begin
    combined_out = {data_out, Q};
    Q1_in = combined_out[0];
    shifted_out = {combined_out[31], combined_out[31:1]};
end


// Output signal for counting
assign count_comp = ( count == 16 ) ? 1:0;

assign Product = shifted_out;


endmodule

