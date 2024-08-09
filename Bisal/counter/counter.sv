module counter(
    input logic clk,
    input logic reset,
    output logic clear,
    output logic [3:0] count

);
    logic [3:0] d;
    always_comb begin
	d=count+1;
	if(count == 4'd13) begin
		clear=1;
	end
	else begin
		clear=0;
	end
	if (clear) begin
		d = 0; 
	end
	else begin 
		d = d;
	end
    end 

    always_ff @( posedge clk or posedge reset) begin 
        if(reset) begin
            count <= #1 0;
        end
        else begin
            count<=#1 d;
        end
    end
endmodule