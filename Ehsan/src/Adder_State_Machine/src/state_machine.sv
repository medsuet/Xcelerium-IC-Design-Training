module adder_state_machine (
    input logic clk, rst, b,
    output logic a
);
    logic [2:0] c_state, n_state;
    parameter   b0 = 3'b000, 
                b1_c0 = 3'b001, 
                b1_c1 = 3'b010,
                b2_c0 = 3'b011, 
                b2_c1 = 3'b100,
                b3_c0 = 3'b101, 
                b3_c1 = 3'b110;

    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            c_state <= b0;
        end else begin
            c_state <= n_state;
        end
    end
    
    always_comb begin
        case (c_state)
        b0 : 
            if (b==1) begin
                a = 0; 
                n_state = b1_c1;
            end else if(b==0) begin
                a = 1;
                n_state = b1_c0;
            end
        
        b1_c0 : 
            if (b==1) begin
                a = 1;
                n_state = b2_c0;
            end else if(b==0) begin
                a = 0;
                n_state = b2_c0;
            end

        b2_c0 : 
            if (b==1) begin
                a = 1;
                n_state = b3_c0;
            end else if(b==0) begin
                a = 0;
                n_state = b3_c0;
            end

        b3_c0 : 
            if (b==1) begin
                a = 1;
                n_state = b0;
            end else if(b==0) begin
                a = 0;
                n_state = b0;
            end

        b1_c1 : 
            if (b==1) begin
                a = 0;
                n_state = b2_c1;
            end else if(b==0) begin
                a = 1;
                n_state = b2_c0;
            end

        b2_c1 : 
            if (b==1) begin
                a = 0;
                n_state = b3_c1;
            end else if(b==0) begin
                a = 1;
                n_state = b3_c0;
            end

        b3_c1 : 
            if (b==1) begin
                a = 0;
                n_state = b0;
            end else if(b==0) begin
                a = 1;
                n_state = b0;
            end
        
    endcase
    end
endmodule