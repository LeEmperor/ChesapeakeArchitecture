// Bohdan Purtell
// University of Florida
// STATUS: Functionelle, et confirmé que c'est synthesize à un seul registre

`timescale 1 ns / 1 ps

module register_v2 (
    input logic WE,
    input logic RE,
    input logic clk,
    input logic rst,
    input logic [31:0] data_in,
    output logic [31:0] data_out
);

    always @(posedge clk or posedge rst)
    begin
        if (rst) begin
            data_out = 0;
        end else begin
            if (WE) begin
                data_out = data_in;
            end
        end
    end

endmodule

