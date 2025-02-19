module decimator_tb;

    // Parameters
    parameter DELAY_SIZE = 32;
    parameter TAP_SIZE = 16;
    parameter ARRAY_SIZE = 16;
    parameter  FRAC_BITS = 8;
    // Inputs
    logic clk;
    logic reset;
    logic [31:0] new_sample;
    logic valid_in;
    logic [66:0] decimated_output[0:15];
    logic output_valid;
    real num[0:15];
    logic WAIT;
    

    // Instantiate the Unit Under Test (UUT)
    decimator  uut (
        .clk(clk),
        .rst(reset),
        .new_sample(new_sample),
        .valid_in(valid_in),
        .decimated_output(decimated_output),
        .output_valid(output_valid),
        .WAIT(WAIT)
  
    );
 
    parameter data_width = 32;
    parameter array_size = 16;
    
   // int num_values; 
    int svInputs;
    int svOutputs;
    int status;
    string line;
   // logic [data_width-1:0] parsed_values [0:array_size-1]; // Array to hold parsed values from a line
    int parsed_value;
    
    int space_index;
    logic [4:0] valid_count; 
   
    // Clock generation
    initial begin
        
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    initial begin
        svInputs = $fopen("build/input_file.txt", "r");
        if (svInputs == 0) begin
            $display("Error: Failed to open file!");
          //  $finish;
        end
        reset = 1; 
        valid_in=0;
        new_sample = 0;
        valid_count = 5'd0;
        #20;     
        reset = 0;

         // Process file line by line
        while (!$feof(svInputs)) begin
            line = "";
            status = $fgets(line, svInputs); // Read a line from the file
            if (status) begin
             wait(!WAIT);
             $sscanf(line, "%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f" ,num[0],num[1],num[2],num[3],num[4],num[5],num[6],num[7],num[8],num[9],num[10],num[11],num[12],num[13],num[14],num[15]);
               for (int i=0;i<ARRAY_SIZE;i++) begin         
             
                    @(posedge clk);               
                    new_sample = num[i] * (2**FRAC_BITS);                
                    valid_in = 1; 
                    @(posedge clk); valid_in=0;
               
              end
                @(posedge clk);                
            end
        end
        // Close the file
        $fclose(svInputs);
       $display("File processing completed.");        
    end
   
    initial begin 
        // Open the file in write mode
        svOutputs = $fopen("build/sv_outputs.txt", "w");
        if (svOutputs == 0) 
            $display("Error: Could not open file for writing.");  
        if(!$feof(svInputs) && output_valid) begin 
            $display("Outputs written to output_file.txt");
            $fclose(svOutputs);
        end
    end
       

    // Monitor output
    always_ff@(posedge clk) begin
        
                  
        if(output_valid) begin
            
             /// save results to file
             $fwrite(svOutputs, "[");
             for (int i = 0; i <= 15; i++) begin
                     if (i < 15)  $fwrite(svOutputs, "%0f ", real'(decimated_output[i])/( 2**FRAC_BITS)); // Write each element with a space
                     else        $fwrite(svOutputs, "%0f", real'(decimated_output[i])/( 2**FRAC_BITS));  // No trailing space for the last element
              end
              $fwrite(svOutputs, "]\n");   
                           
        end
       
    end

endmodule

