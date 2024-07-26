module sequential_adder #(parameter WIDTH = 4) (
    input logic l,
    input logic m,
    input logic clk,
    input logic reset,
    output logic y
);
//     logic m, l;
//     integer i;
//     logic [WIDTH-1:0] one;
//     logic [WIDTH-1:0] d_reg;
//     always_ff @(posedge clk) begin
//         if (reset) begin
//              one <= 4'b1;
//              d_reg <= d;
//         end else begin
//             d_reg <= {d_reg[WIDTH-1:1], 1'b0};
//             l <= d[0];
//             one <= {one[WIDTH-1:1], 1'b0};
//             m <= one[0];
//         end
//     end
//     logic [WIDTH-1:0] d_reg;
//     logic l, m;
//     logic load_next;
//     integer i;

//     always_ff @(posedge clk) begin
//         if (reset) begin
//             d_reg <= #1 d;
//             l <= #1 0;
//             load_next <= #1 0;
//             m <= #1 0;
//             i <= #1 WIDTH - 1;
//         end else if (i >= 0) begin
//             m <= #1 d_reg[WIDTH -1 - i];
//             l <= #1 1'b1 >> (WIDTH - 1 - i);
//             i <= #1 i - 1;
//         end else if (load_next) begin
//             d_reg <= #1 d;
//             i <= #1 WIDTH - 1;
//             load_next <= #1 0;
//         end
//     end

//     always_ff @(negedge clk) begin
//         if (i < 0) begin
//             load_next <= #1 1'b1; // Indicate to load the next 4-bit number
//         end
//     end

    state_machine_adder SMA1(.clk(clk), .reset(reset), .l(l), .m(m), .y(y));
//     for (int i=0; i<WIDTH; i++) begin 
//          assign m = 1'b1 >> i;
//          state_machine_adder SMA1(.clk(clk), .reset(reset), .l(d[i]), .m(m), .y(y));
//      end

endmodule

module state_machine_adder(
    input logic clk,
    input logic reset,
    input logic l,
    input logic m,
    output logic y
);
    parameter S0 = 0;
    parameter S1 = 1;
    logic CS, NS;

    always_ff @(posedge clk) begin
        if (reset) begin
            CS <= #1 S0;
        end else begin
            CS <= #1 NS;
        end
    end

    always_comb begin
        case (CS)
            S0: begin
                if (m == 0 && l == 0) begin
                    y = 0; 
                end else if ((m == 0 && l == 1) || (m == 1 && l == 0)) begin
                    y = 1; 
                end else if (m == 1 && l == 1) begin
                    y = 0;
                    NS = S1;
                end 
            end

            S1: begin
                if (m == 0 && l == 0) begin
                    y = 1;
                    NS = S0;
                end else if (m == 1 && l == 0) begin
                    y = 0;
                end else begin
                    y = 0;
                end 
            end
        endcase
    end
    
endmodule


// module half_adder(
//     input logic a,
//     input logic b,
//     output logic sum,
//     output logic carry
// );
// 
//     xor(sum, a, b);
//     and(carry, a, b);
// 
// endmodule
