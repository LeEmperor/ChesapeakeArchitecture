`timescale 1 ns / 1 ps

module toplevel_v1 (
    input logic [15:0] switch_array,
    input logic clk, rst,
    output logic [6:0] seg0,
    output logic [6:0] seg1,
    output logic [6:0] seg2,
    output logic [6:0] seg3,
    output logic [6:0] seg4,
    output logic [6:0] seg5,
    output logic [6:0] seg6,
    output logic [6:0] seg7,
    output logic [7:0] toplevel_error_vector
);

    controller_v1 controller1 (
        .clk(clk),
        .rst(rst),

        .funct7(),
        .opcode(),
        .alu_src_a(),
        .alu_src_b(),

        .current_state_vector(),
        .next_state_vector(),

        .next_state_error_vector(),
        .moore_map_error_vector()
    );


endmodule

