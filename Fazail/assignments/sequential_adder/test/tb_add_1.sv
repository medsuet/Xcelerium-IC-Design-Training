localparam WIDTH = 4;

module tb_add_1;
logic in, a;
logic clk, n_rst;
logic out;

logic [WIDTH-1:0]value;
int i = 1;

add_1 UUT (
    .in(in),
    .a(a),
    .clk(clk),
    .reset(n_rst),
    .value_out(out)
);
    
initial begin
    clk = 1;
    forever begin
        #20 clk = ~clk;
    end
end

initial begin
    // initialize all the signals
    init_signals;

    // apply reset sequence
    reset_seq;

    // inputs checking
    value = 10;
    apply_inputs(value[0], 1);      // add one to lsb
    
    repeat(3) begin
        apply_inputs(value[i], 0);
        i++;
    end
    i = 0;

    repeat(1)@(posedge clk);
    $finish;
end

// initialize the signals
task init_signals;
    begin
        in = 0; a = 0; value = 0;
    end
endtask

// reset sequence
task reset_seq;
    begin
        n_rst = 1;
        @(posedge clk) n_rst = 0;
        @(posedge clk) n_rst = 1; 
    end
endtask

// apply inputs
task apply_inputs(input value_in, constant);
    @(posedge clk);
    in = value_in;
    a = constant; 
endtask

endmodule