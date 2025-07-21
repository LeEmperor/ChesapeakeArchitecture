// Bohdan Purtell
// University Florida
// Design for Zero Padder
// STATUS : Verified Functional for Unsigned Padding
`timescale 1 ns / 1 ps

module zeroPadder_v1 (
    input logic [11:0] immediate,
    input logic [6:0] immediate_11_5,
    input logic [4:0] immediate_4_0,
    output logic [31:0] unsigned_zero_padded,
    output logic [11:0] offset_padded,
    output logic [31:0] signed_zero_padded
);
    assign unsigned_zero_padded = {20'b0, immediate};
    assign offset_padded = { 20'b0, immediate_11_5, immediate_4_0 };
    // assign signed_zero_padded = {};

    always @(*)
    begin
        if(immediate[11] == 1)
            signed_zero_padded = { {1'b1}, {19'b0}, immediate };
        else
            signed_zero_padded = { {20'b0}, immediate };
    end
endmodule

