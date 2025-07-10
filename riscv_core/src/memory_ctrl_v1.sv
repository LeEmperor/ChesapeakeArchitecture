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

    output logic [4:0] sel_mux_data_in, // mux to memory or to physical outputs
    output logic [4:0] sel_mux_data_out // select from memory or physical inputs
);

    always_comb
    begin
        if (wr_en) // write operation
            begin
                sel_mux_data_in  = 5'd0;
                sel_mux_data_out = 5'd0;

                if (addr >= 'h3ff)
                    begin
                        case (addr)
                            10'h3ff : sel_mux_data_in = 5'd1;
                            10'h3fe : sel_mux_data_in = 5'd2;
                            default : sel_mux_data_in = 5'd0;
                        endcase
                    end
            end
        else        // read operation
            begin
                sel_mux_data_in  = 5'd0;
                sel_mux_data_out = 5'd0;
            end
    end
endmodule

