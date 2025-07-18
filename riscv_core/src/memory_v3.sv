// Bohdan Purtell
// University of Florida
// Design Toplevel for Memory v3 (utiliser designe proper)

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

    output logic[7:0] memory_error_vector
);

    // ctrl 
    logic [1:0] SEL_dataInDemux;
    logic [1:0] SEL_dataOutMux;

    // routing
    logic [31:0] wire_dataIn_to_dataInDemux;
    logic [31:0] wire_dataInDemux_to_RamData1;
    logic [6:0] wire_dataInDemux_to_Seg0;
    logic [6:0] wire_dataInDemux_to_Seg1;

    assign wire_dataInDemux_to_Seg0 = 
        

    ram_v1 ram(
        .clk(clk),
        .rst(rst)
        .data_in(wire_dataInDemux_to_RamData1),
        .data_out(),
        .addr()
    );


endmodule

