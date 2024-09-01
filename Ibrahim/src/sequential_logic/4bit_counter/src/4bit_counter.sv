module counter #(
    parameter WIDTH_C = 4,
    parameter MAX_COUNT = 13
) (
    input  logic               clk,    // Clock signal
    input  logic               reset,  // Active-high reset signal

    output logic [WIDTH_C-1:0] reg_out // 4-bit output
);

    logic [WIDTH_C-1:0] reg_val;      // 4-bit register value
    logic [WIDTH_C-1:0] count_up;     // Counter to count till MAX_count
    logic [WIDTH_C-1:0] reg_in;       // The input to the register
    logic               clear;        // Output of the comparator

    // Adder: count_up = count + 1
    always_comb begin
        count_up = reg_val + 1;
    end

    // Comparator: clear is high when count == MAX_count
    always_comb begin
        clear = (reg_val == MAX_COUNT);
    end

    // MUX: select_count is either count_up or 0
    always_comb begin
        if (clear)
            reg_in = {WIDTH_C{1'b0}};
        else
            reg_in = count_up;
    end

    // Asynchronous logic for the counter
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_val <=  {WIDTH_C{1'b0}};  // Reset the register value to 0
        end else begin
            reg_val <=  reg_in;          // Update register value with MUX output
        end
    end

    // Output assignment
    always_comb begin
        reg_out = reg_val;
    end

endmodule
