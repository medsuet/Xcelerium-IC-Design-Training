/*
    Name: axi4lite_controller.sv
    Author: Muhammad Tayyab
    Date: 19-8-2024
    Description: Controller for cache to memory axi4-lite interface.
*/

module axi4lite_controller
(
    input logic clk, reset,
    
    // Signals with cache
    input logic mem_wr_req, axi_valid,
    output logic axi_ready,

    // Signals with memory (AXI4-lite)
    input logic arready, rvalid, awready, wready, bvalid,
    output logic arvalid, rready, awvalid, wvalid, bready
);

    typedef enum logic [2:0] { IDLE, HANDSHAKE_MEM_READ, MEM_READ, HANDSHAKE_MEM_WRITE, MEM_WRITE } type_axi_controller_states_e;

    // Store current state
    type_axi_controller_states_e current_state, next_state;

    always @(posedge clk, negedge reset) begin
        if (!reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state and output logic
    always_comb begin
        // Defaults
        next_state = IDLE;
                        
        axi_ready = 0;
        arvalid  = 0;
        rready   = 0;
        awvalid  = 0;
        wvalid   = 0;
        bready   = 0;

        case (current_state)
            IDLE: 
            begin
                if (axi_valid & !mem_wr_req)
                begin
                    next_state = HANDSHAKE_MEM_READ;
                    arvalid = 1;
                    rready = 1;
                end
                else if (axi_valid & mem_wr_req)
                begin
                    next_state = HANDSHAKE_MEM_WRITE;
                    awvalid = 1;
                    wvalid = 1;
                    bready = 1;
                end
                else
                begin
                    next_state = IDLE;
                end
            end

            HANDSHAKE_MEM_READ:
            begin
                arvalid = 1;
                rready = 1;

                if (arready & rvalid)
                begin
                    next_state = IDLE;
                    axi_ready = 1;
                end
                else if (arready & !rvalid)
                begin
                    next_state = MEM_READ;
                end
                else
                begin
                    next_state = HANDSHAKE_MEM_READ;
                end
            end

            MEM_READ:
            begin
                rready = 1;

                if (rvalid)
                begin
                    next_state = IDLE;
                    axi_ready = 1;
                end
                else
                begin
                    next_state = MEM_READ;
                end
            end

            HANDSHAKE_MEM_WRITE:
            begin
                awvalid = 1;
                wvalid = 1;
                bready = 1;

                if (awready & wready & bvalid)
                begin
                    next_state = IDLE;
                    axi_ready = 1;
                end
                else if (awready & wready & !bvalid)
                begin
                    next_state = MEM_WRITE;
                end
                else
                begin
                    next_state = HANDSHAKE_MEM_WRITE;
                end
            end

            MEM_WRITE:
            begin
                bready = 1;

                if (bvalid)
                begin
                    next_state = IDLE;
                    axi_ready = 1;
                end
                else
                begin
                    next_state = MEM_WRITE;
                end
            end

            default:
            begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
