// Bohdan Purtell
// University of Florida
// Ram module (using inferred optionaries)
`timescale 1 ns / 1 ps

module ram_v1 #(
    parameter addr_width = 10,
    parameter data_width = 32

) (
    input logic clk,
    input logic rst,
    input logic WE,
    input logic [data_width - 1:0] data_in,
    output logic [data_width - 1:0] data_out,
    input logic [addr_width - 1:0] addr,
    output logic [7:0] ram_error_vector
);
    // ram unit
    logic [data_width - 1:0] mem [0:(1<<addr_width) - 1];

    // write process
    always @(posedge clk) begin
        if (WE) mem[addr] <= data_in;
    end

    assign data_out = mem[addr];
endmodule 

