// Bohdan Purtell
// University of Florida
// Memory Unit Toplevel
`timescale 1 ns / 1 ps

module memory_v1 (
    input logic clk,
    input logic rst,

    input logic [9:0] mem_addr,
    input logic [31:0] data_in,
    output logic [31:0] data_out,
    input logic write_enable, 

    input logic [15:0] switch_array,
    input logic button0,
    input logic button1,
    input logic button2,
    input logic button3,
    input logic pmod_pin1,
    input logic pmod_pin2,

    output logic [6:0] seg0,
    output logic [6:0] seg1,
    output logic [6:0] seg2,
    output logic [6:0] seg3,
    output logic [6:0] seg4,
    output logic [6:0] seg5,
    output logic [6:0] seg6,
    output logic [6:0] seg7,
    output logic [7:0] memory_error_vector
);
    // internal signals
    logic [9:0] ram_addr;
    logic [31:0] ram_data_in;
    logic [31:0] ram_data_out;
    logic ram_wren;
 
    // RAM module
    ram_v1 ram1 (
        .clk(clk),
        .rst(rst),
        .wr_en(ram_wren),
        .in_data(ram_data_in),
        .out_data(ram_data_out),
        .actual_ram_addr()
    );

    integer i;

    always_ff @(posedge clk, posedge rst)
    begin
        if (rst) begin
            for(i = 0; i < 32; i++) begin
                // rest logic here
            end
        end else begin
            if (write_enable) begin // write op
                case (mem_addr)
                    32'hffff0000 : seg0 <= data_in[31:25];
                    32'hfffe0000 : seg1 <= data_in[31:25];
                    32'hfffd0000 : seg2 <= data_in[31:25];
                    32'hfffc0000 : seg3 <= data_in[31:25];
                    32'hfffb0000 : seg4 <= data_in[31:25];
                    32'hfffa0000 : seg5 <= data_in[31:25];
                    32'hfff90000 : seg6 <= data_in[31:25];
                    32'hfff80000 : seg7 <= data_in[31:25];
                    default : ram_addr <= mem_addr;
                endcase

            end else begin // read op
                case(mem_addr)
                    32'heeee0000 : data_out[15:0] = switch_array;
                    32'heeed0000 : data_out[0] = button0;
                    32'heeec0000 : data_out[0] = button1;
                    32'heeeb0000 : data_out[0] = button2;
                    32'heeea0000 : data_out[0] = button3;
                    32'heee90000 : data_out[0] = pmod_pin1;
                    32'heee80000 : data_out[0] = pmod_pin2;
                    default : memory_error_vector = 8'd255;
                endcase
            end
        end
    end
endmodule

