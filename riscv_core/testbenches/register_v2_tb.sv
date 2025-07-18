// Bohdan Purtell
// University of Florida
// Testbench pour Async Charté Registres
// Description: C'est pour testing très brève
// STATUS: Functionelle

`timescale 1 ns / 1 ps

module testbench_register_v2();

    // control 
    logic t_clk;
    logic t_rst;
    logic clk_en;

    // monitor
    wire [31:0] t_dataout;

    // probe
    logic [31:0] t_datain;
    logic t_en;

    // dut
    register_v2 dut (
        .WE(t_en),
        .RE(),
        .clk(t_clk),
        .rst(t_rst),
        .data_in(t_datain),
        .data_out(t_dataout)
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
            t_datain = 32'h123;
            t_en = 0;
            #10

            t_en = 1;
            #10

            clk_en = 0;
            disable CLK_GEN;

        end
endmodule

