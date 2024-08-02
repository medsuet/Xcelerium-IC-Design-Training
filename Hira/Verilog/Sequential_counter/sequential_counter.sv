module counter(
    input   logic           clk,    // Clock signal
    input   logic           rst,    // Reset signal
    input   logic      bit_number, 
    output  logic      system_output
);

logic [3:0] bit_count;

localparam S0=2'b00;  
localparam S3=2'b11;
localparam S2=2'b10;


logic [1:0] CS,NS;

always_comb begin
    case(CS)
        S0: begin
            if (bit_number==1)begin
                NS=S3;
                end
            else begin
                NS=S2;
            end 
            end
        S3: begin
            if (bit_number==0)begin
                NS=S2;
            end
            else begin
                NS=S3;
            end
            end
        S2: begin
            if (bit_number==0)begin
                NS=S2;
            end
            else begin
                NS=S2;
            end
        end
        default: 
            NS=S0;
    endcase
    
end



always_comb begin
    case(CS)
        S0: begin
            if (bit_number==1)begin
                system_output = 1'b0; // addition with 1
                end
            else begin
                system_output = 1'b1; // addition with 1
            end 
            end
        S3: begin
            if (bit_number==0)begin
                system_output = 1'b1; // addition with previous carry
            end
            else begin
                system_output = 1'b0; // addition with previous carry
            end
            end
        S2: begin
            if (bit_number==0)begin
                system_output = 1'b0; // addition with previous carry
            end
            else begin
                system_output = 1'b1; // addition with previous carry
            end
        end
        default: 
            system_output = 1'b1;
    endcase
    
end




// Sequential logic to update state and carry
always_ff @(posedge clk or posedge rst) begin 
    if (rst | bit_count==4'd3 ) begin
        CS<=S0;
        bit_count <= 0;
    end else begin
        CS<=NS;
        bit_count <= bit_count + 1;
    end
end

endmodule
