module Data_path (
    input logic clk,
    input logic reset,
    input logic enReg,
    input logic enShift,
    input logic enCount,
    input logic mux_sel,
    input logic clear,
    input logic [31:0] Q,
    input logic [31:0] M,
    output logic [31:0] Quotient,
    output logic [31:0] Remainder,
    output logic [5:0] count,
    output logic [32:0] regA_next
);

    logic [31:0] regQ;
    logic [32:0] regA, regM;
    logic [63:0] regAQ;
    logic regQ0_next;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            regAQ <= 64'b0;
            regM <= 33'b0;
            count <= 6'b0;
        end else begin
            if (enReg) begin
                regM <= {1'b0, M};
                // Handle case when Q < M
                if (Q < M) begin
                    regAQ <= {32'b0, Q};  // Initialize regAQ with Q in the lower 32 bits
                    regQ <= 32'b0;        // Quotient should be 0
                    regA <= {1'b0, Q};    // Remainder should be Q
                end else begin
                    regAQ <= {32'b0, Q};  // Initialize regAQ with Q in the lower 32 bits
                end
                count <= 6'b0;
            end else begin
                if (enShift) begin
                    regAQ <= {regA, regQ} << 1;
                end
                if (enCount) begin
                    count <= count + 1;
                end
            end
        end
    end

    always @(*) begin
        regA_next = regAQ[63:32] - regM;
        if (regA_next[32] == 1'b0) begin  // If subtraction did not result in a negative number
            regA = regA_next;
            regQ = regAQ[31:0] | 1;  // Set the LSB of regQ
        end else begin
            regA = regAQ[63:32];
            regQ = regAQ[31:0];
        end
    end

    assign {Quotient, Remainder} = clear ? {regQ, regA[31:0]} : 64'b0;

endmodule
