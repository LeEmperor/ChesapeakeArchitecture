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
        #15

        // tests a lw instruction - FUNCTIONAL
        // t_instruction = { 12'h3ee, 5'd0, 3'b010, 5'd1, 7'b00000_11 };
        // t_switches = 16'b0000_0000_1111_0000;
        // 50
        //
        // t_instruction = { 12'h732, 5'd0, 3'b000, 5'd6, 7'b0010011 };
        // 60

        // addi r0, r1, 1 (add 1 to r1)
        // t_instruction = { 12'h1, 5'd0, 3'b000, 5'd1, 7'b0010011};
        // #50
        // PASSÉ

        // lw r1, r2, 0x3ed (load from (r1 + 03ed) into r2)
        // t_instruction = { 12'h3ed, 5'd1, 3'b010, 5'd2, 7'b00000_11 };
        // t_switches = 16'h4;
        // #40
        // PASSÉ

        // sltiu r1, r3, 0x3ff
        // t_instruction = { 12'h3ff, 5'd1, 3'b011, 5'd3, 7'b0010011};
        // #40
        // PASSÉ

        // slti r1, r4, 0x880 (= -128)
        // t_instruction = { 12'h880, 5'd1, 3'b010, 5'd3, 7'b0010011};
        // #60
        // PASSÉ

        // addi r0, r1, 0xCCF
        // t_instruction = { 12'b1100_1100_1111, 5'd0, 3'b000, 5'd1, 7'b0010011 };
        // #45
        // PASSÉ

        // xori r5, r6, 0xF0
        // t_instruction = { 12'b0000_1111_0000, 5'd5, 3'b100, 5'd6, 7'b0010011 };
        // #50
        // PASSÉ

        // andi r5, r7, 0xFF0
        // t_instruction = { 12'b1111_1111_0000, 5'd5, 3'b111, 5'd7, 7'b0010011 };
        // #50
        // PASSÉ

        // slli r5, r8, 2 (multiply by 4)
        // t_instruction = { 7'd0, 5'd2, 5'd5, 3'b001, 5'd8, 7'b0010011 };
        // #50
        // PASSÉ

        // srli
        // t_instruction = {7'd0, 5'd2, 5'd1, 3'b101, 5'd2, 7'b0010011 };
        // #50
        // PASSÉ

        // addi, r0, r2, 0x69B
        // t_instruction = { 12'h69B, 5'd0, 3'b000, 5'd2, 7'b0010011 };
        // #45

        // add, r1, r2, r3
        // t_instruction = { 7'd0, 5'd2, 5'd1, 3'd0, 5'd3, 7'b0110011 };
        // #45
        // = 136A
        // PASSÉ

        // sub, r1, r2, r4
        // t_instruction = { 7'b01_00000, 5'd2, 5'd1, 3'b000, 5'd4, 7'b0110011 };
        // #45
        // = 634
        // PASSÉ

        // addi r0, r1, 0xCCF 
        // t_instruction = { 12'hCCF, 5'd0, 3'b000, 5'd1, 7'b0010011 };
        // #50

        // addi r0, r2, 0x2
        // t_instruction = { 12'h2, 5'd0, 3'b000, 5'd2, 7'b0010011 };
        // #50

        // sll r1, r2, r3
        // t_instruction = { 7'd0, 5'd2, 5'd1, 3'b001, 5'd3, 7'b0110011 };
        // #50
        // PASSÉ


        // sltu r2, r1, r3 (unsigned)
        // t_instruction = {7'd0, 5'd1, 5'd2, 3'b010, 5'd3, 7'b0110011 };
        // #40

        // slt r2, r1, r4 (signed) == r2 <? r1 == true
        // t_instruction = {7'd0, 5'd1, 5'd2, 3'b011, 5'd4, 7'b0110011 };
        // #50

        // addi r0, r1, 0x1
        // t_instruction = { 12'h1, 5'd0, 3'b000, 5'd1, 7'b0010011 };
        // #40

        // addi r0, r2, 0x1
        // t_instruction = { 12'h1, 5'd0, 3'b000, 5'd2, 7'b0010011 };
        // #40

        // slli r1, 31
        // t_instruction = { 7'd0, 5'd31, 5'd1, 3'b001, 5'd1, 7'b0010011 };
        // #40

        // slli r2, 31
        // t_instruction = { 7'd0, 5'd31, 5'd2, 3'b001, 5'd2, 7'b0010011 };
        // #40

        // addi r1, r1, 0x3
        // t_instruction = { 12'h3, 5'd1, 3'b000, 5'd1, 7'b0010011 };
        // #40

        // addi r2, r2, 0xA
        // t_instruction = { 12'hA, 5'd2, 3'b000, 5'd2, 7'b0010011 };
        // #40

        // invert r1
        // t_instruction = { 7'b01_00000, 5'd1, 5'd0, 3'b000, 5'd1, 7'b0110011 };
        // #40

        // invert r2
        // t_instruction = { 7'b01_00000, 5'd2, 5'd0, 3'b000, 5'd2, 7'b0110011 };
        // #40

        // slt (-10 <? -3)
        // t_instruction = { 7'd0, 5'd1, 5'd2, 3'b010, 5'd3, 7'b0110011 };
        // #40

        // sltu (10 <? 3)
        // t_instruction = { 7'd0, 5'd2, 5'd1, 3'b010, 5'd4, 7'b0110011 };
        // #40

        // addi r0, r1, 0x4
        t_instruction = { 12'h1, 5'd1, 3'b000, 5'd1, 7'b0010011 };
        #40

        // addi r0, r2, 0x2
        t_instruction = { 12'h2, 5'd2, 3'b000, 5'd2, 7'b0010011 };
        #40

        // or r1, r2, r3
        // t_instruction = { 7'd0, 5'd2, 5'd1, 3'b110, 5'd3, 7'b0110011 };
        // #40 // == B

        // and r1, r2, r4 
        // t_instruction = { 7'd0, 5'd2, 5'd1, 3'b111, 5'd4, 7'b0110011 };
        // #40 // == 2

        // sw r2, r1, 0x4
        // t_instruction = { 7'b0, 5'd2, 5'd1, 3'b010, 5'd4, 7'b0100011 };
        // #40
        // 3 + 4 = 7
        // load 0x7 w/ 0xA

        // srli r1, r3, 2
        // t_instruction = { 7'd0, 5'd2, 5'd1, 3'b101, 5'd3, 7'b0010011 };
        // #40
        // voudrait etre 1

        // srl r1, r2, r4
        // t_instruction = { 7'd0, 5'd2, 5'd1, 3'b101, 5'd4, 7'b0110011 };
        // #40

        // slli r1, 31
        t_instruction = { 7'd0, 5'd31, 5'd1, 3'b001, 5'd1, 7'b0010011 };
        #40

        // addi r1, 4
        t_instruction = { 12'd4, 5'd1, 3'b000, 5'd1, 7'b0010011};
        #40 // => r1 = 0x8000_0004

        // srai r1, r3, 1
        t_instruction = { 7'b01_00000, 5'd2, 5'd1, 3'b101, 5'd3, 7'b0010011 };
        #40
        
        // sra r1, r2, r4
        t_instruction = { 7'b01_00000, 5'd2, 5'd1, 3'b101, 5'd4, 7'b0110011 };
        #40

        #40

        clk_en = 0;
        disable CLK_GEN;
    end


endmodule

