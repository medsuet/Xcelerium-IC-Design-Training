module counter_4bit #(
    parameter int MAX_COUNT = 13
) (
    input logic clk,
    input logic rst,
    output logic [3:0] count
);
    logic [3:0] next_count;       //output of mux
    logic [3:0] add_result;       //output of adder
    logic compare_result;         //output of comparator

    
    always_ff @(posedge clk or negedge rst) 
    begin
        if (!rst)
            count <= #1 4'b0000;  
        else
            count <= #1 next_count; 
    end

    // 4-bit Adder
    assign add_result = count + 4'b0001;

    // Comparator to check if the count is equal to MAX_COUNT
    assign compare_result = (count == MAX_COUNT);

    // Multiplexer to select the next count value
    always_comb begin
        if (compare_result)
            next_count = 4'b0000; 
        else
            next_count = add_result; 
    end

    

endmodule
