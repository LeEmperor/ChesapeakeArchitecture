// Bohdan Purtell
// University of Florida
// Design Toplevel for Memory v3 (utiliser designe proper)
// STATUS: Completé et Vérifié Functionelle

module memory_v3 (
    input logic[9:0] addr,
    input logic WE,
    input logic clk,
    input logic rst,

    input logic[31:0] data_in,
    output logic[31:0] data_out,
    output logic[6:0] seg0,
    output logic[6:0] seg1,
    output logic[6:0] seg2,
    output logic[6:0] seg3,
    output logic[6:0] seg4,
    output logic[6:0] seg5,
    output logic[6:0] seg6,
    output logic[6:0] seg7,

    input logic[3:0] button_array,
    input logic[15:0] switch_array,

    output logic[7:0] memory_error_vector
);

    // ctrl 
    logic [1:0] SEL_dataInDemux;
    logic [1:0] SEL_dataOutMux;

    // routing
    // logic [31:0] wire_dataIn_to_dataInDemux;
    logic [31:0] wire_dataInDemux_to_RamData1;
    logic [6:0] wire_dataInDemux_to_Seg0;
    logic [6:0] wire_dataInDemux_to_Seg1;
    logic [31:0] wire_RamOut_to_DataOutMux;
    logic [31:0] wire_ButtonArray_padded;
    logic [31:0] wire_SwitchArray_padded;

    logic WE_seg0;
    logic WE_seg1;
    logic WE_seg2;
    logic WE_seg3;
    logic WE_seg4;
    logic WE_seg5;
    logic WE_seg6;
    logic WE_seg7;

    // assign wire_dataInDemux_to_Seg0 = 
    assign wire_ButtonArray_padded = { {16{1'b0}}, button_array };
    assign wire_SwitchArray_padded = { {28{1'b0}}, switch_array };

    ram_v1 RAM (
        .clk(clk),
        .rst(rst),
        .WE(WE),
        .data_in(wire_dataInDemux_to_RamData1),
        .data_out(wire_RamOut_to_DataOutMux),
        .addr(addr)
    );

    memory_ctrl_v2 Ctrl_Memory (
        .addr(addr),
        .WE(WE),
        .SEL_data_out_mux(SEL_dataOutMux),
        .SEL_data_in_demux(SEL_dataInDemux),
        .WE_seg0(WE_seg0),
        .WE_seg1(WE_seg1),
        .WE_seg2(),
        .WE_seg3(),
        .WE_seg4(),
        .WE_seg5(),
        .WE_seg6(),
        .WE_seg7()
    );

    register_v2 Reg_Seg0 (
        .clk(clk),
        .rst(rst),
        .data_in(wire_dataInDemux_to_Seg0),
        .data_out(seg0),
        .WE(WE_seg0)
    );

    register_v2 Reg_Seg1 (
        .clk(clk),
        .rst(rst),
        .data_in(wire_dataInDemux_to_Seg1),
        .data_out(seg1),
        .WE(WE_seg1)
    );

    mux4_v1 Mux_DataOut ( // selecter des le RAM, les buttons, ou les switches
        .in1(wire_RamOut_to_DataOutMux),
        .in2(wire_ButtonArray_padded),
        .in3(wire_SwitchArray_padded),
        .in4(), //pmod pins?
        .out1(data_out),
        .sel(SEL_dataOutMux)
    );

    demux4_v1 Demux_DataIn ( // selecter entres le RAM, 
        .in1(data_in),
        .out1(wire_dataInDemux_to_RamData1),
        .out2(wire_dataInDemux_to_Seg0),
        .out3(wire_dataInDemux_to_Seg1),
        .out4(),
        .sel(SEL_dataInDemux)
    );


endmodule

