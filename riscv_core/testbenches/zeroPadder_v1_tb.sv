// Bohdan Purtell
// University of Florida
// Testbench Template v1

`timescale 1 ns / 1 ps

module testbench_zeroPadder_v1();

    // control 
    logic t_clk;
    logic t_rst;
    logic clk_en;

    // monitor
    wire [31:0] t_unsigned;
    wire [31:0] t_signed;

    // probe
    logic t_datain;
    logic t_en;
    logic [11:0] t_imm;

    // dut
    zeroPadder_v1 dut (
        .immediate(t_imm),
        .unsigned_zero_padded(t_unsigned),
        .signed_zero_padded(t_signed)
    );

    initial begin : CLK_GEN
        t_clk = 0;
        forever #5 t_clk = ~t_clk & clk_en;
    end

    initial
        begin
            clk_en = 1;
            t_rst = 0;
            t_imm = 12'b010_000_011_000;
            #10

            t_imm = 12'b001_111_110_000;
            #10

            clk_en = 0;
            disable CLK_GEN;
        end
endmodule

