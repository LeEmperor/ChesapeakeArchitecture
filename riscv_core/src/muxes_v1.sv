// Bohdan Purtell
// University of Florida
// Set of different muxes
// NOTE: i know these can be fully parameterizeid with $clog2 but i don't care and my implementations dont call for muxes much bigger than what is present 
`timescale 1 ns / 1 ps

module mux2_v1 #(
    parameter int width = 32
) (
    input logic [width - 1:0] in1,
    input logic [width - 1:0] in2,
    output logic [width - 1:0] out1,
    input logic sel
);
    always_comb
    begin
        case (sel)
            1'b0 : out1 = in1;
            1'b1 : out1 = in2;
        endcase;
    end
endmodule

module mux4_v1 #(
    parameter int width = 32
) (
    input logic [width - 1:0] in1,
    input logic [width - 1:0] in2,
    input logic [width - 1:0] in3,
    input logic [width - 1:0] in4,
    output logic [width - 1:0] out1,
    input logic [1:0] sel
);
    always_comb
    begin
        case(sel)
            2'b00 : out1 = in1;
            2'b01 : out1 = in2;
            2'b10 : out1 = in3;
            2'b11 : out1 = in4;
        endcase
    end
endmodule

module demux4_v1 #(
    parameter int width = 32
) (
    input logic [width - 1 : 0] in1,
    input logic [1:0] sel,
    output logic [width - 1 : 0] out1,
    output logic [width - 1 : 0] out2,
    output logic [width - 1 : 0] out3,
    output logic [width - 1 : 0] out4
);
    always @(*)
        begin
            case(sel)
                2'd0 : out1 = in1;
                2'd1 : out2 = in1;
                2'd2 : out3 = in1;
                2'd3 : out4 = in1;
            endcase
        end
endmodule

module mux8_v1 #(
    parameter int width = 32
) (
    input logic [width - 1:0] in1,
    input logic [width - 1:0] in2,
    input logic [width - 1:0] in3,
    input logic [width - 1:0] in4,
    input logic [width - 1:0] in5,
    input logic [width - 1:0] in6,
    input logic [width - 1:0] in7,
    input logic [width - 1:0] in8,
    output logic [width - 1:0] out1,
    input logic [2:0] sel

);
    always_comb
    begin
        case(sel)
            3'b000 : out1 = in1;
            3'b001 : out1 = in2;
            3'b010 : out1 = in3;
            3'b011 : out1 = in4;
            3'b100 : out1 = in5;
            3'b101 : out1 = in6;
            3'b110 : out1 = in7;
            3'b111 : out1 = in8;
        endcase
    end
endmodule

module mux16_v1 #(
    parameter int width = 32
) (
    input logic [width - 1:0] in1,
    input logic [width - 1:0] in2,
    input logic [width - 1:0] in3,
    input logic [width - 1:0] in4,
    input logic [width - 1:0] in5,
    input logic [width - 1:0] in6,
    input logic [width - 1:0] in7,
    input logic [width - 1:0] in8,
    input logic [width - 1:0] in9,
    input logic [width - 1:0] in10,
    input logic [width - 1:0] in11,
    input logic [width - 1:0] in12,
    input logic [width - 1:0] in13,
    input logic [width - 1:0] in14,
    input logic [width - 1:0] in15,
    input logic [width - 1:0] in16,
    output logic [width - 1:0] out1,
    input logic [3:0] sel

);
    always_comb
        begin
            case(sel)
                'd0 : out1 = in1;
                'd1 : out1 = in2;
                'd2 : out1 = in3;
                'd3 : out1 = in4;
                'd4 : out1 = in5;
                'd5 : out1 = in6;
                'd6 : out1 = in7;
                'd7 : out1 = in8;
                'd8 : out1 = in9;
                'd9 : out1 = in10;
                'd10 : out1 = in11;
                'd11 : out1 = in12;
                'd12 : out1 = in13;
                'd13 : out1 = in14;
                'd14 : out1 = in15;
                'd15 : out1 = in16;
            endcase
        end
 
endmodule

