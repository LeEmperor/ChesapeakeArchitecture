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
        .actual_ram_addr(mem_addr)
    );

    // demux

    // mux (select what goes to out_port)
    // mux4_v1


    integer i;

    always_ff @(*)
    begin
        memory_error_vector = 8'd0; 
        // ram_addr = '0;

        if (write_enable) begin // write op
            case (mem_addr)
                10'h3ff : seg0 <= data_in[31:25];
                10'h3fe : seg1 <= data_in[31:25];
                10'h3fd : seg2 <= data_in[31:25];
                10'h3fc : seg3 <= data_in[31:25];
                10'h3fb : seg4 <= data_in[31:25];
                10'h3fa : seg5 <= data_in[31:25];
                10'h3f9 : seg6 <= data_in[31:25];
                10'h3f8 : seg7 <= data_in[31:25];
                default : ram_data_in <= data_in;
            endcase
        end else begin // read op
            case(mem_addr)
                10'h3ef : begin 
                    data_out[19:0] <= {button3, button2, button1, button0, switch_array};
                end
                10'h3ea : data_out[0] <= pmod_pin1;
                10'h3e9 : data_out[0] <= pmod_pin2;
                default : data_out <= ram_data_out; //memory_error_vector = 8'd255;
            endcase
        end
    end
endmodule

