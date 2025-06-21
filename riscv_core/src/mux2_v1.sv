`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Florida
// Engineer: Bohdan Purtell
// 
// Create Date: 06/01/2025 04:18:03 PM
// Design Name: 
// Module Name: code_mux2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux2(
    input [31:0] in1,
    input [31:0] in2,
    output reg [31:0] out1,
    input sel
    );

    always @(*) 
    begin
        case (sel)
            1'b0 : out1 <= in1;
            1'b1 : out1 <= in2;
        endcase;
    end
endmodule

