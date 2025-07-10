// Bohdan Purtell
// University of Florida
// Testbench for Memory Toplevel Unit

`timescale 1 ns / 1 ps

module testbench_memory_v2();

    // monitors
    wire[6:0] t_seg0;
    wire[6:0] t_seg1;
    wire[31:0] t_dataout;

    // probes
    logic[3:0] t_buttons;
    logic t_write_enable;
    logic t_read_enable;

    logic [31:0] t_datain;
    logic [9:0] t_mem_addr;

    // cheese
    logic t_clk;
    logic t_rst;
    logic clk_en = 0;

    // dut
    memory_v2 dut (
        .clk(t_clk),
        .rst(t_rst),
        .mem_addr(t_mem_addr),
        .data_in(t_datain),
        .data_out(t_dataout),
        .write_enable(t_write_enable),
        .read_enable(t_read_enable),
        .button_array(t_buttons),
        .seg0(t_seg0),
        .seg1(t_seg1),
    );

    typedef struct {
        string test_name;
        logic [6:0] seg0;
        logic [6:0] seg1;
        logic [3:0] button_array;
        logic write_enable;
        logic read_enable;
        logic [31:0] data_in; 
        logic [31:0] data_out; 
        logic [9:0] addr;
    } testVector_t;


    localparam int n_tests = 10;
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
            t_rst = 0;
            // populate test vectors
            
            test[0] = '{
                test_name : "",
                seg0 : '0,
                seg1,: '0,
                button_array,: '0,
                write_enable,: 0,
                read_enable,: 0,
                data_in,: 32'd0,
                data_out,: 32'd0,
                addr,: 10'd0
            };

            clk_en = 1;

            for(i = 0; i < n_tests; i++) begin
                pass = 1;

                t_mem_addr




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
                    pass ? "PASSED!" : "FAILED!";

            end

            clk_en = 0;
            disable CLK_GEN;
        end

endmodule

