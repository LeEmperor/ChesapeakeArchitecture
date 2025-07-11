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
    logic [31:0] tb_outdata;

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
        clk_en = 1'b1;
        forever #5 tb_clk = ~tb_clk & clk_en;
    end

    integer i;
    integer data;
    localparam int ntests = 10;
    bit passed;

    initial begin
        // populate test vectors
        clk_en = 1'b1;
        #10

        for(i = 0; i < 10; i++) begin
            data = $urandom_range(0, (1<<32) - 1);
            tb_wren = 1;
            tb_addr = $urandom_range(0, (1<<10) - 1);
            tb_indata = data;
            #10;

            tb_wren = 0;
            assert(tb_outdata == data)
                $display("TEST (%0d) PASSED!", i + 1);
                else
                    $error("TEST (%0d) FAILED!", i + 1);
            #10;
        end
        
        clk_en = 1'b0;
        #10
        disable clk_gen;
    end
endmodule

