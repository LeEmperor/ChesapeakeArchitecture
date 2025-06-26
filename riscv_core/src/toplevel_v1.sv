`timescale 1 ns / 1 ps

module toplevel_v1 (
    input logic rst,

    input logic [15:0] switch_array,
    input logic button0,
    input logic button1,
    input logic button2,
    input logic button3,
    output logic [6:0] seg0,
    output logic [6:0] seg1,
    output logic [6:0] seg2,
    output logic [6:0] seg3,
    output logic [6:0] seg4,
    output logic [6:0] seg5,
    output logic [6:0] seg6,
    output logic [6:0] seg7,

    // diagnostiques
    input logic [31:0] diagnostique_instruction,
    output logic [7:0] toplevel_error_vector
);

    // control lines
    logic [1:0] sel_alu_src_a;
    logic [2:0] sel_alu_src_b;
    logic [1:0] sel_pc_source;
    logic [1:0] sel_ir_source;
    logic [1:0] sel_memdata;
    logic [1:0] sel_memaddr;
    logic en_wr_regA;
    logic en_wr_regB;
    logic en_wr_PC;
    logic en_wr_IR;
    logic en_wr_MEM;

    // data lines
    logic [31:0] wire_regdata1_to_muxA;
    logic [31:0] wire_regdata2_to_muxB;
    logic [31:0] wire_muxA_to_regA;
    logic [31:0] wire_muxB_to_regB;
    logic [31:0] wire_muxMEMDATA_to_mem;
    logic [31:0] wire_muxMEMADDR_to_mem;

    logic [31:0] wire_regA_to_ALU;
    logic [31:0] wire_regB_to_ALU;

    logic [31:0] wire_muxIR_to_regIR;
    logic [31:0] wire_muxPC_to_regPC;
    logic [31:0] wire_regPC_to_muxMEM_DATA;
    logic [31:0] wire_regPC_to_muxMEM_ADDR;

    logic [31:0] wire_ALU_result;

    // wire lines
    logic [31:0] ir_31_0; // whole instruction
    logic [11:0] ir_31_20; // imediate
    logic [4:0] ir_19_15; // rs1
    logic [4:0] ir_24_20; // rs2
    logic [6:0] ir_31_25; // funct7
    logic [2:0] ir_14_12; // funct3
    logic [6:0] ir_6_0; // opcode

    // assigns
    assign ir_31_25 = ir_31_0[31:25];

    controller_v1 controller1 (
        .clk(clk),
        .rst(rst),

        // source commands
        .funct7(ir_31_25),
        .funct3(ir_14_12),
        .opcode(ir_6_0),
        .ir_31_0(ir_31_0),

        // control lines
        .alu_src_a(sel_alu_src_a),
        .alu_src_b(sel_alu_src_b),
        .ir_source(sel_ir_source),
        .pc_source(sel_pc_source),

        // write enables
        .ir_write(en_wr_IR),
        .reg_a_write(en_wr_regA),
        .reg_b_write(en_wr_regA),
        .pc_write(en_wr_PC),
        .mem_write(en_wr_MEM),

        .current_state_vector(),
        .next_state_vector(),

        .next_state_error_vector(),
        .moore_map_error_vector()
    );

    register_file_v1 register_file1 (
        .clk(clk),
        .rst(rst),

        .reg_addr1(ir_19_15),
        .reg_addr2(ir_24_20),
        .wr_data1(),
        .wr_data2(),
        .rdwr_config(),
        .link_reg(),

        .outdata1(wire_regdata1_to_muxA),
        .outdata2(wire_regdata2_to_muxB),
        .reg_file_error_vector()
    );

    ALU_v1 alu1 (
        .a(wire_regA_to_ALU),
        .b(wire_regB_to_ALU),
        .out(wire_ALU_result),
        .op_code(),
        .zero_flag(),
        .sign_flag(),
        .alu_error_vector()
    );

    register_v1 reg_a (
        .clk(clk),
        .rst(rst),
        .wr_en(en_wr_regA),
        .data_in(wire_muxA_to_regA),
        .data_out(wire_regA_to_ALU)
    );

    register_v1 reg_b (
        .clk(clk),
        .rst(rst),
        .wr_en(en_wr_regB),
        .data_in(wire_muxA_to_regB),
        .data_out(wire_regB_to_ALU)
    );

    register_v1 reg_ir (
        .clk(clk),
        .rst(rst),
        .wr_en(en_wr_IR),
        .data_in(wire_muxIR_to_regIR),
        .data_out(ir_31_0)
    );

    register_v1 reg_pc (
        .clk(clk),
        .rst(rst),
        .wr_en(en_wr_PC),
        .data_in(wire_muxPC_to_regPC),
        .data_out(wire_regPC_to_muxMEM_ADDR)
    );

    // mem unit
    memory_v1 memory (
        .clk(clk),
        .rst(rst),
        .mem_addr(wire_muxMEMADDR_to_mem),
        .data_in(wire_muxMEMDATA_to_mem),
        .data_out(wire_memory_to_muxIR),
        .switch_array(switch_array)
    );

    mux4_v1 mux_MEMDATA (
        .in1(wire_ALU_result),
        .out1(wire_muxMEMDATA_to_mem),
        .sel(sel_memdata)
    );

    mux4_v1 mux_MEMADDR (
        .in1(wire_regPC_to_muxMEM_ADDR),
        .out1(wire_muxMEMADDR_to_mem),
        .sel(sel_memaddr)
    );

    mux4_v1 mux_regA (
        .in1(wire_regdata1_to_muxA),
        .in2(),
        .in3(),
        .in4(),
        .out1(wire_muxA_to_regA),
        .sel(sel_alu_src_a)
    );

    mux8_v1 mux_regB (
        .in1(wire_regdata2_to_muxB),
        .in2(),
        .in3(),
        .in4(),
        .in5(),
        .in6(),
        .in7(),
        .in8(),
        .out1(wire_muxB_to_regB),
        .sel(sel_alu_src_b)
    );
    
    mux4_v1 mux_pc (
        .in1(),
        .in2(),
        .in3(),
        .in4(),
        .out1(wire_muxPC_to_regPC),
        .sel(sel_pc_source)
    );

    mux4_v1 mux_ir (
        .in1(wire_memory_to_muxIR),
        .in2(),
        .in3(),
        .in4(),
        .out1(wire_muxIR_to_regIR),
        .sel(sel_ir_source)
    );

endmodule

