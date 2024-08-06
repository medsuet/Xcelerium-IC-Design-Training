module array_multiplier_controller (

    input logic     clk,reset,
    input logic     start,counted,get_output,
    output logic    start_tx,counted_15,ready

    );
    
    logic [1:0]c_state,n_state;
    parameter S0 = 2'b00 , S1 = 2'b01 , S2 = 2'b10;

    //State Register
    always_ff @( posedge clk or negedge reset  ) begin 
        
        if (!reset)begin
            c_state <= S0;
        end
        else begin
            c_state <= n_state;
        end
    end

    //Next State always block
    always_comb begin  

        case (c_state)
           S0 : begin
            if (start) n_state = S1;
            else n_state = S0;
           end 

           S1 : begin
            if (counted) n_state = S2;
            else n_state = S1;
           end 

           S2 : begin
            if (get_output) n_state = S0;
            else n_state = S2;
           end 

            default: n_state = S0;

        endcase
        
    end


    //Output always block
    always_comb begin 

        case (c_state)
           
           S0 : begin
            if (start) begin
                start_tx = 1'b1;
                counted_15 = 1'b0;
                ready = 1'b0; 
           end
           else begin
                start_tx = 1'b0;
                counted_15 = 1'b0;
                ready = 1'b0; 
           end
           end

           S1 : begin
            if (counted) begin
                start_tx = 1'b0;
                counted_15 = 1'b1;
                ready = 1'b0; 
           end
           else begin
                start_tx = 1'b1;
                counted_15 = 1'b0;
                ready = 1'b0; 
           end
           end


           S2 : begin
            if (get_output) begin
                start_tx = 1'b0;
                counted_15 = 1'b0;
                ready = 1'b1; 
           end
           else begin
                start_tx = 1'b0;
                counted_15 = 1'b1;
                ready = 1'b0; 
           end
           end



            default: begin
                start_tx = 1'b0;
                counted_15 = 1'b0;
                ready = 1'b0;
            end 

        endcase
        
    end

    
endmodule