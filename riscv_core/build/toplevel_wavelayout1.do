onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_toplevel_v1/dut/controller1/current_state
add wave -noupdate /testbench_toplevel_v1/dut/controller1/next_state
add wave -noupdate -expand -group ALU /testbench_toplevel_v1/dut/alu1/a
add wave -noupdate -expand -group ALU /testbench_toplevel_v1/dut/alu1/b
add wave -noupdate -expand -group ALU /testbench_toplevel_v1/dut/alu1/op_code
add wave -noupdate -expand -group ALU /testbench_toplevel_v1/dut/alu1/out
add wave -noupdate -expand -group ALU /testbench_toplevel_v1/dut/alu1/out_hi
add wave -noupdate -expand -group ALU /testbench_toplevel_v1/dut/alu1/zero_flag
add wave -noupdate -expand -group ALU /testbench_toplevel_v1/dut/alu1/sign_flag
add wave -noupdate -expand -group ALU /testbench_toplevel_v1/dut/alu1/alu_error_vector
add wave -noupdate -expand -group {Mux Reg B} /testbench_toplevel_v1/dut/mux_regB/in1
add wave -noupdate -expand -group {Mux Reg B} /testbench_toplevel_v1/dut/mux_regB/in2
add wave -noupdate -expand -group {Mux Reg B} /testbench_toplevel_v1/dut/mux_regB/in3
add wave -noupdate -expand -group {Mux Reg B} /testbench_toplevel_v1/dut/mux_regB/in4
add wave -noupdate -expand -group {Mux Reg B} /testbench_toplevel_v1/dut/mux_regB/in5
add wave -noupdate -expand -group {Mux Reg B} /testbench_toplevel_v1/dut/mux_regB/in6
add wave -noupdate -expand -group {Mux Reg B} /testbench_toplevel_v1/dut/mux_regB/in7
add wave -noupdate -expand -group {Mux Reg B} /testbench_toplevel_v1/dut/mux_regB/in8
add wave -noupdate -expand -group {Mux Reg B} /testbench_toplevel_v1/dut/mux_regB/out1
add wave -noupdate -expand -group {Mux Reg B} /testbench_toplevel_v1/dut/mux_regB/sel
add wave -noupdate -expand -group {Mux Reg A} /testbench_toplevel_v1/dut/mux_regA/in1
add wave -noupdate -expand -group {Mux Reg A} /testbench_toplevel_v1/dut/mux_regA/in2
add wave -noupdate -expand -group {Mux Reg A} /testbench_toplevel_v1/dut/mux_regA/in3
add wave -noupdate -expand -group {Mux Reg A} /testbench_toplevel_v1/dut/mux_regA/in4
add wave -noupdate -expand -group {Mux Reg A} /testbench_toplevel_v1/dut/mux_regA/out1
add wave -noupdate -expand -group {Mux Reg A} /testbench_toplevel_v1/dut/mux_regA/sel
add wave -noupdate -expand -group {Reg A} /testbench_toplevel_v1/dut/reg_a/wr_en
add wave -noupdate -expand -group {Reg A} /testbench_toplevel_v1/dut/reg_a/rst
add wave -noupdate -expand -group {Reg A} /testbench_toplevel_v1/dut/reg_a/clk
add wave -noupdate -expand -group {Reg A} /testbench_toplevel_v1/dut/reg_a/data_in
add wave -noupdate -expand -group {Reg A} /testbench_toplevel_v1/dut/reg_a/data_out
add wave -noupdate -expand -group {Reg A} /testbench_toplevel_v1/dut/reg_a/reg_storage
add wave -noupdate -expand -group {Reg B} /testbench_toplevel_v1/dut/reg_b/wr_en
add wave -noupdate -expand -group {Reg B} /testbench_toplevel_v1/dut/reg_b/rst
add wave -noupdate -expand -group {Reg B} /testbench_toplevel_v1/dut/reg_b/clk
add wave -noupdate -expand -group {Reg B} /testbench_toplevel_v1/dut/reg_b/data_in
add wave -noupdate -expand -group {Reg B} /testbench_toplevel_v1/dut/reg_b/data_out
add wave -noupdate -expand -group {Reg B} /testbench_toplevel_v1/dut/reg_b/reg_storage
add wave -noupdate -expand -group {Reg File} /testbench_toplevel_v1/dut/register_file1/reg_addr1
add wave -noupdate -expand -group {Reg File} /testbench_toplevel_v1/dut/register_file1/reg_addr2
add wave -noupdate -expand -group {Reg File} /testbench_toplevel_v1/dut/register_file1/wr_data2
add wave -noupdate -expand -group {Reg File} /testbench_toplevel_v1/dut/register_file1/rdwr_config
add wave -noupdate -expand -group {Reg File} /testbench_toplevel_v1/dut/register_file1/link_reg
add wave -noupdate -expand -group {Reg File} /testbench_toplevel_v1/dut/register_file1/clk
add wave -noupdate -expand -group {Reg File} /testbench_toplevel_v1/dut/register_file1/rst
add wave -noupdate -expand -group {Reg File} /testbench_toplevel_v1/dut/register_file1/outdata1
add wave -noupdate -expand -group {Reg File} /testbench_toplevel_v1/dut/register_file1/outdata2
add wave -noupdate -expand -group {Reg File} /testbench_toplevel_v1/dut/register_file1/reg_file_error_vector
add wave -noupdate -group {IR Reg} -group {Reg File} /testbench_toplevel_v1/dut/register_file1/wr_data1
add wave -noupdate -group {IR Reg} /testbench_toplevel_v1/dut/reg_ir/wr_en
add wave -noupdate -group {IR Reg} /testbench_toplevel_v1/dut/reg_ir/rst
add wave -noupdate -group {IR Reg} /testbench_toplevel_v1/dut/reg_ir/clk
add wave -noupdate -group {IR Reg} /testbench_toplevel_v1/dut/reg_ir/data_in
add wave -noupdate -group {IR Reg} /testbench_toplevel_v1/dut/reg_ir/data_out
add wave -noupdate -group {IR Reg} /testbench_toplevel_v1/dut/reg_ir/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/controller1/ir_write
add wave -noupdate /testbench_toplevel_v1/t_clk
add wave -noupdate /testbench_toplevel_v1/t_rst
add wave -noupdate /testbench_toplevel_v1/clk_en
add wave -noupdate /testbench_toplevel_v1/seg0
add wave -noupdate /testbench_toplevel_v1/t_instruction
add wave -noupdate /testbench_toplevel_v1/t_irconfig
add wave -noupdate /testbench_toplevel_v1/i
add wave -noupdate /testbench_toplevel_v1/len
add wave -noupdate /testbench_toplevel_v1/pass
add wave -noupdate /testbench_toplevel_v1/i
add wave -noupdate /testbench_toplevel_v1/len
add wave -noupdate /testbench_toplevel_v1/pass
add wave -noupdate /testbench_toplevel_v1/dut/rst
add wave -noupdate /testbench_toplevel_v1/dut/clk
add wave -noupdate /testbench_toplevel_v1/dut/switch_array
add wave -noupdate /testbench_toplevel_v1/dut/button0
add wave -noupdate /testbench_toplevel_v1/dut/button1
add wave -noupdate /testbench_toplevel_v1/dut/button2
add wave -noupdate /testbench_toplevel_v1/dut/button3
add wave -noupdate /testbench_toplevel_v1/dut/seg0
add wave -noupdate /testbench_toplevel_v1/dut/seg1
add wave -noupdate /testbench_toplevel_v1/dut/seg2
add wave -noupdate /testbench_toplevel_v1/dut/seg3
add wave -noupdate /testbench_toplevel_v1/dut/seg4
add wave -noupdate /testbench_toplevel_v1/dut/seg5
add wave -noupdate /testbench_toplevel_v1/dut/seg6
add wave -noupdate /testbench_toplevel_v1/dut/seg7
add wave -noupdate /testbench_toplevel_v1/dut/ir_config
add wave -noupdate /testbench_toplevel_v1/dut/diagnostique_instruction
add wave -noupdate /testbench_toplevel_v1/dut/toplevel_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/sel_alu_src_a
add wave -noupdate /testbench_toplevel_v1/dut/sel_alu_src_b
add wave -noupdate /testbench_toplevel_v1/dut/sel_pc_source
add wave -noupdate /testbench_toplevel_v1/dut/sel_ir_source
add wave -noupdate /testbench_toplevel_v1/dut/sel_memdata
add wave -noupdate /testbench_toplevel_v1/dut/sel_memaddr
add wave -noupdate /testbench_toplevel_v1/dut/sel_alu_result
add wave -noupdate /testbench_toplevel_v1/dut/sel_regfile_in
add wave -noupdate /testbench_toplevel_v1/dut/sel_rdwr_config
add wave -noupdate /testbench_toplevel_v1/dut/en_wr_regA
add wave -noupdate /testbench_toplevel_v1/dut/en_wr_regB
add wave -noupdate /testbench_toplevel_v1/dut/en_wr_PC
add wave -noupdate /testbench_toplevel_v1/dut/en_wr_IR
add wave -noupdate /testbench_toplevel_v1/dut/en_wr_MEM
add wave -noupdate /testbench_toplevel_v1/dut/en_wr_alu_result
add wave -noupdate /testbench_toplevel_v1/dut/en_wr_alu_result_lo
add wave -noupdate /testbench_toplevel_v1/dut/en_wr_alu_result_hi
add wave -noupdate /testbench_toplevel_v1/dut/en_wr_link_reg
add wave -noupdate /testbench_toplevel_v1/dut/wire_regdata1_to_muxA
add wave -noupdate /testbench_toplevel_v1/dut/wire_regdata2_to_muxB
add wave -noupdate /testbench_toplevel_v1/dut/wire_muxA_to_regA
add wave -noupdate /testbench_toplevel_v1/dut/wire_muxB_to_regB
add wave -noupdate /testbench_toplevel_v1/dut/wire_muxMEMDATA_to_mem
add wave -noupdate /testbench_toplevel_v1/dut/wire_muxMEMADDR_to_mem
add wave -noupdate /testbench_toplevel_v1/dut/wire_regA_to_ALU
add wave -noupdate /testbench_toplevel_v1/dut/wire_regB_to_ALU
add wave -noupdate /testbench_toplevel_v1/dut/wire_muxIR_to_regIR
add wave -noupdate /testbench_toplevel_v1/dut/wire_muxPC_to_regPC
add wave -noupdate /testbench_toplevel_v1/dut/wire_regPC_to_muxMEM_DATA
add wave -noupdate /testbench_toplevel_v1/dut/wire_regPC_to_muxMEM_ADDR
add wave -noupdate /testbench_toplevel_v1/dut/wire_muxRegfile_to_regfile
add wave -noupdate /testbench_toplevel_v1/dut/wire_ALU_result
add wave -noupdate /testbench_toplevel_v1/dut/wire_ALU_result_lo
add wave -noupdate /testbench_toplevel_v1/dut/wire_ALU_result_hi
add wave -noupdate /testbench_toplevel_v1/dut/wire_ALU_result_to_result_sel
add wave -noupdate /testbench_toplevel_v1/dut/wire_ALU_result_lo_to_result_sel
add wave -noupdate /testbench_toplevel_v1/dut/wire_ALU_result_hi_to_result_sel
add wave -noupdate /testbench_toplevel_v1/dut/wire_ALU_result_selected
add wave -noupdate /testbench_toplevel_v1/dut/wire_memory_to_muxIR
add wave -noupdate /testbench_toplevel_v1/dut/ir_31_0
add wave -noupdate /testbench_toplevel_v1/dut/ir_31_20
add wave -noupdate /testbench_toplevel_v1/dut/ir_19_15
add wave -noupdate /testbench_toplevel_v1/dut/ir_24_20
add wave -noupdate /testbench_toplevel_v1/dut/ir_31_25
add wave -noupdate /testbench_toplevel_v1/dut/ir_14_12
add wave -noupdate /testbench_toplevel_v1/dut/ir_6_0
add wave -noupdate /testbench_toplevel_v1/dut/controller1/clk
add wave -noupdate /testbench_toplevel_v1/dut/controller1/rst
add wave -noupdate /testbench_toplevel_v1/dut/controller1/funct7
add wave -noupdate /testbench_toplevel_v1/dut/controller1/funct3
add wave -noupdate /testbench_toplevel_v1/dut/controller1/opcode
add wave -noupdate /testbench_toplevel_v1/dut/controller1/ir_31_0
add wave -noupdate /testbench_toplevel_v1/dut/controller1/alu_src_a
add wave -noupdate /testbench_toplevel_v1/dut/controller1/alu_src_b
add wave -noupdate /testbench_toplevel_v1/dut/controller1/ir_source
add wave -noupdate /testbench_toplevel_v1/dut/controller1/pc_source
add wave -noupdate /testbench_toplevel_v1/dut/controller1/ir_write
add wave -noupdate /testbench_toplevel_v1/dut/controller1/reg_a_write
add wave -noupdate /testbench_toplevel_v1/dut/controller1/reg_b_write
add wave -noupdate /testbench_toplevel_v1/dut/controller1/pc_write
add wave -noupdate /testbench_toplevel_v1/dut/controller1/mem_write
add wave -noupdate /testbench_toplevel_v1/dut/controller1/regfile_write
add wave -noupdate /testbench_toplevel_v1/dut/controller1/alu_result_reg_write
add wave -noupdate /testbench_toplevel_v1/dut/controller1/alu_lo_result_reg_write
add wave -noupdate /testbench_toplevel_v1/dut/controller1/alu_hi_result_reg_write
add wave -noupdate /testbench_toplevel_v1/dut/controller1/next_state_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/controller1/moore_map_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/register_file1/i
add wave -noupdate /testbench_toplevel_v1/dut/alu1/result
add wave -noupdate /testbench_toplevel_v1/dut/alu_result/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/alu_result/rst
add wave -noupdate /testbench_toplevel_v1/dut/alu_result/clk
add wave -noupdate /testbench_toplevel_v1/dut/alu_result/data_in
add wave -noupdate /testbench_toplevel_v1/dut/alu_result/data_out
add wave -noupdate /testbench_toplevel_v1/dut/alu_result/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/alu_result/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_lo/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_lo/rst
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_lo/clk
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_lo/data_in
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_lo/data_out
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_lo/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_lo/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_hi/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_hi/rst
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_hi/clk
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_hi/data_in
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_hi/data_out
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_hi/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/alu_result_hi/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/reg_pc/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/reg_pc/rst
add wave -noupdate /testbench_toplevel_v1/dut/reg_pc/clk
add wave -noupdate /testbench_toplevel_v1/dut/reg_pc/data_in
add wave -noupdate /testbench_toplevel_v1/dut/reg_pc/data_out
add wave -noupdate /testbench_toplevel_v1/dut/reg_pc/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/reg_pc/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/memory/clk
add wave -noupdate /testbench_toplevel_v1/dut/memory/rst
add wave -noupdate /testbench_toplevel_v1/dut/memory/mem_addr
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/write_enable
add wave -noupdate /testbench_toplevel_v1/dut/memory/read_enable
add wave -noupdate /testbench_toplevel_v1/dut/memory/pmod_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/pmod_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/button_array
add wave -noupdate /testbench_toplevel_v1/dut/memory/switch_array
add wave -noupdate /testbench_toplevel_v1/dut/memory/seg0
add wave -noupdate /testbench_toplevel_v1/dut/memory/seg1
add wave -noupdate /testbench_toplevel_v1/dut/memory/seg2
add wave -noupdate /testbench_toplevel_v1/dut/memory/seg3
add wave -noupdate /testbench_toplevel_v1/dut/memory/seg4
add wave -noupdate /testbench_toplevel_v1/dut/memory/seg5
add wave -noupdate /testbench_toplevel_v1/dut/memory/seg6
add wave -noupdate /testbench_toplevel_v1/dut/memory/seg7
add wave -noupdate /testbench_toplevel_v1/dut/memory/memory_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/memory/en_ram_wren
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_ram_data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_ram_data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_ram_addr
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_sel_mux_data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_sel_mux_data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_demux_to_seg0
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_demux_to_seg1
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_demux_to_seg2
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_demux_to_seg3
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_demux_to_seg4
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_demux_to_seg5
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_demux_to_seg6
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_demux_to_seg7
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_buttonarray_padded
add wave -noupdate /testbench_toplevel_v1/dut/memory/wire_switcharray_padded
add wave -noupdate /testbench_toplevel_v1/dut/memory/ram1/clk
add wave -noupdate /testbench_toplevel_v1/dut/memory/ram1/rst
add wave -noupdate /testbench_toplevel_v1/dut/memory/ram1/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/memory/ram1/in_data
add wave -noupdate /testbench_toplevel_v1/dut/memory/ram1/out_data
add wave -noupdate /testbench_toplevel_v1/dut/memory/ram1/actual_ram_addr
add wave -noupdate /testbench_toplevel_v1/dut/memory/ram1/ram_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_in_demux/in1
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_in_demux/sel
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_in_demux/out1
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_in_demux/out2
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_in_demux/out3
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_in_demux/out4
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_out_mux/in1
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_out_mux/in2
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_out_mux/in3
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_out_mux/in4
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_out_mux/out1
add wave -noupdate /testbench_toplevel_v1/dut/memory/data_out_mux/sel
add wave -noupdate /testbench_toplevel_v1/dut/memory/controller/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/memory/controller/rd_en
add wave -noupdate /testbench_toplevel_v1/dut/memory/controller/addr
add wave -noupdate /testbench_toplevel_v1/dut/memory/controller/clk
add wave -noupdate /testbench_toplevel_v1/dut/memory/controller/rst
add wave -noupdate /testbench_toplevel_v1/dut/memory/controller/sel_mux_data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/controller/sel_mux_data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg0/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg0/rst
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg0/clk
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg0/data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg0/data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg0/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg0/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg1/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg1/rst
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg1/clk
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg1/data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg1/data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg1/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg1/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg2/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg2/rst
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg2/clk
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg2/data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg2/data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg2/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg2/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg3/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg3/rst
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg3/clk
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg3/data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg3/data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg3/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg3/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg4/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg4/rst
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg4/clk
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg4/data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg4/data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg4/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg4/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg5/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg5/rst
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg5/clk
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg5/data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg5/data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg5/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg5/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg6/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg6/rst
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg6/clk
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg6/data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg6/data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg6/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg6/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg7/wr_en
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg7/rst
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg7/clk
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg7/data_in
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg7/data_out
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg7/register_error_vector
add wave -noupdate /testbench_toplevel_v1/dut/memory/reg_seg7/reg_storage
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMDATA/in1
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMDATA/in2
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMDATA/in3
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMDATA/in4
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMDATA/out1
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMDATA/sel
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMADDR/in1
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMADDR/in2
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMADDR/in3
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMADDR/in4
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMADDR/out1
add wave -noupdate /testbench_toplevel_v1/dut/mux_MEMADDR/sel
add wave -noupdate /testbench_toplevel_v1/dut/mux_pc/in1
add wave -noupdate /testbench_toplevel_v1/dut/mux_pc/in2
add wave -noupdate /testbench_toplevel_v1/dut/mux_pc/in3
add wave -noupdate /testbench_toplevel_v1/dut/mux_pc/in4
add wave -noupdate /testbench_toplevel_v1/dut/mux_pc/out1
add wave -noupdate /testbench_toplevel_v1/dut/mux_pc/sel
add wave -noupdate /testbench_toplevel_v1/dut/mux_ir/in1
add wave -noupdate /testbench_toplevel_v1/dut/mux_ir/in2
add wave -noupdate /testbench_toplevel_v1/dut/mux_ir/out1
add wave -noupdate /testbench_toplevel_v1/dut/mux_ir/sel
add wave -noupdate /testbench_toplevel_v1/dut/mux_alu_result/in1
add wave -noupdate /testbench_toplevel_v1/dut/mux_alu_result/in2
add wave -noupdate /testbench_toplevel_v1/dut/mux_alu_result/in3
add wave -noupdate /testbench_toplevel_v1/dut/mux_alu_result/in4
add wave -noupdate /testbench_toplevel_v1/dut/mux_alu_result/out1
add wave -noupdate /testbench_toplevel_v1/dut/mux_alu_result/sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10177 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 228
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {63 ns}
