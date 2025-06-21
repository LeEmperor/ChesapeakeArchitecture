// Bohdan Purtell
`timescale 1 ns / 1 ps

module controller(
    input logic clk, rst, 
    input logic in1,
    output logic [1:0] out1,
    output logic [7:0] next_state_error_vector,
    output logic [7:0] moore_map_error_vector,
);

    (* fsm_encoding = "one-hot" *)
    typedef enum logic[4:0] {
        INIT        = 5'd0,
        IDLE        = 5'd1,
        FETCH       = 5'd2,
        DECODE      = 5'd3, 
        EXECUTE     = 5'd4,
        WRITEBACK   = 5'd5,
    } state;

    state current_state;
    state next_state;
    
    // clk proc
    always_ff @(posedge clk or posedge rst)
    begin
    if (rst)
        begin
            current_state <= IDLE;
        end 
    else
        begin
            current_state <= next_state;
        end
    end
    
    // next_state logic
    always_comb
    begin
    case (current_state)
        blank : begin
            out1 = 1'd0;
            next_state = idle;
        end

        idle : begin
            out1 = 2'd1;
            next_state = (in1) ? compute : idle;
        end

        compute : begin
            out1 = 2'd2;
            next_state = (in1) ? compute : done; 
        end

        done : begin
            out1 = 2'd3;
            next_state = (in1) ? done : idle;
        end

        default : begin
            next_state_error_vector <= 8'd255;
        end
    endcase
    end

    // moore output map logic
    always_comb
    begin
    case (current_state)
        blank : begin
            out1 = 1'd0;
        end
        default : moore_map_error_vector <= 8'd255;
    endcase
    end
endmodule

