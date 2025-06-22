`timescale 1ns/1ps

// Bohdan Purtell
// University of Florida
// Description: ALU Testbench with Assertions
// Revision: 0, as of June 5th, 2025
// Verified Functional as of June 5th, 2025

module testbench_ALU_v1;
    // Inputs to DUT
    logic  [31:0] t_a, t_b;
    logic   [3:0] t_op_code;

    // Outputs from DUT
    wire  [31:0] t_out;
    wire         t_zero_flag;
    wire         t_sign_flag;
    wire   [7:0] t_error_vector;

    // Instantiate the ALU under test
    ALU_v1 dut (
        .a            (t_a),
        .b            (t_b),
        .op_code      (t_op_code),
        .out          (t_out),
        .zero_flag    (t_zero_flag),
        .sign_flag    (t_sign_flag),
        .error_vector (t_error_vector)
    );

    //----------------------------------------------------------------------  
    // Define a struct to hold each test vector and its expected results  
    //----------------------------------------------------------------------  
    typedef struct {
        logic [31:0] a;
        logic [31:0] b;
        logic  [3:0] opcode;
        logic [31:0] exp_out;
        logic        exp_zero;
        logic        exp_sign;
        logic  [7:0] exp_error;
    } test_vec_t;

    // Create a static array of test vectors  
    localparam int NUM_TESTS = 11;
    test_vec_t tv[NUM_TESTS];

    integer i;

    initial begin
        //------------- Populate test vectors ----------------
        // 1) ADD: 2 + 3 = 5
        tv[0] = '{ a         : 32'h0000_0002,
                  b         : 32'h0000_0003,
                  opcode    : 4'b0000,         // ADD
                  exp_out   : 32'h0000_0005,
                  exp_zero  : 1'b0,
                  exp_sign  : 1'b0,
                  exp_error : 8'h00 };

        // 2) SUB_ZERO: 5 - 5 = 0 => zero_flag = 1
        tv[1] = '{ a         : 32'h0000_0005,
                  b         : 32'h0000_0005,
                  opcode    : 4'b0001,         // SUB
                  exp_out   : 32'h0000_0000,
                  exp_zero  : 1'b1,
                  exp_sign  : 1'b0,
                  exp_error : 8'h00 };

        // 3) AND: 0xFFFF0000 & 0x0FFF0FFF = 0x0FFF0000
        tv[2] = '{ a         : 32'hFFFF_0000,
                  b         : 32'h0FFF_0FFF,
                  opcode    : 4'b0010,         // AND
                  exp_out   : 32'h0FFF_0000,
                  exp_zero  : 1'b0,
                  exp_sign  : 1'b0,
                  exp_error : 8'h00 };

        // 4) OR:  0xFFFF0000 | 0x0000FFFF = 0xFFFFFFFF
        tv[3] = '{ a         : 32'hFFFF_0000,
                  b         : 32'h0000_FFFF,
                  opcode    : 4'b0011,         // OR
                  exp_out   : 32'hFFFF_FFFF,
                  exp_zero  : 1'b0,
                  exp_sign  : 1'b1,           // MSB=1 since out is negative in 2's-complement
                  exp_error : 8'h00 };

        // 5) XOR: 0xF0F0F0F0 ^ 0x0F0F0F0F = 0xFFFFFFFF
        tv[4] = '{ a         : 32'hF0F0_F0F0,
                  b         : 32'h0F0F_0F0F,
                  opcode    : 4'b0100,         // XOR
                  exp_out   : 32'hFFFF_FFFF,
                  exp_zero  : 1'b0,
                  exp_sign  : 1'b1,
                  exp_error : 8'h00 };

        // 6) SLL: 1 << 4 = 16
        tv[5] = '{ a         : 32'h0000_0001,
                  b         : 32'h0000_0004,    // shift-amount = 4
                  opcode    : 4'b0101,          // SLL
                  exp_out   : 32'h0000_0010,
                  exp_zero  : 1'b0,
                  exp_sign  : 1'b0,
                  exp_error : 8'h00 };

        // 7) SRL: 16 >> 2 = 4
        tv[6] = '{ a         : 32'h0000_0010,
                  b         : 32'h0000_0002,    // shift-amount = 2
                  opcode    : 4'b0110,          // SRL
                  exp_out   : 32'h0000_0004,
                  exp_zero  : 1'b0,
                  exp_sign  : 1'b0,
                  exp_error : 8'h00 };

        // 8) SRA: 0x80000000 >>> 1 = 0xC0000000 (arithmetic right)
        tv[7] = '{ a         : 32'h8000_0000,
                  b         : 32'h0000_0001,    // shift-amount = 1
                  opcode    : 4'b0111,          // SRA
                  exp_out   : 32'hC000_0000,
                  exp_zero  : 1'b0,
                  exp_sign  : 1'b1,
                  exp_error : 8'h00 };

        // 9) SLT: signed(5) < signed(10) → out = 1
        tv[8] = '{ a         : 32'h0000_0005,
                  b         : 32'h0000_000A,
                  opcode    : 4'b1000,          // SLT
                  exp_out   : 32'h0000_0001,
                  exp_zero  : 1'b0,
                  exp_sign  : 1'b0,
                  exp_error : 8'h00 };

        // 10) SLTU: unsigned(0xFFFFFFFF) < unsigned(0) → out = 0
        tv[9] = '{ a         : 32'hFFFF_FFFF,
                  b         : 32'h0000_0000,
                  opcode    : 4'b1001,          // SLTU
                  exp_out   : 32'h0000_0000,
                  exp_zero  : 1'b1,
                  exp_sign  : 1'b0,
                  exp_error : 8'h00 };

        // 11) DEFAULT (illegal opcode): out stays at default 0xF7F7F7F7, error_vector = 0xFF
        tv[10] = '{ a         : 32'h0000_0000,
                   b         : 32'h0000_0000,
                   opcode    : 4'b1111,        // illegal
                   exp_out   : 32'hF7F7_F7F7,  // initial “unknown” pattern
                   exp_zero  : 1'b0,
                   exp_sign  : 1'b1,
                   exp_error : 8'h0 };

        //----------- Run through all test vectors ---------------
        for (i = 0; i < NUM_TESTS; i++) begin
            // Drive inputs
            t_a       = tv[i].a;
            t_b       = tv[i].b;
            t_op_code = tv[i].opcode;

            // Wait a small delta for combinational logic to settle
            #5;

            // Check 'out'
            assert (t_out === tv[i].exp_out)
                else $error("Test[%0d] (%b): OUT mismatch: got 0x%08h, expected 0x%08h",
                            i, tv[i].opcode, t_out, tv[i].exp_out);

            // Check 'zero_flag'
            assert (t_zero_flag === tv[i].exp_zero)
                else $error("Test[%0d] (%b): ZERO_FLAG mismatch: got %b, expected %b",
                            i, tv[i].opcode, t_zero_flag, tv[i].exp_zero);

            // Check 'sign_flag'
            assert (t_sign_flag === tv[i].exp_sign)
                else $error("Test[%0d] (%b): SIGN_FLAG mismatch: got %b, expected %b",
                            i, tv[i].opcode, t_sign_flag, tv[i].exp_sign);

            // Check 'error_vector'
            assert (t_error_vector === tv[i].exp_error)
                else $error("Test[%0d] (%b): ERROR_VECTOR mismatch: got 0x%02h, expected 0x%02h",
                            i, tv[i].opcode, t_error_vector, tv[i].exp_error);
        end

        $display("All %0d ALU tests completed.", NUM_TESTS);
        $finish;
    end
endmodule

