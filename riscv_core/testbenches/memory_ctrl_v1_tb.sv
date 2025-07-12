// Bohdan Purtell
// University of Florida
// Memory Ctrl Testbench
//  STATUS: working for basic address decodes

`timescale 1 ns / 1 ps

module testbench_memory_ctrl_v1();

    // control 
    logic t_clk;
    logic t_rst;
    logic clk_en = 0;

    // monitor
    wire t_dataout;

    // probe
    logic [31:0] t_datain;
    logic [9:0] t_addr;
    logic t_en;
    logic t_wr_en;
    logic t_rd_en;
    wire [4:0] t_sel_mux_data_in;
    wire [4:0] t_sel_mux_data_out;

    // dut
    memory_ctrl_v1 dut (
        .wr_en(t_wr_en),
        .rd_en(t_rd_en),
        .addr(t_addr),
        .clk(t_clk),
        .rst(t_rst),
        .sel_mux_data_in(t_sel_mux_data_in),
        .sel_mux_data_out(t_sel_mux_data_out)
    );

    initial begin : CLK_GEN
        t_clk = 0;
        forever #5 t_clk = ~t_clk & clk_en;
    end

    initial
        begin
            t_rst = 0;
            clk_en = 1;
            t_wr_en = 0;
            #10

            t_addr = 0;
            #10

            t_datain = 32'h25;
            #10

            t_addr = 10'h3ff; // seg0
            t_wr_en = 1;
            #10

            t_addr = 10'h3fe; // seg1
            #10

            t_wr_en = 0;
            #10

            t_wr_en = 0;
            t_addr = 10'h3ef; // button array
            #10

            clk_en = 0;
            disable CLK_GEN;
        end
endmodule

