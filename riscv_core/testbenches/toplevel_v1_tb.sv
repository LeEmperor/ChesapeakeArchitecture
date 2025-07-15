// Bohdan Purtell
// University of Florida
// Toplevel v1 Testbench

`timescale 1 ns / 1 ps

module testbench_toplevel_v1();

    // cheese 
    logic t_clk;
    logic t_rst;
    logic clk_en = '0;
    
    // monitors 
    wire [6:0] seg0;

    // probes 
    logic [31:0] t_instruction;
    logic t_irconfig;

    // dut
    toplevel_v1 dut (
        .clk(t_clk),
        .rst(t_rst),
        .switch_array(),
        .seg0(),
        .seg1(),
        .ir_config(t_irconfig),
        .diagnostique_instruction(t_instruction)
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
        t_clk = 0;
        forever #5 t_clk = ~t_clk & clk_en;
    end

    initial
    begin
        // populate test vectors
        t_rst = 0;
        t_irconfig = 1;
        clk_en = 1;

        // tests a lw instruction

        t_instruction = { 12'h732, 5'd0, 3'b000, 5'd6, 7'b0010011 };
        $display("t_instruction is %h", t_instruction);
        // addi
        // immediate = 12'h732
        // rs1 = reg0 = 5'd0
        // funct3 = 3'b000
        // rd = reg6 = 5'd6
        // funct7 = 0010011 = 7'b0010011

        #10

        #50

        // tests a 

        clk_en = 0;
        disable CLK_GEN;
    end


endmodule

