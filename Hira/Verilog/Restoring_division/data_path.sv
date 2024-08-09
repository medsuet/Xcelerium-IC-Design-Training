module Datapath_Restoring_Division (
    input  logic        clk,
    input  logic        rst,
    input  logic        enable_count,
    input  logic        enable_registers,

    input  logic             selc_A,
    
    output logic        done,
    output logic        temp,
    input  logic [31:0] dividend,
    input  logic [31:0] divisor,
    output logic [31:0] quotient,
    output logic [31:0] remainder
);
/*
    Main idea is first it shifts the registers
    then in the next cycle it goes for subtracting and 
    then comparing of MSB
*/

    logic [31:0] reg_accumulator;
    logic [31:0] reg_quotient;
    logic [5:0]  count; 

    always@(*) begin
        //For subtracting and restoring
        if (enable_registers) begin
            reg_accumulator=0;
            reg_quotient=dividend;
        end else 
            if (selc_A) begin
            reg_quotient=quotient;
            reg_accumulator=remainder - divisor;
            if(reg_accumulator[31]==1) begin
                reg_quotient[0] = 1'b0;
                reg_accumulator=remainder;
            end else begin
                reg_quotient[0] = 1'b1;
                end
            end
        end 



    // Main 
    always_ff @(posedge clk or posedge rst) begin
        //This is the shifting
        if (rst) begin
            quotient  <= 0;
            remainder <= 0;
            temp<=0;
            count           <= 3'b0;
            done            <= 1'b0;
        end else if (enable_registers) begin
            quotient  <= dividend;
            temp<=0;
            remainder <= 0;
            count           <= 6'd32; 
            done            <= 1'b0;
        end else if (enable_count) begin
            if (count > 0) begin
                quotient  <= {reg_quotient[30:0],1'b0};
                remainder <= {reg_accumulator[30:0], reg_quotient[31]};
                temp<=1;
                count <= count - 1;
            end else begin
                done <= 1'b1;
                temp<=0;
                quotient  <= reg_quotient;
                remainder <= reg_accumulator;
            end
        end
    end

endmodule







