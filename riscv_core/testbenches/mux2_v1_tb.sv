`timescale 1 ns / 1 ps
module testbench_mux2();

reg [31:0] t_in1, t_in2;
reg t_sel;
wire [31:0] t_out1;

mux2 dut(
    .in1(t_in1),
    .in2(t_in2),
    .out1(t_out1),
    .sel(t_sel)
    );

initial
begin
    t_in1 <= 32'hf8f8f8f8;
    t_in2 <= 32'hf7f7f7f7;
    t_sel <= 1'b0;
    #10;

    t_sel <= 1'b1;
    #10;

    // $finish;
end

endmodule

