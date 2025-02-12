module convolution_stateMachine #(
    parameter INPUT_SIZE = 8,    
    parameter KERNEL_SIZE = 8    
) (
    input  logic clk,            
    input  logic reset,          
    input  logic start,          
    output logic compute_enable, 
    output logic [3:0] index,   
    output logic valid_out ,    
    output logic shift,
    output logic WAIT
);

    // State registers
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        COMPUTE = 2'b01,
        WAIT_FOR_SAMPLE = 2'b10,
        WAIT_FOR_COMPLETION = 2'b11
    } state_t;

    state_t state, next_state;
    logic [31:0] index_next;

    // Sequential state and index logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            index <= 0;
          //  valid_out <= 0;
        end else begin
            state <= next_state;
            index <= index_next;
        end
    end

    // Next state and index logic
    always_comb begin
        // Default values
        compute_enable = 0;
        valid_out = 0;
        shift =0;
        WAIT = 0;
        index_next = index;
        next_state = state;

        case (state)
            IDLE: begin
                if (start)begin valid_out=0;next_state = COMPUTE;compute_enable=0; end
                if ( index==(INPUT_SIZE+KERNEL_SIZE-2))begin valid_out=1; WAIT=1;compute_enable=0;index_next=4'd0;end
            end
            COMPUTE: begin
                
                if (index < INPUT_SIZE-1 && start ) begin
                    compute_enable = 1;
                    index_next = index + 1; valid_out=0; 
                end else begin
                    if(!start && index<INPUT_SIZE-1)begin next_state=WAIT_FOR_SAMPLE;valid_out=0;compute_enable=1;shift=1;end 
                    else if( index == INPUT_SIZE-1)begin next_state=WAIT_FOR_COMPLETION;valid_out=0;compute_enable=1;shift=0;end
                    else begin next_state=IDLE; valid_out=0;end
                end
            end
            WAIT_FOR_SAMPLE: begin
                if(start)begin 
                     valid_out = 0; index_next=index+1;compute_enable=0; 
                     next_state = COMPUTE;end
                else begin valid_out=0;compute_enable=0; end
            end
            WAIT_FOR_COMPLETION: begin
                   if(index<2*INPUT_SIZE-2)begin WAIT=1;shift=1; compute_enable=1;index_next=index+1;valid_out=0;end
                   else begin WAIT=1;valid_out=0;compute_enable=1;next_state = IDLE;end
            end
              
        endcase
    end
endmodule
