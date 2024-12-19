module sequential_adder #(parameter  WIDTH = 4 )(
    input logic [WIDTH - 1:0] number,
    output logic [WIDTH - 1:0] result,
    input logic reset,
    input logic clk
);

logic [1:0] index;
logic goTostart;
logic dataIn;
logic dataout;
// logic [3:0] temp_result;

typedef enum logic [1:0] { 
    start = 2'b00,
    data0 = 2'b01,
    data1 = 2'b10
} states;

states currentState, nextState;

// State register
always_ff @(posedge clk or posedge reset) begin : States
    if (reset) begin
        currentState <= #1 start;
        index <= #1 0;
        // temp_result <= 0;
    end 

    else if (goTostart) begin
        currentState <= #1 start;
        index <= #1 0;
    end
    
    else begin
        currentState <= #1 nextState;
        index <= #1 (currentState == start) ? 0 : index + 1;
    end
end

// Next state logic
always_comb begin : state_logic
    case (currentState)
        start: begin
            // if (index < 2'b11)
            if ((number[index] == 1'b1)) begin
                nextState = data1;
            end
            else begin
                nextState = data0;
            end
            // if (index == 2'b11) begin
            //     nextState = start;
            // end
        end
        data0: begin
            // if (index < 4)
            if ((number[index] == 1'b1)) begin
                nextState = data0;
            end
            else begin
                nextState = data0;
            end
            // if (index == 4) begin
            //     nextState = start;
            // end
        end
        data1: begin
            // iif (index < 4)
            if ((number[index] == 1'b1)) begin
                nextState = data1;
            end
            else begin
                nextState = data0;
            end
            // if (index == 4) begin
            //     nextState = start;
            // end
        end
        default: nextState = start;
    endcase
end

// Output logic
always_comb begin
    case (currentState)
        start: begin
            // if (index < 4) begin
                if (number[index] == 1'b1) begin
                    result[index] = 1'b0;
                    dataIn = 1'b1;
                    dataout = 1'b0;
                end
                else begin
                    result[index] = 1'b1;
                    dataIn = 1'b0;
                    dataout = 1'b1;
                end
            // end
        end
        data0: begin
            // if (index < 4) begin
                if (number[index] == 1'b1) begin
                    result[index] = 1'b1;
                    dataIn = 1'b1;
                    dataout = 1'b1;
                end
                else begin
                    result[index] = 1'b0;
                    dataIn = 1'b0;
                    dataout = 1'b0;
                end
            // end
        end
        data1: begin
            // if (index < 4) begin
                if (number[index] == 1'b1) begin
                    result[index] = 1'b0;
                    dataIn = 1'b1;
                    dataout = 1'b0;
                end
                else begin
                    result[index] = 1'b1;
                    dataIn = 1'b0;
                    dataout = 1'b1;
                end
            // end
        end
        // default: start: result = 4'b0;
    endcase
end

// after completing all bits of a number
always_comb begin : go_to_start_state
    // if 4 bits completed
    if (index == 2'b11) begin
        goTostart = 1'b1;
    end
    else begin
        goTostart = 1'b0;
    end
end

endmodule
