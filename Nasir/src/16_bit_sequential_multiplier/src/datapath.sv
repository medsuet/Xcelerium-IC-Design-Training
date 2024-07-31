module datapath(
    input logic signed [15:0] multiplicand,multiplier,
    input logic clk,reset,enable,count16,
    input logic [1:0] selectAccumulator,
    input logic selectMultiplier,
    output logic [1:0] operation,
    output logic [31:0] product
); 


// intermediate signals
logic [31:0] shiftedData, combinedData;
logic [15:0] M, Accumulator, QRegister, QRegister_in, Accumulator_in, data_out;
logic [4:0] count;
logic Qnext, Qn; // Qn--->Qnext, Qnext---->Qnext+1

//Register for multiplicand
always_ff @( posedge clk or negedge reset) begin
    if (!reset || !enable)
    begin
        M <= 0;
    end
    else 
    begin
        M <= multiplicand;  
    end    
end

// Register for multiplier
always_ff @( posedge clk or negedge reset) begin
    if (!reset || !enable)
    begin
        QRegister <= 0;  
    end
    else 
    begin
        QRegister <= QRegister_in;  
    end    
end

// Register for Qnext--> Qnext+1
always_ff @( posedge clk or negedge reset) begin
    if (!reset || !enable)
    begin
        Qnext <= 0;  // initially Qnext is zero
    end
    else 
    begin
        Qnext <= Qn;  // update the Qnext with Qn
    end    
end

// Register for Accumulator and Count
always_ff @( posedge clk or negedge reset) begin
    if (!reset || !enable)
    begin
        Accumulator <= 0; // initially accumulator is zero
        count<= 0;        // initially counter is zero
    end
    else 
    begin
        Accumulator <= Accumulator_in; // update the accumulator
        count<= count + 1;    
    end    
end


// 2x1_mux for multiplier and Accumulator
always_comb begin
    QRegister_in = selectMultiplier ? shiftedData[15:0] : multiplier; // multiplier register input
    Accumulator_in = selectMultiplier ? shiftedData[31:16] : 16'b0; // accumulator register input
end

// Combinational logic for operation
// operation is 2 bit for Qnext,Qnext+1
always_comb begin
    operation = {QRegister[0], Qnext}; // operation is 2 bit for Qnext,Qnext+1
end

// 4x1_mux for data out
always_comb begin
    case (selectAccumulator)
        2'b01: data_out = Accumulator + M; // Qnext,Qnext+1 ---> 01
        2'b10: data_out = Accumulator - M; // Qnext,Qnext+1 ---> 10
        default: data_out = Accumulator; // Qnext,Qnext+1 ---> 00,11
    endcase
end

// Combinational logic for concatenating, qin and shifted
always_comb begin
    combinedData = {data_out, QRegister}; // concatenate the 4x1_mux_out and multiplier
    Qn = combinedData[0]; //  update the Qnext value
    shiftedData = {combinedData[31], combinedData[31:1]}; // right shift the 32 bit AC and M by 1
end


// Output signal for counting
assign count16 = ( count == 16 ) ? 1:0; // check count complete to 16 or not
assign product = shiftedData; // store the shifted value of 32 bit operation product


endmodule