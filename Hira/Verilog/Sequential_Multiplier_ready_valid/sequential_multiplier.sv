
module datapath (
    input   logic             clk,         
    input   logic             rst,         
    input   logic             load,         
    input   logic             calc,           
    input   logic   [15:0]    A,      
    input   logic   [15:0]    B,      
    output  logic   [31:0]    product, 
    output  logic             done        
);

    logic [31:0] product_reg;
    //reg [31:0] extended_B;
    logic [4:0]  bit_index;
    logic [31:0] partial_product;
    int WIDTH=16;

always_comb begin
    if (calc) begin
        //SHIFT THE PARTIAL PRODUCTS AND DO THE SIGN EXTENSION
        if (B[bit_index]) begin
            partial_product = A;
        end else begin
            partial_product = 0;
        end
        partial_product[(WIDTH-1)]= ~partial_product[(WIDTH-1)];
        if (bit_index==(WIDTH-1))begin
            partial_product = ~partial_product;
        end
        //$display("%b",partial_product);
        partial_product = partial_product << bit_index;
        product_reg = product_reg + partial_product;
        if (bit_index == WIDTH-1) begin 
            product_reg = product_reg + 32'h10000; 
            //$display("%b",product_reg); 
        end
        
    end
    else begin
        partial_product = 0;
        product_reg=0;

    end
end 





always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        product <= 0;
        done <= 0;
        bit_index <= 0;
    end else begin
        if (load) begin
            product <= 0;
            //extended_B<={ {16{A[15]}}, B };
            bit_index <= 0;
            done <= 0;
        end else 
            if (calc) begin
                bit_index <= bit_index + 1;
                if (bit_index == WIDTH-1) begin 
                    product <= product_reg;
                    done <= 1;
                end
            end 
        end
    end
endmodule




