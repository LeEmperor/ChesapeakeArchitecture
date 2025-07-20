// Bohdan Purtell
// University of Florida
// Memory Unit Controller (2) - en base des designes combinatinelle
// STATUS: Completé et functionnelle pour memory_v3

`timescale 1 ns / 1 ps


module memory_ctrl_v2 (
    input logic[9:0] addr,
    input logic WE,

    output logic[1:0] SEL_data_out_mux, // sèlecter des button arrays, et le RAM
    output logic[1:0] SEL_data_in_demux, // selecter aux RAM, ou les portes sorties

    output logic WE_seg0,
    output logic WE_seg1,
    output logic WE_seg2,
    output logic WE_seg3,
    output logic WE_seg4,
    output logic WE_seg5,
    output logic WE_seg6,
    output logic WE_seg7,

    output logic[7:0] memory_ctrl_error_vector
);

    always_comb
    begin
        SEL_data_out_mux = 0;
        SEL_data_in_demux = 0;

        WE_seg0 = 0;
        WE_seg1 = 0;
        WE_seg2 = 0;
        WE_seg3 = 0;
        WE_seg4 = 0;
        WE_seg5 = 0;
        WE_seg6 = 0;
        WE_seg7 = 0;

        if (WE) begin
            case(addr)
                10'h3ff : begin // seg0
                    SEL_data_in_demux = 'd1;
                    WE_seg0 = 1;
                end

                10'h3fe : begin // seg1
                    SEL_data_in_demux = 'd2;
                    WE_seg1 = 1;
                end

                default : begin
                    SEL_data_in_demux = 0;
                end
            endcase
        end else begin
            case(addr)
                10'h3ef : begin // button array
                    SEL_data_out_mux = 'd1;
                end

                10'h3ee : begin // switch array
                    SEL_data_out_mux = 'd2;
                end
                default : begin
                    SEL_data_out_mux = 0;
                end
            endcase
        end
    end




endmodule

