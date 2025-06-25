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
    input logic wr_en,
    input logic [data_width - 1:0] in_data,
    output logic [data_width - 1:0] out_data,
    input logic [addr_width - 1:0] actual_ram_addr,
    output logic [7:0] ram_error_vector
);
    // ram unit
    logic [data_width - 1:0] mem [0:(1<<addr_width) - 1];

    // write process
    always @(posedge clk) begin
        if (wr_en) mem[actual_ram_addr] <= in_data;
    end

    assign out_data = mem[actual_ram_addr];
endmodule 

