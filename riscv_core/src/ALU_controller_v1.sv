// Bohdan Purtell
// University of Florida
// Design Entity for ALU Controller

module ALU_controller_v1 (
    input logic [6:0] op_code,
    input logic [6:0] funct_7,
    input logic [2:0] funct_3,
    output logic [3:0] alu_code,
    output logic [7:0] alu_controller_error_vector
    // d1 = unknown i-type instruction
    // d2 = unknown shift-right instruction call
);

    always_comb
    begin

        alu_code = 1;

        case (op_code)
            7'b001_0011 : // i-type
                case (funct_3)
                    'b000 : // addi
                        alu_code = 'd0;

                    'b111 : // andi
                        alu_code = 'd2;

                    'b110 : // ori
                        alu_code = 'd3;

                    'b100 : // xori
                        alu_code = 'd4;

                    'b001 : // slli
                        alu_code = 'd5;

                    'b101 : begin // srli/srai
                        alu_code = 'd6;
                        case(funct_7)
                            'd0 : alu_code = 'd6; // srli (shift-logique)
                            'b01_00000 : alu_code = 'd7; // srai (shift-arithmetique)
                            default : alu_controller_error_vector = 'd2;
                        endcase
                    end

                    'b010 : // slti
                        alu_code = 'd8;

                    'b011 : // sltiu
                        alu_code = 'd9;

                    default :
                        alu_controller_error_vector = 'd1;
                endcase

            7'b011_0011 : // r-type
                alu_code = 0;
            7'b11_00011 : // b-type
                alu_code = 0;
            7'b01_00011 : // s-instructions (store-type)
                alu_code = 0;
            7'b00000_11 : // l-instructions (load-type)
                alu_code = 0;
            7'b011_0111 : // lui
                alu_code = 0;
            7'b0010_111 : // auipc
                alu_code = 0;
            7'b110_1111 : // jal
                alu_code = 0;
            7'b1100_111 : // jalr
                alu_code = 0;
            7'b000_1111 : // fence
                alu_code = 0;
            7'b111_00_11 : // ecall/ebreak
                alu_code = 0;
            default : alu_controller_error_vector = '0;
        endcase
    end
endmodule

