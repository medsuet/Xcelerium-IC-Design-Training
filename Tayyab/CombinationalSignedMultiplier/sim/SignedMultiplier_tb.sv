/*
    Name: SignedMultiplier16_tb.sv
    Author: Muhammad Tayyab
    Date: 23-7-2024
    Description: Testbench for SignedMultiplier16() module
*/

module SignedMultiplier_tb();
    parameter NumRandTests = 1e2;
    parameter RandomTestFlag = 1;
    parameter Num1=0, Num2=0;

    logic [15:0]numA=-1, numB=1;
    logic [15:0]correct_upper, correct_lower, test_upper, test_lower;
    logic [31:0]correct;
    int i;

    SignedMultiplier #(16) UUT
    (
    .NumA(numA),
    .NumB(numB),
    .ProductUpper(test_upper),
    .ProductLower(test_lower)
    );

    initial begin
        if (!RandomTestFlag)
        begin
            numA = Num1 ;
            numB = Num2 ;
            correct = $signed(int'($signed(numA)) * int'($signed(numB)));

            #1;    // delay for results to be computed

            if ({test_upper, test_lower} !== correct) 
            begin
                $display("\n\nTest failed at %d x %d",numA, numB);
                $display("Test output:    %b%b \nCorrect output: %b  \n\n", test_upper, test_lower, correct);
            end
            else
            begin
                $display("\n\nTest passed at %d * %d",numA, numB);
                $display("Test output:    %b%b \nCorrect output: %b  \n\n", test_upper, test_lower, correct);
            end
        end

        else 
        begin
            for (i=0; i<NumRandTests; i++) begin
                numA = $random() ;
                numB = $random() ;
                correct = $signed(int'($signed(numA)) * int'($signed(numB)));

                #1;    // delay for results to be computed

                if ({test_upper, test_lower} !== correct) begin
                    $display("\n\nTest failed at %d * %d  %d th test\n\n",numA, numB, i);
                    $finish();
                end
            end
            $display("\n\nAll %d random tests passed successfully.\n\n", NumRandTests);
        end
        $finish();
    end

endmodule