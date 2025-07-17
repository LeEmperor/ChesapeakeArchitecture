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

    output logic seg0_wren,
    output logic seg1_wren,
    output logic seg2_wren,
    output logic seg3_wren,
    output logic seg4_wren,
    output logic seg5_wren,
    output logic seg6_wren,
    output logic seg7_wren,

    output logic [1:0] sel_mux_data_in, // mux to memory or to physical outputs
    output logic [1:0] sel_mux_data_out // select from memory or physical inputs
);
    always_ff @(posedge clk or posedge rst)
    begin
        if(rst)
            begin
                sel_mux_data_in <= 0;
                sel_mux_data_out <= 0;
            end
        else
            begin
                sel_mux_data_in <= 0;
                sel_mux_data_out <= 0;
                seg0_wren <= 0;
                seg1_wren <= 0;
                seg2_wren <= 0;
                seg3_wren <= 0;
                seg4_wren <= 0;
                seg5_wren <= 0;
                seg6_wren <= 0;
                seg7_wren <= 0;

                if(wr_en) 
                    begin
                        if (addr >= 10'h3f0)
                            begin
                                case(addr)
                                    10'h3ff : begin
                                        sel_mux_data_in <= 'd1; // seg0
                                        seg0_wren <= 1;
                                    end

                                    10'h3fe : begin
                                        sel_mux_data_in <= 'd2; // seg1 
                                        seg1_wren <= 1;
                                    end
                                endcase
                            end
                    end
                else
                    begin
                        sel_mux_data_out <= 0;
                        if (addr == 'h3ef) begin
                            sel_mux_data_out <= 'd1; // button array
                        end
                    end
            end
    end
endmodule

