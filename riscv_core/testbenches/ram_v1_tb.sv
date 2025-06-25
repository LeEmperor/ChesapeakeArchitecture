// Bohdan Purtell
// University of Florida
// Ram Testbench
`timescale 1 ns / 1 ps

module testbench_ram_v1 ();

    // clk signals
    logic tb_clk = 1'b0;
    logic tb_rst = 1'b0;
    logic clk_en = 1'b0;

    // control signals
    logic tb_wren = 1'b0;
    logic [31:0] tb_indata = 32'b0;
    logic [9:0] tb_addr ='0;

    // output signals
    wire [31:0] tb_outdata = 32'b0;

    // dut
    ram_v1 dut (
        .clk(tb_clk),
        .rst(tb_rst),
        .wr_en(tb_wren),
        .in_data(tb_indata),
        .out_data(tb_outdata),
        .actual_ram_addr(tb_addr)
    );

    // clk proc
    initial begin : clk_gen 
        forever #5 tb_clk = ~tb_clk & clk_en;
    end

    initial begin
        // populate test vectors
        clk_en = 1'b1;
        tb_indata = 32'd260;
        tb_addr = 10'd5;
        tb_wren = 1'b1;
        #10

        // run tests
        tb_wren = 1'b0;
        assert(tb_outdata == 32'd260)
            $display ("TEST 1: PASSED!");
            else
                $error("TEST 1: FAILED!");
        #10

        clk_en = 1'b0;
        #10
        disable clk_gen;
    end
endmodule

