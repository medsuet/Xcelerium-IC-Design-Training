
module top_module (
    input  logic          clk,
    input  logic          rst,
    input  logic          src_valid,
    input  logic          dd_ready,
    input  logic  [31:0]  dividend,
    input  logic  [31:0]  divisor,
    output logic  [31:0]  quotient,
    output logic  [31:0]  remainder,
    output logic          dd_valid,
    output logic          src_ready
);

    // Control unit signals
    logic        enable_count;
    logic        enable_registers;
    logic        selc_A;
    logic        done;
    logic        temp;

    // Instantiate the Control Unit
    Control_unit control_unit (
        .clk                  (   clk             ),
        .rst                  (   rst             ),
        .done                 (   done            ),
        .src_valid            (   src_valid       ),
        .dd_ready             (   dd_ready        ),
        .selc_A               (   selc_A          ),
        .enable_count         (   enable_count    ),
        .enable_registers     (   enable_registers),
        .src_ready            (   src_ready       ),
        .dd_valid             (   dd_valid        ),
        .temp                 (   temp            )
    );

    // Instantiate the Datapath for Restoring Division
    Datapath_Restoring_Division datapath (
        .clk                   (    clk             ),
        .rst                   (    rst             ),
        .enable_count          (    enable_count    ),
        .enable_registers      (    enable_registers),
        .selc_A                (    selc_A          ),
        .done                  (    done            ),
        .dividend              (    dividend        ),
        .divisor               (    divisor         ),
        .quotient              (    quotient        ),
        .remainder             (    remainder       ),
        .temp                  (    temp            )
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, top_module);
    end 

endmodule
