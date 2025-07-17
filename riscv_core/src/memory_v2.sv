// Bohdan Purtell
// University of Florida
// Memory Unit Toplevel Structural
// STATUS: INCOMPLETE, need to rework with a combinational controller
// (basically a decoder)
//      AMENDED: this works when the clk fram eis high to low (aka 1 cycle is
//      H for 5 ns, then L for 5 ns)
//      wtf does this even mean?
//
//      the final output also needs an additional 5ns to complete???
//      this appears to be some sort of 5 ns offset that is required?
//          this is a clcok edge mismatch then no?
//          if the controller is deciding on LH clocks and this needs HL
//          clocks then we have a big issue in synchronization?
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
    input logic [15:0] switch_array,

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
    logic en_ram_wren;
    logic [data_width - 1 : 0] wire_ram_data_in;
    logic [data_width - 1 : 0] wire_ram_data_out;
    logic [addr_width - 1 : 0] wire_ram_addr;

    logic [1:0] wire_sel_mux_data_in;
    logic [1:0] wire_sel_mux_data_out;

    logic [31:0] wire_demux_to_ram;
    logic [31:0] wire_demux_to_seg0;
    logic [31:0] wire_demux_to_seg1;
    logic [31:0] wire_demux_to_seg2;
    logic [31:0] wire_demux_to_seg3;
    logic [31:0] wire_demux_to_seg4;
    logic [31:0] wire_demux_to_seg5;
    logic [31:0] wire_demux_to_seg6;
    logic [31:0] wire_demux_to_seg7;
    logic [31:0] wire_buttonarray_padded;
    logic [31:0] wire_switcharray_padded;

    logic WE_seg0;
    logic WE_seg1;
    logic WE_seg2;
    logic WE_seg3;
    logic WE_seg4;
    logic WE_seg5;
    logic WE_seg6;
    logic WE_seg7;

    assign wire_ram_addr = mem_addr;
    assign wire_buttonarray_padded = { {28{1'b0}}, button_array[3:0] };
    assign wire_switcharray_padded = { {16{1'b0}}, switch_array[15:0] };
    assign en_ram_wren = write_enable;
    // assign seg0 = wire_demux_to_seg0;
    // assign seg1 = wire_demux_to_seg1;
    // assign seg2 = wire_demux_to_seg2;
    // assign seg3 = wire_demux_to_seg3;
    // assign seg4 = wire_demux_to_seg4;
    // assign seg5 = wire_demux_to_seg5;
    // assign seg6 = wire_demux_to_seg6;
    // assign seg7 = wire_demux_to_seg7;

    ram_v1 ram1 (
        .clk(clk),
        .rst(rst),
        .wr_en(en_ram_wren),
        .in_data(wire_demux_to_ram),
        .out_data(wire_ram_data_out),
        .actual_ram_addr(wire_ram_addr)
    );

    // mux data_in (push the fed data to RAM or the output ports)
    demux4_v1 data_in_demux (
        .in1(data_in),
        .out1(wire_demux_to_ram), // feed ram
        .out2(wire_demux_to_seg0), // seg0 
        .out3(wire_demux_to_seg1), // seg1
        .out4(wire_demux_to_seg2),
        .sel(wire_sel_mux_data_in)
    );

    //  mux data_out  (feed the outport with the RAM data or the input ports)
    mux4_v1 data_out_mux (
        .in1(wire_ram_data_out), // source ram
        .in2(wire_buttonarray_padded), // button array
        .in3(wire_switcharray_padded), // switch array
        .in4(),
        .out1(data_out),
        .sel(wire_sel_mux_data_out)
    );

    // controller
    memory_ctrl_v1 controller (
        .wr_en(write_enable),
        .rd_en(read_enable),
        .clk(clk),
        .rst(rst),
        .addr(mem_addr),
        .seg0_wren(WE_seg0),
        .seg1_wren(WE_seg1),
        .seg2_wren(WE_seg2),
        .seg3_wren(WE_seg3),
        .seg4_wren(WE_seg4),
        .seg5_wren(WE_seg5),
        .seg6_wren(WE_seg6),
        .seg7_wren(WE_seg7),
        .sel_mux_data_in(wire_sel_mux_data_in),
        .sel_mux_data_out(wire_sel_mux_data_out)
    );

    register_v1 reg_seg0 (
        .wr_en(WE_seg0),
        .rst(rst),
        .clk(clk),
        .data_in(wire_demux_to_seg0),
        .data_out(seg0)
    );

    register_v1 reg_seg1 (
        .wr_en(WE_seg1),
        .rst(rst),
        .clk(clk),
        .data_in(wire_demux_to_seg1),
        .data_out(seg1)
    );

    register_v1 reg_seg2 (
        .wr_en(),
        .rst(),
        .clk(),
        .data_in(),
        .data_out()
    );

    register_v1 reg_seg3 (
        .wr_en(),
        .rst(),
        .clk(),
        .data_in(),
        .data_out()
    );

    register_v1 reg_seg4 (
        .wr_en(),
        .rst(),
        .clk(),
        .data_in(),
        .data_out()
    );

    register_v1 reg_seg5 (
        .wr_en(),
        .rst(),
        .clk(),
        .data_in(),
        .data_out()
    );

    register_v1 reg_seg6 (
        .wr_en(),
        .rst(),
        .clk(),
        .data_in(),
        .data_out()
    );

    register_v1 reg_seg7 (
        .wr_en(),
        .rst(),
        .clk(),
        .data_in(),
        .data_out()
    );


endmodule

