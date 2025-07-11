// Bohdan Purtell
// University of Florida
// Memory Unit Controller

`timescale 1 ns / 1 ps

module memory_ctrl_v1 #(
    parameter int addr_width = 10,
    parameter int data_width = 32
) (
    input logic wr_en,
    input logic rd_en,
    input logic [addr_width - 1 : 0] addr,

    input logic clk,
    input logic rst,

    output logic [4:0] sel_mux_data_in, // mux to memory or to physical outputs
    output logic [4:0] sel_mux_data_out // select from memory or physical inputs
);
    always_ff @(posedge clk)
    begin
        sel_mux_data_in <= 0;
        sel_mux_data_out <= 0;

        if(rst)
            begin
                sel_mux_data_in <= 0;
                sel_mux_data_out <= 0;
            end
        else
            sel_mux_data_in <= 0;
            sel_mux_data_out <= 0;
            begin
                if(wr_en) 
                    begin
                        if (addr >= 10'h3f0)
                            begin
                                case(addr)
                                    10'h3ff : sel_mux_data_in <= 5'd1; // seg0
                                    10'h3fe : sel_mux_data_in <= 5'd2; // seg1
                                endcase
                            end
                    end
                else
                    begin
                        sel_mux_data_out <= 0;
                        if (addr == 'h3ef) begin
                            sel_mux_data_out <= 5'd1; // button array
                        end
                    end
            end
    end
endmodule

