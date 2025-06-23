// Bohdan Purtell
// University of Florida
// Register Testbench
`timescale 1 ns / 1 ps

module testbench_register_v1();
    // writeables
    logic [31:0] tb_write_data;
    logic tb_wr_en;

    // readables
    wire [31:0] tb_read_data;

    // control
    logic tb_clk, tb_rst;

    register_v1 dut(
        .wr_en(tb_wr_en),
        .rst(tb_rst),
        .clk(tb_clk),
        .data_in(tb_write_data),
        .data_out(tb_read_data),
        .register_error_vector()
    );

    typedef struct {
        string test_name;
    } testVector_t;

    localparam int n_tests = 2;
    testVector_t tests[n_tests];
    integer i;
    initial 
    begin
        // populate test_vectors

        // read to verify that nothing
        tests[0] = '{
            test_name : "read nil from default",


        };

        // write to the reg
        tests[1] = '{

        };

        // read the result
        tests[2] = '{

        };

        // reset the reg

    end

endmodule

