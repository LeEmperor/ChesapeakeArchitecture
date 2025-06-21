// Bohdan Purtell
// Univerity of Florida

`timescale 1ns/1ps

module testbench_registerFile_v1();

    logic [31:0] t_wrdata1;
    logic [31:0] t_wrdata2;
    logic [31:0] t_rddata1;
    logic [31:0] t_rddata2;
    logic [4:0] t_regaddr1;
    logic [4:0] t_regaddr2;
    logic [1:0] t_config;
    logic t_linkreg;

    wire [31:0] t_outdata1;
    wire [31:0] t_outdata2;
    wire [7:0] t_debugvector;

    logic t_clk;
    logic t_rst;

    register_file_v1 dut(
        .reg_addr1(t_regaddr1),
        .reg_addr2(t_regaddr2),
        .wr_data1(t_wrdata1),
        .wr_data2(t_wrdata2),
        .rdwr_config(t_config),
        .link_reg(t_linkreg),
        .clk(t_clk),
        .rst(t_rst),

        .outdata1(t_outdata1),
        .outdata2(t_outdata2),
        .reg_file_error_vector(t_debugvector)
    );

    typedef struct {
        // debug
        string test_name;

        // entrées 
        logic [4:0] regaddr1;
        logic [4:0] regaddr2;

        logic [31:0] wrdata1;
        logic [31:0] wrdata2;

        logic [1:0] rdwr_config;
        logic linkreg;

        // sorties expectés
        logic [31:0] exp_outdata1;
        logic [31:0] exp_outdata2;
    } testVector_t;

    localparam int n_tests = 20;
    testVector_t tests[n_tests];

    integer i;
    initial
    begin
        // populate test vectors

        // write to 0 reg
        tests[0] = '{
            test_name : "Wr to 0 reg",
            regaddr1 : 5'd0,
            regaddr2 : 5'd0,
            wrdata1 : 32'd5,
            wrdata2 : 32'd5,
            exp_outdata1 : 32'd0,
            exp_outdata2 : 32'd0,
            rdwr_config : 2'b11,
            linkreg : 1'b0
        };

        for(i = 0; i < n_tests; i++) begin
            t_regaddr1 = tests[i].regaddr1;
            t_regaddr2 = tests[i].regaddr2;
            t_wrdata1 = tests[i].wrdata1;
            t_wrdata2 = tests[i].wrdata2;
            t_config = tests[i].rdwr_config;
            #10

            t_config = 2'b00;
            #10
            assert (t_outdata1 === tests[i].exp_outdata1)
                else $error("Test [%0d]");

            assert (t_outdata2 === tests[i].exp_outdata2)
                else $error("Test ");

            $display("Test [%d] : {%s} PASSED!", i + 1, tests[i].test_name);
        end
    end

endmodule

