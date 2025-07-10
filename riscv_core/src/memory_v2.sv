// Bohdan Purtell
// University of Florida
// Memory Unit Toplevel Structural
`timescale 1 ns / 1 ps

module memory_v2 #(
    parameter int addr_width = 10,
    parameter int data_width = 32
) (
    input logic clk,
    input logic rst,

    input logic [addr_width - 1 : 0] mem_addr,
    input logic [data_width - 1 : 0] data_in,
    output logic [data_width - 1 : 0] data_out,
    input logic write_enable,
    input logic read_enable,

    input logic [14:0] pmod_in,
    output logic [14:0] pmod_out,
    input logic [3:0] button_array,

    output logic [6:0] seg0,
    output logic [6:0] seg1,
    output logic [6:0] seg2,
    output logic [6:0] seg3,
    output logic [6:0] seg4,
    output logic [6:0] seg5,
    output logic [6:0] seg6,
    output logic [6:0] seg7,

    // 11 outport banks in total = 4 bits

    output logic [7:0] memory_error_vector
        // 1A
        // 2A
        // 3A
        //
);

    // intermediaries
    logic ram_wren;
    logic [data_width - 1 : 0] ram_data_in;
    logic [data_width - 1 : 0] ram_data_out;
    logic [addr_width - 1 : 0] ram_addr;

    logic [4:0] wire_sel_mux_data_in;
    logic [4:0] wire_sel_mux_data_out;

    ram_v1 ram1 (
        .clk(clk),
        .rst(rst),
        .wr_en(ram_wren),
        .in_data(ram_data_in),
        .out_data(ram_data_out),
        .actual_ram_addr(ram_addr)
    );

    // mux data_in (push the fed data to RAM or the output ports)
    mux4_v1 data_in_mux (
        
    );


    //  mux data_out  (feed the outport with the RAM data or the input ports)
    mux4_v1 data_out_mux (

    );

    // controller
    memory_ctrl_v1 controller (
        .wr_en(write_enable),
        .rd_en(read_enable),
        .addr(mem_addr),
        .sel_mux_data_in(wire_sel_mux_data_in),
        .sel_mux_data_out(wire_sel_mux_data_out)
    );


endmodule

