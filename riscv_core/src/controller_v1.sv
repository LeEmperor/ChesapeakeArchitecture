// Bohdan Purtell
`timescale 1 ns / 1 ps

module controller_v1 (
    // clk and reset
    input logic clk, rst, 

    // input signals
    input logic [6:0] funct7,
    input logic [2:0] funct3,
    input logic [6:0] opcode,
    input logic [31:0] ir_31_0,

    // select control  signals
    output logic [1:0] alu_src_a,
    output logic [2:0] alu_src_b,
    output logic [1:0] ir_source,
    output logic [1:0] pc_source,
    output logic [1:0] regFile_rdwr_config,
    output logic regFile_wrdata1,
    output logic regFile_wrdata2,
    output logic regFile_addr2,
    output logic [1:0] alu_result,
    output logic [1:0] memdata_source, 
    output logic [1:0] memaddr_source, 

    // write enable control signals
    output logic ir_write,
    output logic reg_a_write,
    output logic reg_b_write,
    output logic pc_write,
    output logic mem_write,
    output logic regfile_write, // breh
    output logic link_reg,

    output logic alu_result_reg_write,
    output logic alu_lo_result_reg_write,
    output logic alu_hi_result_reg_write,

    // diagnostic vectors
    output logic [1:0] current_state_vector,
    output logic [1:0] next_state_vector,
    output logic [7:0] next_state_error_vector,
        // d1
        // d2
        // d3
        // d4
    output logic [7:0] moore_map_error_vector
);

    (* fsm_encoding = "one-hot" *)
    typedef enum logic[5:0] {
        INIT        = 6'b000000,
        IDLE        = 6'b000001,
        FETCH       = 6'b000010,
        DECODE      = 6'b000100, 
        EXECUTE     = 6'b001000,
        WRITEBACK   = 6'b010000,
        MEMORY      = 6'b100000
    } state;

    state current_state = INIT;
    state next_state = INIT;
    
    // clk proc
    always_ff @(posedge clk)
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
        next_state = current_state;
        next_state_error_vector = 8'd0;

        case (current_state)
            INIT : begin
                next_state = IDLE;
            end

            IDLE : begin
                next_state = FETCH;
            end

            FETCH : begin
                next_state = DECODE;
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
                // if (opcode == 'b00000_11)
                //     next_state <= MEMORY;
                // case(opcode)
                //     7'b00000_11 : begin
                //         next_state <= MEMORY;
                //     end
                //     default
                //         next_state_error_vector <= 8'd5;
                // endcase
            end

            MEMORY : begin
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

        // selects
        alu_src_a = '0;
        alu_src_b = '0;
        ir_source = '0;
        pc_source = '0;
        alu_result = 0;
        memdata_source = 0;
        memaddr_source = 0;

        // write enables
        ir_write = '0;
        reg_a_write = '0;
        reg_b_write = '0;
        pc_write = '0;
        mem_write = '0;
        regfile_write = '0;
        regFile_rdwr_config = '0;

        alu_result_reg_write = '0;
        alu_lo_result_reg_write = '0;
        alu_hi_result_reg_write = '0;

        regFile_wrdata1 = '0;
        regFile_wrdata2 = '0;
        regFile_addr2 = 0;

        // diagnostiqes
        moore_map_error_vector = 8'd0;

        case (current_state)
            INIT : begin

            end

            IDLE : begin

            end

            FETCH : begin
                ir_source = 2'b00;
                ir_write = 1;
            end

            DECODE : begin
                case (opcode) 

                    7'b00100_11 : begin // i-types
                        // tous instructions i-type utiliser l'immediate ou un
                        // autre truc pour arg B
                        alu_src_b = 1;
                        reg_a_write = 1;
                        reg_b_write = 1;

                        if (funct3 == 'b010)  // if slti (signed)
                            alu_src_b = 2;
                    end

                    7'b0110011 : begin // r-types
                        alu_src_b = 0;
                        reg_a_write = 1;
                        reg_b_write = 1;
                    end

                    7'b00000_11 : begin // l-types
                        case(funct3)
                            3'b010 : begin // lw
                                alu_src_b = 1; // unsigned padded immediate
                                reg_a_write = 1; // *rs1
                                reg_b_write = 1; // immediate
                            end

                            default
                                moore_map_error_vector = 'd55;
                        endcase
                    end

                    7'b0100011 : begin // s-types
                        case(funct3)
                            3'b000 : begin // sb

                            end

                            3'b001 : begin // sh

                            end

                            3'b010 : begin // sw
                                alu_src_b = 'd3;
                                reg_a_write = 1;
                                reg_b_write = 1;
                            end

                            default
                                moore_map_error_vector = 'd56;
                        endcase
                    end

                    default
                        moore_map_error_vector = 'd50;
                endcase
            end

            EXECUTE : begin
                alu_result_reg_write = 1;
                alu_result_reg_write = 1;
                alu_lo_result_reg_write = 1;
                alu_hi_result_reg_write = 1;
            end

            // MEMORY : begin
            //     memaddr_source = 'd1;
            //     regFile_wrdata1 = 'd1;
            // end

            WRITEBACK : begin
                case (opcode)
                    7'b00100_11 : begin // i-types
                        // regfile_write = 1;
                        regFile_rdwr_config = 2'b10;
                        regFile_addr2 = 1;
                    end

                    7'b00000_11 : begin // load-types
                        regFile_rdwr_config = 'b10;
                        regFile_addr2 = 1; // écrire à rd
                        memaddr_source = 1;
                        regFile_wrdata2 = 1;
                    end

                    7'b0110011 : begin // r-type
                        regFile_rdwr_config = 'b10;
                        regFile_addr2 = 1;
                    end

                    7'b0100011 : begin // s-type
                        memaddr_source = 1;
                        memdata_source = 1;
                        mem_write = 1;
                    end

                    default : begin

                    end
                endcase
            end

            default : moore_map_error_vector <= 8'd255;
        endcase
    end
endmodule

