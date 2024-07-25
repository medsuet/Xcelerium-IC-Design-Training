module Add1_tb();
    
    parameter NUMBITS = 4;

    logic clk, reset;
    logic input_bit, output_bit;
    logic [(NUMBITS-1):0]input_number, output_number;

    Add1 UUT(clk, reset, input_bit, output_bit);

    // Generate clock
    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    // Write test commands here
    initial begin
        all_num_tests();
    end

    // Tests Add1 module on argument input_number
    task test(logic [(NUMBITS-1):0]input_number);
        reset_sequence();                               // Reset Add1 module to start inputting new number

        for (int i=0; i<=(NUMBITS-1); i++) begin        // Loop over all bits of the number, starting from LSB
            input_bit = input_number[i];                // Input each bit of input_number to Add1 module in turn
            @(posedge clk);                             // Output is available at next clock edge
            output_number[i] = output_bit;              // Get output (incremented number)
        end

        if (output_number !== (input_number+4'b1)) begin   // Check if output is correct
            $display("Not correct");
        end
    endtask

    // Tests Add1 module on all possible numbers in NUMBITS
    // Display the input and output numbers
    task all_num_tests();
        for (input_number=0; input_number<4'b1111; input_number++) begin
            test(input_number);
            $display("Input: %d \tOutput: %d", input_number, output_number);
        end
    endtask

    // Resets Add1 module to start inputting new number
    task reset_sequence();
        reset = 1;
        @(posedge clk)
        reset = 0;
    endtask

endmodule