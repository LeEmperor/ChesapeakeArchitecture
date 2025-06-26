// Bohdan Purtell
// University of Florida
// Memory Unit Testbench
`timescale 1 ns / 1 ps

module testbench_memory_v1 ();

    logic tb_clk, tb_rst;
    logic clk_en;

    // input signals
    logic [9:0] tb_addr;
    logic tb_wren;
    logic [31:0] tb_datain;

    // output signals
    logic [31:0] tb_dataout;

    logic [15:0] tb_switch_array;
    logic tbbutton0;
    logic tbbutton1;
    logic tbbutton2;
    logic tbbutton3;

    logic [6:0] tb_seg0;
    logic [6:0] tb_seg1;
    logic [6:0] tb_seg2;
    logic [6:0] tb_seg3;
    logic [6:0] tb_seg4;
    logic [6:0] tb_seg5;
    logic [6:0] tb_seg6;
    logic [6:0] tb_seg7;

    logic tb_pmod_pin1;
    logic tb_pmod_pin2;

    // dut
    memory_v1 dut (
        .clk(tb_clk),
        .rst(tb_rst),
        .mem_addr(),
        .data_in(),
        .data_out(),
        .write_enable(),

        .switch_array(),
        .button0(),
        .button1(),
        .button2(),
        .button3(),

        .pmod_pin1(),
        .pmod_pin2(),

        .seg0(),
        .seg1(),
        .seg2(),
        .seg3(),
        .seg4(),
        .seg5(),
        .seg6(),
        .seg7()
    );

    initial begin : clk_gen
        clk_en = 1;
        tb_clk = 0;

        forever #5 tb_clk = ~tb_clk & clk_en;
    end



    integer i;
    localparam int ntests = 20;
    bit passed;



    initial begin
        // populate test vectors
        test[0] 


        clk_en = 0;
        #10
        disable clk_gen;
    end

endmodule

