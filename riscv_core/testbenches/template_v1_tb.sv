// Bohdan Purtell
// University of Florida
// Testbench Template v1

`timescale 1 ns / 1 ps

module ();

    // control 
    logic t_clk;
    logic t_rst;
    logic clk_en;

    // monitor
    wire  t_dataout;

    // probe
    logic t_datain;
    logic t_en;

    // dut
    dut (

    );

    typedef struct {
        string test_name;
        logic [31:0] data_in;
        logic [31:0] expected_dataout;
    } testVector_t;

    localparam int n_tests = 1;
    localparam int name_width = 30;
    testVector_t tests[n_tests];

    integer i;
    string name;
    string pad;
    int len;
    bit pass;

    initial begin : CLK_GEN
        t_clk = 0;
        forever #5 t_clk = ~t_clk & clk_en;
    end

    initial
        begin
            // populate test vectors
            t_rst = 0;

            tests[0] = '{
                test_name : "",
                data_in : 'h0,
                expected_dataout : 'h0
            };

            for

            for(i = 0; i < n_tests; i++) begin
                pass = 1;

                t_datain = tests[i].data_in;
                #10
                #10

                if (t_dataout !== tests[i].expected_dataout) begin
                    $error("Test [%1d] : {%s} - expected data mismatch --- EXPECTED: {%s}", i, tests[i].test_name, tests[i].data_out);
                    pass = 0;
                end

                // diagnostiques
                name = tests[i].test_name;
                len = name.len();
                pad = (len < name_width)
                    ? { (name_width - len) { "." } }
                    : "";

                $display(
                    "# Test [%1d] : {%s%0s} %s",
                    i + 1,
                    name, pad,
                    pass ? "PASSED!" : "FAILED!"
                );

            end

            clk_en = 0;
            disable CLK_GEN;


        end
endmodule

