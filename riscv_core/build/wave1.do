onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_memory_v2/t_seg0
add wave -noupdate /testbench_memory_v2/t_seg1
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/en_ram_wren
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_ram_data_in
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_ram_data_out
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_ram_addr
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_sel_mux_data_in
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_sel_mux_data_out
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_demux_to_seg0
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_demux_to_seg1
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_demux_to_seg2
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_demux_to_seg3
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_demux_to_seg4
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_demux_to_seg5
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_demux_to_seg6
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_demux_to_seg7
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_buttonarray_padded
add wave -noupdate -expand -group internals /testbench_memory_v2/dut/wire_switcharray_padded
add wave -noupdate /testbench_memory_v2/t_clk
add wave -noupdate /testbench_memory_v2/t_dataout
add wave -noupdate /testbench_memory_v2/t_buttons
add wave -noupdate /testbench_memory_v2/t_write_enable
add wave -noupdate /testbench_memory_v2/t_read_enable
add wave -noupdate /testbench_memory_v2/t_datain
add wave -noupdate /testbench_memory_v2/t_mem_addr
add wave -noupdate /testbench_memory_v2/t_rst
add wave -noupdate /testbench_memory_v2/clk_en
add wave -noupdate /testbench_memory_v2/i
add wave -noupdate /testbench_memory_v2/len
add wave -noupdate /testbench_memory_v2/pass
add wave -noupdate /testbench_memory_v2/dut/clk
add wave -noupdate /testbench_memory_v2/dut/rst
add wave -noupdate /testbench_memory_v2/dut/mem_addr
add wave -noupdate /testbench_memory_v2/dut/data_in
add wave -noupdate /testbench_memory_v2/dut/data_out
add wave -noupdate /testbench_memory_v2/dut/write_enable
add wave -noupdate /testbench_memory_v2/dut/read_enable
add wave -noupdate /testbench_memory_v2/dut/pmod_in
add wave -noupdate /testbench_memory_v2/dut/pmod_out
add wave -noupdate /testbench_memory_v2/dut/button_array
add wave -noupdate /testbench_memory_v2/dut/switch_array
add wave -noupdate /testbench_memory_v2/dut/seg0
add wave -noupdate /testbench_memory_v2/dut/seg1
add wave -noupdate /testbench_memory_v2/dut/seg2
add wave -noupdate /testbench_memory_v2/dut/seg3
add wave -noupdate /testbench_memory_v2/dut/seg4
add wave -noupdate /testbench_memory_v2/dut/seg5
add wave -noupdate /testbench_memory_v2/dut/seg6
add wave -noupdate /testbench_memory_v2/dut/seg7
add wave -noupdate /testbench_memory_v2/dut/memory_error_vector
add wave -noupdate /testbench_memory_v2/dut/ram1/clk
add wave -noupdate /testbench_memory_v2/dut/ram1/rst
add wave -noupdate /testbench_memory_v2/dut/ram1/wr_en
add wave -noupdate /testbench_memory_v2/dut/ram1/in_data
add wave -noupdate /testbench_memory_v2/dut/ram1/out_data
add wave -noupdate /testbench_memory_v2/dut/ram1/actual_ram_addr
add wave -noupdate /testbench_memory_v2/dut/ram1/ram_error_vector
add wave -noupdate /testbench_memory_v2/dut/data_in_demux/in1
add wave -noupdate /testbench_memory_v2/dut/data_in_demux/sel
add wave -noupdate /testbench_memory_v2/dut/data_in_demux/out1
add wave -noupdate /testbench_memory_v2/dut/data_in_demux/out2
add wave -noupdate /testbench_memory_v2/dut/data_in_demux/out3
add wave -noupdate /testbench_memory_v2/dut/data_in_demux/out4
add wave -noupdate /testbench_memory_v2/dut/data_out_mux/in1
add wave -noupdate /testbench_memory_v2/dut/data_out_mux/in2
add wave -noupdate /testbench_memory_v2/dut/data_out_mux/in3
add wave -noupdate /testbench_memory_v2/dut/data_out_mux/in4
add wave -noupdate /testbench_memory_v2/dut/data_out_mux/out1
add wave -noupdate /testbench_memory_v2/dut/data_out_mux/sel
add wave -noupdate /testbench_memory_v2/dut/controller/wr_en
add wave -noupdate /testbench_memory_v2/dut/controller/rd_en
add wave -noupdate /testbench_memory_v2/dut/controller/addr
add wave -noupdate /testbench_memory_v2/dut/controller/clk
add wave -noupdate /testbench_memory_v2/dut/controller/rst
add wave -noupdate /testbench_memory_v2/dut/controller/sel_mux_data_in
add wave -noupdate /testbench_memory_v2/dut/controller/sel_mux_data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {26205 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 247
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
WaveRestoreZoom {0 ps} {114393 ps}
