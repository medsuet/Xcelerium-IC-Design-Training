module posedge_detector (
    input logic clk, rst, data,
    output logic detect_signal
);
logic c_state, n_state;
parameter zero = 0, one = 1;

always_ff @( posedge clk or negedge rst ) begin 
    if (!rst) begin
        c_state <= zero;
    end
    else begin
        c_state <= n_state;
    end
end

always_comb begin
    case (c_state)
    zero: begin
        if (data == 0) begin
            detect_signal = 0;
            n_state = zero;            
        end
        else if (data == 1) begin
            detect_signal = 1;
            n_state = one;            
        end
    end
    one: begin
        if (data == 1) begin
            detect_signal = 0;
            n_state = one;            
        end
        else if (data == 0) begin
            detect_signal = 0;
            n_state = zero;            
        end
    end
    endcase

end



endmodule
