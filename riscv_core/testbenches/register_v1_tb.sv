// Bohdan Purtell
// University of Florida
// Testbench Template v1

`timescale 1 ns / 1 ps

module testbench_register_v1();

    // control 
    logic t_clk;
    logic t_rst;
    logic clk_en;

    // monitor
    wire [31:0] t_dataout;

    // probe
    logic [31:0] t_datain;
    logic t_en;
    logic t_wren;

    // dut
    register_v1 dut (
        .wr_en(t_wren),
        .rst(t_rst),
        .clk(t_clk),
        .data_in(t_datain),
        .data_out(t_dataout)
    );

    typedef struct {
        string test_name;
        logic [31:0] data_in;
        logic [31:0] expected_dataout;
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
            clk_en = 1;
            t_datain = 32'h528;
            t_wren = 0;
            #10

            t_wren = 1;
            #10

            t_datain = 32'h120;
            t_wren = 0;
            #10

            t_wren = 1;
            #10

            clk_en = 0;
            disable CLK_GEN;
        end
endmodule

