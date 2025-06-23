// Bohdan Purtell
// Univerity of Florida
// Register File v1 Testbench

`timescale 1ns/1ps

module testbench_registerFile_v1();

    logic [31:0] t_wrdata1;
    logic [31:0] t_wrdata2;
    logic [4:0] t_regaddr1;
    logic [4:0] t_regaddr2;
    logic [1:0] t_config = 2'd0;
    logic t_linkreg;

    wire [31:0] t_outdata1;
    wire [31:0] t_outdata2;

    logic t_clk;
    logic t_rst;
    logic clk_en = 1'b0;

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
        .reg_file_error_vector()
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

    localparam int n_tests = 2;
    localparam int name_width = 30;
    testVector_t tests[n_tests];

    integer i;
    string name;
    string pad;
    int len;
    bit pass;

    initial begin : CLK_GEN
        t_clk = 1'b0;
        forever #5 t_clk = ~t_clk & clk_en;
    end

    initial
    begin
        // populate test vectors
        t_rst = 1'b0;

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

        // 
        tests[1] = '{
            test_name : "wr to 1 and 2 reg",
            regaddr1 : 5'd1,
            regaddr2 : 5'd2,
            wrdata1 : 32'd15,
            wrdata2 : 32'd20,
            exp_outdata1 : 32'd15,
            exp_outdata2 : 32'd20,
            rdwr_config : 2'b11,
            linkreg : 1'b0
        };

        clk_en = 1'b1;

        for(i = 0; i < n_tests; i++) begin
            pass = 1;
            t_regaddr1 = tests[i].regaddr1;
            t_regaddr2 = tests[i].regaddr2;
            t_wrdata1 = tests[i].wrdata1;
            t_wrdata2 = tests[i].wrdata2;
            #10

            t_config = tests[i].rdwr_config;
            #10

            t_config = 2'b00;
            #10

            if (t_outdata1 !== tests[i].exp_outdata1) begin
                $error("Test [%1d] : {%s} - outdata1 mismatch", i, tests[i].test_name);
                pass = 0;
            end

            if (t_outdata2 !== tests[i].exp_outdata2) begin
                $error("Test [%1d] : {%s} - outdata2 mismatch", i, tests[i].test_name);
                pass = 0;
            end

            // if (passed) 
            //     $display("Test [%1d] : {%s} PASSED!", i + 1, tests[i].test_name);
            // else
            //     $display("Test [%1d] : {%s} FAILED!", i + 1, tests[i].test_name);

            name = tests[i].test_name;
            len = name.len();
            pad = (len < name_width)
                ? { (name_width - len) { "." } }
                : "";
            // pass = (t_outdata1 === tests[i].exp_outdata1)
                // && (t_outdata1 === tests[i].exp_outdata2);

            $display(
                "# Test [%1d] : {%s%0s} %s",
                i + 1,
                name, pad,
                pass ? "PASSED!" : "FAILED!"
            );

        end // end for loop

        clk_en = 1'b0;
        // $stop;
        disable CLK_GEN;
    end
endmodule

