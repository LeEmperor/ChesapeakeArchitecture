// Bohdan Purtell
// University of Florida
// Register File v1

`timescale 1ns/1ps
module register_file_v1(
    input logic [4:0] reg_addr1,
    input logic [4:0] reg_addr2,
    input logic [31:0] wr_data1,
    input logic [31:0] wr_data2,
    input logic [1:0] rdwr_config,
    input logic link_reg,
    input logic clk, rst,

    output logic [31:0] outdata1,
    output logic [31:0] outdata2,
    output logic [7:0] reg_file_error_vector 
);

    // 2d array pour le data
    logic [31:0] reg_file_data [0:31] = '{ default: '0 };

    // asynch lires 
    assign outdata1 = (reg_addr1 == 5'd0) ? 32'd0 : reg_file_data[reg_addr1];
    assign outdata2 = (reg_addr2 == 5'd0) ? 32'd0 : reg_file_data[reg_addr2];

    integer i;
    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            for(i = 0; i < 32; i = i + 1) begin
                reg_file_data[i] <= 32'd0;
            end
        end else begin
            case (rdwr_config)
                2'b00 : begin // r1 r2
                    // nothing
                end

                2'b01 : begin // w1 r2
                    reg_file_data[reg_addr1] <= (reg_addr1 == 5'd0) ? 32'b0 : wr_data1;
                end

                2'b10 : begin // r1 w2
                    reg_file_data[reg_addr1] <= (reg_addr2 == 5'd0) ? 32'b0 : wr_data2;
                end

                2'b11 : begin // w1 w2
                    reg_file_data[reg_addr1] <= (reg_addr1 == 5'd0) ? 32'b0 : wr_data1;
                    reg_file_data[reg_addr2] <= (reg_addr2 == 5'd0) ? 32'b0 : wr_data2;
                end

                default begin
                    reg_file_error_vector <= '0;
                end
            endcase // endcase rdwr_config
        end // end else
    end
endmodule

