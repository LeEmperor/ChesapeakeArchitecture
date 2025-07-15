`timescale 1 ns / 1 ps

module toplevel_v1 (
    input logic rst,
    input logic clk,

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
    input logic ir_config,

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
    logic [1:0] sel_alu_result;
    logic [1:0] sel_regfile_in;
    logic [1:0] sel_rdwr_config;

    logic en_wr_regA;
    logic en_wr_regB;
    logic en_wr_PC;
    logic en_wr_IR;
    logic en_wr_MEM;
    logic en_wr_alu_result;
    logic en_wr_alu_result_lo;
    logic en_wr_alu_result_hi;
    logic en_wr_link_reg;

    // data lines
    logic [31:0] wire_regdata1_to_muxA;
    logic [31:0] wire_regdata2_to_muxB;
    logic [31:0] wire_muxA_to_regA;
    logic [31:0] wire_muxB_to_regB;
    logic [31:0] wire_muxMEMDATA_to_mem;
    logic [31:0] wire_muxMEMADDR_to_mem;

    logic [31:0] wire_regA_to_ALU;
    logic [31:0] wire_regB_to_ALU;
    logic [11:0] wire_immediate_to_padder;
    logic [31:0] wire_unsignedpadder_to_muxB;
    logic [31:0] wire_signedpadder_to_muxB;

    logic [31:0] wire_muxIR_to_regIR;
    logic [31:0] wire_muxPC_to_regPC;
    logic [31:0] wire_regPC_to_muxMEM_DATA;
    logic [31:0] wire_regPC_to_muxMEM_ADDR;

    logic [31:0] wire_muxRegfile_to_regfile;

    logic [31:0] wire_ALU_result;
    logic [31:0] wire_ALU_result_lo;
    logic [31:0] wire_ALU_result_hi;

    logic [31:0] wire_ALU_result_to_result_sel;
    logic [31:0] wire_ALU_result_lo_to_result_sel;
    logic [31:0] wire_ALU_result_hi_to_result_sel;
    logic [31:0] wire_ALU_result_selected;

    logic [31:0] wire_memory_to_muxIR;

    // wire lines
    logic [31:0] ir_31_0; // whole instruction
    logic [11:0] ir_31_20; // immediate
    logic [4:0] ir_19_15; // rs1
    logic [4:0] ir_24_20; // rs2
    logic [6:0] ir_31_25; // funct7
    logic [2:0] ir_14_12; // funct3
    logic [6:0] ir_6_0; // opcode

    // assigns
    assign ir_31_25 = ir_31_0[31:25];
    assign ir_31_20 = ir_31_0[31:20];
    assign ir_19_15 = ir_31_0[19:15];
    assign ir_24_20 = ir_31_0[24:20];
    assign ir_14_12 = ir_31_0[14:12];
    assign ir_6_0 = ir_31_0[6:0];
    assign wire_ALU_result_lo = wire_ALU_result;
    assign wire_immediate_to_padder = ir_31_20;

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
        .reg_b_write(en_wr_regB),
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
        .wr_data1(wire_muxRegfile_to_regfile),
        .wr_data2(),
        .rdwr_config(sel_rdwr_config),
        .link_reg(en_wr_link_reg),

        .outdata1(wire_regdata1_to_muxA),
        .outdata2(wire_regdata2_to_muxB),
        .reg_file_error_vector()
    );

    ALU_v1 alu1 (
        .a(wire_regA_to_ALU),
        .b(wire_regB_to_ALU),
        .out(wire_ALU_result),
        .out_hi(wire_ALU_result_hi),
        .op_code(),
        .zero_flag(),
        .sign_flag(),
        .alu_error_vector()
    );

    register_v1 alu_result (
        .clk(clk),
        .rst(rst),
        .wr_en(en_wr_alu_result),
        .data_in(wire_ALU_result),
        .data_out(wire_ALU_result_to_result_sel)
    );

    register_v1 alu_result_lo (
        .clk(clk),
        .rst(rst),
        .wr_en(en_wr_alu_result_lo),
        .data_in(wire_ALU_result_lo),
        .data_out(wire_ALU_result_lo_to_result_sel)
    );

    register_v1 alu_result_hi (
        .clk(clk),
        .rst(rst),
        .wr_en(en_wr_alu_result_hi),
        .data_in(wire_ALU_result_hi),
        .data_out(wire_ALU_result_hi_to_result_sel)
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
        .data_in(wire_muxB_to_regB),
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
//    memory_v1 memory (
//        .clk(clk),
//        .rst(rst),
//        .mem_addr(wire_muxMEMADDR_to_mem),
//        .data_in(wire_muxMEMDATA_to_mem),
//        .data_out(wire_memory_to_muxIR),
//        .switch_array(switch_array)
//    );
    
    memory_v2 memory (
        .clk(clk),
        .rst(rst),
        .mem_addr(),
        .data_in(),
        .data_out(wire_memory_to_muxIR),
        .write_enable(),
        .read_enable(),
        .pmod_in(),
        .pmod_out(),
        .button_array(),
        .switch_array(),
        .seg0(),
        .seg1(),
        .seg2(),
        .seg3(),
        .seg4(),
        .seg5(),
        .seg6(),
        .seg7()
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
        .in1(wire_regdata2_to_muxB), // regfile
        .in2(wire_unsignedpadder_to_muxB), // unsigned padded immediate
        .in3(wire_signedpadder_to_muxB), // signed   padded immediate
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

    mux2_v1 mux_ir (
        .in1(wire_memory_to_muxIR),
        .in2(diagnostique_instruction),
        // .in3(),
        // .in4(),
        .out1(wire_muxIR_to_regIR),
        // .sel(sel_ir_source)
        .sel(ir_config)
    );

    mux4_v1 mux_alu_result (
        .in1(wire_ALU_result_to_result_sel),
        .in2(wire_ALU_result_lo_to_result_sel),
        .in3(wire_ALU_result_hi_to_result_sel),
        .in4(),
        .out1(wire_ALU_result_selected),
        .sel(sel_alu_result)
    );

    mux4_v1 mux_regfileData (
        .in1(wire_ALU_result_selected),
        .in2(),
        .in3(),
        .in4(),
        .out1(wire_muxRegfile_to_regfile),
        .sel(sel_regfile_in)
    );

    // mux4_v1 mux_regFileAddr1 (
    //     .in1(wire_ALU_result_selected),
    //     .in2(),
    //     .in3(),
    //     .in4(),
    //     .out1(wire_muxRegfile_to_regfile),
    //     .sel(sel_regfile_in)
    // );

    zeroPadder_v1 padder (
        .immediate(wire_immediate_to_padder),
        .unsigned_zero_padded(wire_unsignedpadder_to_muxB),
        .signed_zero_padded(wire_signedpadder_to_muxB)
    );

endmodule

