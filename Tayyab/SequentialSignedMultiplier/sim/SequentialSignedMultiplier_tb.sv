module SequentialSignedMultiplier_tb();
    parameter NUMTESTS = 1e3;
    parameter NUMBITS = 16;

    logic clk, reset, start;
    logic [(NUMBITS-1):0] numA, numB;
    logic ready;
    logic [((2*NUMBITS)-1):0] test_result, ref_result;

    SequentialSignedMultiplier #(NUMBITS) ssm
    (
        clk, reset, start,
        numA, numB,
        ready,
        test_result
    );

    initial begin
        clk = 1;
        forever #5 clk = ~clk;
    end

    initial driver();
    initial monitor();

    task driver();
        reset_sequence();

        for (int i=0; i<NUMTESTS; i++)
        begin
            numA = $random();
            numB = $random();
            start_signal();
            @(posedge ready);
        end

        $display("\n\nAll %d tests passed.\n\n", NUMTESTS);
        $finish();
    endtask

    task monitor();
        @(negedge reset);
        @(posedge reset);

        forever begin
            @(negedge ready);
            ref_result = $signed(int'($signed(numA)) * int'($signed(numB)));
            

            @(posedge ready);

            if (ref_result != test_result) begin
                $display("\n\nTest failed.\n");
                $display("%d, %d", numA, numB);
                $display("\n\nTest_result = %x", test_result);
                $display("Correct_result = %x\n\n", ref_result);
                $finish();
            end
        end
    endtask

    task reset_sequence();
        reset = 1;
        #2 reset = 0;
        #14 reset = 1;
    endtask

    task start_signal();
        start = 1;
        @(posedge clk);
        start = 0;
    endtask 

endmodule
