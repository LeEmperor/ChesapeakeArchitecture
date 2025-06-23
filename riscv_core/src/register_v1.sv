// Bohdan Purtell
`timescale 1 ns / 1 ps

module register_v1 (

    input logic wr_en,
    input logic rst,
    input logic clk,
    input logic [31:0] data_in,
    input logic [31:0] data_out,
    output logic [7:0] register_error_vector
);
    
    // the internal register
    logic [31:0] reg_storage;
    assign data_out = reg_storage;

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            begin
                reg_storage <= 32'd0;
            end
        else
            begin
                if (wr_en)
                    begin
                        reg_storage <= data_in;
                    end
            end
    end

endmodule

