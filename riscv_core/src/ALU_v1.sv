`timescale 1 ns / 1 ps

// Bohdan Purtell
// University of Florida
// Description: ALU Design Code
// Revision: 0, as of June 5th, 2025
// Verified Functional as of June 5th, 2025
    
module ALU_v1 (
    input [31:0] a,
    input [31:0] b,
    input [3:0] op_code,

    output logic [31:0] out,
    output logic zero_flag,
    output logic sign_flag,

    output logic [7:0] alu_error_vector
    // 00 - default
    // ff - undefined op_code
);

    // add
    // sub 
    // 2s comp
    // 1s comp
    // slt
    // and
    // or
    // xor
    // sll
    // srl
    // sra
    // fence
    // beq
    // bne
    // blt
    // bge

    logic [31:0] result;

    always_comb
    begin
        //defaults
        result = 32'h0;
        zero_flag = 1'b0;
        sign_flag = 1'b0;
        alu_error_vector = 32'h0;

        case(op_code)
            4'b0000 : // 0 add
                result = a + b;
            4'b0001 : // 1 sub 
                result = a - b;
            4'b0010 : // 2 and
                result = a & b;
            4'b0011 : // 3 or
                result = a | b;
            4'b0100 : // 4 xor
                result = a ^ b;
            4'b0101 : // 5 shift left 
                result = a << b[4:0];
            4'b0110 : // 6 shift right
                result = a >> b[4:0];
            4'b0111 : // 7 shift right arithmetic
                result = $signed(a) >>> b[4:0];
            4'd8 : // 8 slt
                result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            4'd9 : // 9 sltu
                result = (a < b) ? 32'd1 : 32'd0;
            4'b1111 :
                result = 32'hf7f7f7f7;
            default : alu_error_vector = 8'hff;
        endcase;

        // register writes
        zero_flag = (result == 32'h0);
        sign_flag = result[31];
        out = result;
    end
endmodule

