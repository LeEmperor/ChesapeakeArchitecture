// Bohdan Purtell
`timescale 1 ns / 1 ps

module controller_v1 (
    // clk and reset
    input logic clk, rst, 

    input logic [5:0] funct7,
    input logic [14:12] funct3,
    input logic [6:0] opcode,
    output logic [1:0] alu_src_a,
    output logic [1:0] alu_src_b,

    output logic [1:0] current_state_vector,
    output logic [1:0] next_state_vector,
    output logic [7:0] next_state_error_vector,
        // d2 = failed decode stage on funct7 field
        // d3 = failed decode stage on funct3 field
        // d4 = failed decode stage on opcode field
    output logic [7:0] moore_map_error_vector
);

    (* fsm_encoding = "one-hot" *)
    typedef enum logic[4:0] {
        INIT        = 5'b00000,
        IDLE        = 5'b00001,
        FETCH       = 5'b00010,
        DECODE      = 5'b00100, 
        EXECUTE     = 5'b01000,
        WRITEBACK   = 5'b10000
    } state;

    state current_state = INIT;
    state next_state = INIT;
    
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
        // default
        next_state <= current_state;
        next_state_error_vector <= 8'd0;

        case (current_state)
            INIT : begin
                next_state <= IDLE;
            end

            IDLE : begin
                next_state <= FETCH;
            end

            FETCH : begin
                next_state <= DECODE;
            end

            DECODE : begin
                case (opcode) // class code

                    // special types
                    7'b01101_11 : begin // lui (load upper immediate)

                    end

                    7'b00101_11 : begin // auipc (add upper immediate to pc)

                    end

                    7'b11011_11 : begin // jal 

                    end

                    7'b11001_11 : begin // jalr

                    end

                    7'b00011_11 : begin // fence-types

                    end

                    7'b11100_11 : begin // ecall/ebreak

                    end


                    // class types
                    7'b00100_11 : begin // i-types

                    end

                    7'b01100_11 : begin // r-types

                    end

                    7'b11000_11 : begin // b-types

                    end

                    7'b00000_11 : begin // load-types

                    end

                    default : begin
                        next_state_error_vector <= 8'd4;
                    end
                endcase

                next_state <= EXECUTE;
            end

            EXECUTE : begin
                next_state <= WRITEBACK;
            end

            WRITEBACK : begin
                next_state <= FETCH;
            end

            default : begin
                next_state_error_vector <= 8'd255;
            end
        endcase
    end

    // moore output map logic
    always_comb
    begin
        // defaults
        alu_src_a <= 2'b00;
        alu_src_b <= 2'b00;
        moore_map_error_vector <= 8'd0;

        case (current_state)
            INIT : begin 

            end

            IDLE : begin

            end

            FETCH : begin

            end

            DECODE : begin
                alu_src_a <= 2'b10;
            end

            EXECUTE : begin
                alu_src_b <= 2'b01;
            end

            WRITEBACK : begin

            end

            default : moore_map_error_vector <= 8'd255;
        endcase
    end
endmodule

