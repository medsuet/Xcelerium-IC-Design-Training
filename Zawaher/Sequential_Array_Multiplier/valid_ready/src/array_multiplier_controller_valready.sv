module array_multiplier_controller_valready (

    input logic     clk,reset,
    input logic     valid_src,counted,get_output,dst_ready,
    output logic    start_tx,counted_15,src_ready,dst_valid

    );
    
    logic [1:0]c_state,n_state;
    parameter S0 = 2'b00 , S1 = 2'b01 , S2 = 2'b10 , S3 = 2'b11 ;

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
            if (valid_src) n_state = S1;
            else n_state = S0;
           end 

           S1 : begin
            if (counted) n_state = S2;
            else n_state = S1;
           end 

           S2 : begin
            if (get_output) n_state = S3;
            else n_state = S2;
           end 
            
           S3 : begin
            if (dst_ready) n_state = S0;
            else n_state = S3;
           end

            default: n_state = S0;

        endcase
        
    end


    //Output always block
    always_comb begin 

        case (c_state)
           
           S0 : begin
            if (valid_src) begin
                start_tx = 1'b1;
                counted_15 = 1'b0;
                dst_valid = 1'b0;
                src_ready = 1'b0; 

           end
           else begin
                start_tx = 1'b0;
                counted_15 = 1'b0;
                dst_valid = 1'b0;
                src_ready = 1'b1; 
 
           end
           end

           S1 : begin
            if (counted) begin
                start_tx = 1'b0;
                counted_15 = 1'b1;
                dst_valid = 1'b0;
                src_ready = 1'b0; 
 
           end
           else begin
                start_tx = 1'b1;
                counted_15 = 1'b0;
                dst_valid = 1'b0;
                src_ready = 1'b0; 
 
           end
           end

    
           S2 : begin
            if (get_output | (get_output && dst_ready)) begin  // if get output and the dst_ready comes at the same time
                start_tx = 1'b0;
                counted_15 = 1'b0;
                dst_valid = 1'b1;
                src_ready = 1'b0; 
 
           end
           else begin
                start_tx = 1'b0;
                counted_15 = 1'b1;
                dst_valid = 1'b0;
                src_ready = 1'b0; 

           end
           end
            
            S3 : begin
            if (dst_ready) begin
                start_tx = 1'b0;
                counted_15 = 1'b0;
                dst_valid = 1'b0;
                src_ready = 1'b1; 
 
           end
           else begin
                start_tx = 1'b0;
                counted_15 = 1'b0;
                dst_valid = 1'b1;
                src_ready = 1'b0; 

           end
           end



            default: begin
                start_tx = 1'b0;
                counted_15 = 1'b0;
                dst_valid = 1'b0;
                src_ready = 1'b1; 
 
            end 

        endcase
        
    end

    
endmodule