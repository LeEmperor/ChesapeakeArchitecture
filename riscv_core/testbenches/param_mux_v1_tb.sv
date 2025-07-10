// Bohdan Purtell
// University of Florida
// Testbench for Parameterized Muxes
// UPDATE: note used, can't figure these things out

`timescale 1 ns / 1 ps
module testbench_param_mux_v1();


    // test signals
    logic [1:0][31:0] t_in2;
    logic [31:0] t_out2;

    logic t_sel2;

    // dut for 2 mux
    param_mux_v1 #(
        .X(2)
    ) mux2 (
        .i_data(),
        .o_data(),
        .onehot()
    );

    initial 
        begin



        end

    // dut for 4 mux


    // dut for 8 mux

endmodule

