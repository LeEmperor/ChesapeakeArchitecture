// Bohdan Purtell
// University of Florida
// Toplevel v1 Testbench

`timescale 1 ns / 1 ps

module testbench_toplevel_v1();

    // test signals
    logic t_clk;
    logic t_rst;
    logic clk_en = '0;

    // dut
    toplevel_v1 dut (

    );

    typedef struct {

        string test_name;
        logic [31:0] instruction;
        logic [31:0] alu_result;
        logic [31:0] alu_lo_result;
        logic [31:0] alu_hi_result;
        logic [31:0] regFile_asyncread1;
        logic [31:0] regFile_asyncread2;
    } testVector_t;

    localparam int n_tests = 1;
    localparam int name_width = 30;
    testVector_t tests[n_tests];

    integer i;
    string name;
    string pad;
    int len;
    bit pass;

    initial begin : CLK_GEN
        t_clk = 1'b0;
        forever #5 t_clk = ~t_clk & clk_en;
    end

    initial
    begin
        // populate test vectors
        t_rst = '0;

        // tests a lw instruction




    end


endmodule

