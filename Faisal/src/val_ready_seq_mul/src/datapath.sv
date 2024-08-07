module Datapath(
    input  logic [15:0] Multiplicand, Multiplier,
    input  logic clk, rst, QR_sel, clear,
    input  logic [1:0] data_sel, // 4x1_mux for data selection 
    output logic [31:0] Product,
    output logic [1:0] in, // 2 bits for Qn and Qn+1 (00-->notthing,01--->add,10--->sub,11--->nothing)
    output logic count_comp // check the counter reach its limit 16 or not
); 

// intermediate signals
logic [31:0] shifted_out, combined_out;
logic [15:0] BR, Accumulator, QR, QR_in, Accumulator_in, data_out;
logic [4:0] count;
logic Q1, Q1_in; // Q1_in--->Qn, Q1---->Qn+1

//Register for Multiplicand
always_ff @( posedge clk or negedge rst) begin
    if (!rst || clear)
    begin
        BR <= #1 0;
    end
    else 
    begin
        BR <=#1  Multiplicand;  
    end    
end

// Register for Multiplier
always_ff @( posedge clk or negedge rst) begin
    if (!rst || clear)
    begin
        QR <=#1 0;  
    end
    else 
    begin
        QR <=#1 QR_in;  
    end    
end

// Register for Q1--> Qn+1
always_ff @( posedge clk or negedge rst) begin
    if (!rst || clear)
    begin
        Q1 <=#1 0;  // initially Qn+1 is zero
    end
    else 
    begin
        Q1 <= #1 Q1_in;  // update the Qn+1 with Qn
    end    
end

// Register for Accumulator and Count
always_ff @( posedge clk or negedge rst) begin
    if (!rst || clear)
    begin
        Accumulator <= #1 0; // initially accumulator is zero
        count<= #1 0;        // initially counter is zero
    end
    else 
    begin
        Accumulator <= #1 Accumulator_in; // update the accumulator
        count<= #1 count + 1;    
    end    
end


// 2x1_mux for Multiplier and Accumulator
always_comb begin
    QR_in = QR_sel ? shifted_out[15:0] : Multiplier; // multiplier register input
    Accumulator_in = QR_sel ? shifted_out[31:16] : 16'b0; // accumulator register input
end

// Combinational logic for in
// in is 2 bit for Qn,Qn+1
always_comb begin
    in = {QR[0], Q1}; // in is 2 bit for Qn,Qn+1
end

// 4x1_mux for data out
always_comb begin
    case (data_sel)
        2'b01: data_out = Accumulator + BR; // Qn,Qn+1 ---> 01
        2'b10: data_out = Accumulator - BR; // Qn,Qn+1 ---> 10
        default: data_out = Accumulator; // Qn,Qn+1 ---> 00,11
    endcase
end

// Combinational logic for concatenating, qin and shifted
always_comb begin
    combined_out = {data_out, QR}; // concatenate the 4x1_mux_out and multiplier
    Q1_in = combined_out[0]; //  update the Qn value
    shifted_out = {combined_out[31], combined_out[31:1]}; // right shift the 32 bit AC and BR by 1
end


// Output signal for counting
assign count_comp = ( count == 16 ) ? 1:0; // check count complete to 16 or not
assign Product = shifted_out; // store the shifted value of 32 bit in product
// always_ff @( posedge clk or negedge rst ) begin : blockName
//     if (!rst) begin
//         Product <=#1 0;
//     end
//     else if(en_pro) begin
//         Product <= #1 shifted_out;
//     end
// end


endmodule