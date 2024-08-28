module sequential_multiply_tb();

logic CLK;
logic signed [15:0] A;
logic signed [15:0] B;
logic start;
logic RESET;
logic signed [31:0] product;
logic READY;

// Change Count Value
int count = 10000000;
int fd;

sequential_multiply DUT (
    .CLK(CLK),
    .A(A),
    .B(B),
    .start(start),
    .RESET(RESET),
    .product(product),
    .READY(READY)
);

// Clock generation
initial 
begin
    CLK = 0;
    forever #10 CLK = ~CLK;
end

// Reset sequence
task reset_sequence();
begin
    RESET = 0;
    @(posedge CLK);
    RESET = 1;
end
endtask

// Task to perform directed test
task directed_test(input logic signed [15:0] A_in, input logic signed [15:0] B_in);
    logic signed [31:0] expected_product;

    begin
        A <= #1 A_in;
        B <= #1 B_in;
        start <= #1 1;
        @(posedge CLK);
        start <= #1 0;

        // Wait for 16 clock cycles
        repeat (16) @(posedge CLK);

        // Compute expected product
        expected_product = A_in * B_in;

        // Compare the result
        if (product !== expected_product) begin
          $display("ERROR: A=%d, B=%d, Expected Product=%d, Got=%d", A_in, B_in, expected_product, product);
          $finish;
        end else begin
          $display("PASS: A=%d, B=%d, Product=%d", A_in, B_in, product);
        end
    end
endtask

// Driver
task driver(input int count);
    int i;
    begin
        for (i=0; i<count; i++)
        begin
            A <= #1 ($random % 65535);
            B <= #1 ($random % 65535);
            
            start <= #1 1;
            @(posedge CLK);
            start <= #1 0;
            // Wait 16 clock cycles
            repeat(16) @(posedge CLK);
        end
    end
endtask

// Monitor
task monitor(input int count);
    int j;
    logic signed [15:0] M_A;
    logic signed [15:0] M_B;
    logic signed [31:0] expected_product;
    fd = $fopen("../logs/output_result.log", "w");
    begin
        $display("\n\nGenerating log file for %0d random inputs...",count);
        $display("...\n");
        for (j=0; j<count; j++)
        begin
            @(posedge start);
            M_A = A;
            M_B = B;
            @(posedge CLK);

            // Wait for 16 clock cycles
            repeat (16) @(posedge CLK);

            // Compute expected product
            expected_product = M_A * M_B;

            // Compare the result
            if (product !== expected_product) begin
            $fdisplay(fd,"ERROR: A=%d, B=%d, Expected Product=%d, Got=%d", M_A, M_B, expected_product, product);
            $display("ERROR: A=%d, B=%d, Expected Product=%d, Got=%d", M_A, M_B, expected_product, product);
            $fclose(fd);
            $finish;
            end else begin
            $fdisplay(fd,"Test #%0d PASS: A=%d, B=%d, Product=%d",j+1, M_A, M_B, product);
            end
        end
        $display("Successfully generated a log file!");
    end
    $fclose(fd);
endtask

  // Main test sequence
  initial begin
    reset_sequence();

    // Run directed tests
    directed_test(1, 1);
    directed_test(10, 0);
    directed_test(-10, 0);
    directed_test(0, 10);
    directed_test(0, -10);
    directed_test(10, 10);
    directed_test(-10, 10);
    directed_test(10, -10);
    directed_test(-10, -10);

    // Run driver and monitor after directed tests
    fork
        driver(count);
        monitor(count);
    join
    $display("###################");
    $display("\nAll tests passed!\n");
    $display("###################\n");


    $stop;
    $finish;
  end

endmodule
