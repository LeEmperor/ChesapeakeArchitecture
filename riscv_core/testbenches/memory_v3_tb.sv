// Bohdan Purtell
// University of Florida
// Testbench for Memory v3
// STATUS: Completé et Functionelle

`timescale 1 ns / 1 ps

module testbench_memory_v3();

    // control 
    logic t_clk;
    logic t_rst;
    logic clk_en;

    // monitor
    wire [31:0] t_dataout;

    // probe
    logic [31:0] t_datain;
    logic t_en;
    logic [15:0] t_switches; 
    logic [3:0] t_buttons;
    logic [9:0] t_addr;
    logic t_WE;
    logic [6:0] t_seg0;
    logic [6:0] t_seg1;
    logic [6:0] t_seg2;
    logic [6:0] t_seg3;
    logic [6:0] t_seg4;
    logic [6:0] t_seg5;
    logic [6:0] t_seg6;
    logic [6:0] t_seg7;

    // dut
    memory_v3 dut (
        .addr(t_addr),
        .WE(t_WE),
        .clk(t_clk),
        .rst(t_rst),
        .data_in(t_datain),
        .data_out(t_dataout),
        .seg0(t_seg0),
        .seg1(t_seg1),
        .button_array(t_buttons),
        .switch_array(t_switches)
    );

    initial begin : CLK_GEN
        t_clk = 0;
        forever #5 t_clk = ~t_clk & clk_en;
    end

    initial
        begin
            // populate test vectors
            t_rst = 0;
            clk_en = 1;
            t_addr = 10'h25;
            t_datain = 32'h120;
            t_WE = 0;
            #10

            t_WE = 1;
            #10

            t_addr = 10'h20;
            t_datain = 32'h100;
            t_WE = 0;
            #10

            t_WE = 1;
            #10

            t_WE = 0;
            t_addr = 10'h25;
            #10

            t_addr = 10'h20;
            #10

            // cést vreifié que les RAM écrires et lires sont fonctionnells
            
            t_addr = 'h3ff; // seg0
            t_datain = 'b1111_000;
            #10

            t_WE = 1;
            #10

            t_addr = 'h3fe; // seg1
            t_WE = 0;
            #10

            t_WE = 1;
            #10

            t_WE = 0;
            t_addr = 'h25;
            #10

            t_addr = 'h20;

            clk_en = 0;
            disable CLK_GEN;

        end
endmodule

