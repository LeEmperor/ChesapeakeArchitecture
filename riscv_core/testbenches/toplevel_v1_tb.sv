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
    wire [6:0] seg1;

    // probes 
    logic [31:0] t_instruction;
    logic t_irconfig;
    logic [15:0] t_switches;
    logic [3:0] t_buttons;

    // dut
    toplevel_v1 dut (
        .clk(t_clk),
        .rst(t_rst),
        .switch_array(t_switches),
        .button_array(t_buttons),
        .seg0(),
        .seg1(),
        .ir_config(t_irconfig),
        .diagnostique_instruction(t_instruction)
    );

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

        // tests a lw instruction - FUNCTIONAL
        // t_instruction = { 12'h3ee, 5'd0, 3'b010, 5'd1, 7'b00000_11 };
        // t_switches = 16'b0000_0000_1111_0000;
        // 50
        //
        // t_instruction = { 12'h732, 5'd0, 3'b000, 5'd6, 7'b0010011 };
        // 60

        // addi r0, r1, 1 (add 1 to r1)
        t_instruction = { 12'h1, 5'd0, 3'b000, 5'd1, 7'b0010011};
        #50
        // PASSED

        // lw r1, r2, 0x3ed (load from (r1 + 03ed) into r2)
        t_instruction = { 12'h3ed, 5'd1, 3'b010, 5'd2, 7'b00000_11 };
        t_switches = 16'h4;
        #40
        // PASSED

        // sltiu r1, r3, 0x3ff
        t_instruction = { 12'h3ff, 5'd1, 3'b011, 5'd3, 7'b0010011};
        #40
        // PASSED

        // slti r1, r4, 0x880 (= -128)
        t_instruction = { 12'h880, 5'd1, 3'b010, 5'd3, 7'b0010011};
        #60
        // PASSED

        // $display("t_instruction is %h", t_instruction);
        // addi
        // immediate = 12'h732
        // rs1 = reg0 = 5'd0
        // funct3 = 3'b000
        // rd = reg6 = 5'd6
        // funct7 = 0010011 = 7'b0010011
        // STATUS: VERIFIED FUNCTIONAL
        // 70

        clk_en = 0;
        disable CLK_GEN;
    end


endmodule

