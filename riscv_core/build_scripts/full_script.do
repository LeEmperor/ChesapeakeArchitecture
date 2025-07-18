# // main compile script
vlog -sv -incr \
    ../src/muxes_v1.sv \
    ../src/ALU_v1.sv \
    ../src/controller_v1.sv \
    ../src/registerFile_v1.sv \
    ../src/register_v1.sv \
    ../src/ram_v1.sv \
    ../src/memory_v3.sv \
    ../src/zeroPadder_v1.sv \
    ../src/toplevel_v1.sv \
    ../src/register_v2.sv \
    ../src/ALU_controller_v1.sv \
    \
    ../testbenches/ALU_v1_tb.sv \
    ../testbenches/mux2_v1_tb.sv \
    ../testbenches/ram_v1_tb.sv \
    ../testbenches/param_mux_v1_tb.sv \
    ../testbenches/memory_ctrl_v1_tb.sv \
    ../testbenches/memory_v3_tb.sv \
    ../testbenches/registerFile_v1_tb.sv \
    ../testbenches/zeroPadder_v1_tb.sv \
    ../testbenches/register_v2_tb.sv \
    ../testbenches/toplevel_v1_tb.sv ;
    # // ../testbenches/memory_v1_tb.sv

# // main sim script
# // vsim -t 1ps -L work -voptargs="+acc" testbench_ALU_v1\ ;
# // vsim -t 1ps -L work -voptargs="+acc" testbench_toplevel_v1 ;
vsim -t 1ps -L work -voptargs="+acc" testbench_register_v2;
# // vsim -t 1ps -L work -voptargs="+acc" testbench_registerFile_v1;
# // vsim -t 1ps -L work -voptargs="+acc" testbench_memory_v2;
add wave * ;
# // add wave -r *
# // do toplevel_wavelayout1.do
# // do wave.do
run -all ;
wave zoom full ;
view wave ;

# // main view script
# // vsim -view vsim.wlf -do "add wave *; wave zoom full; view objects" ;
# // vsim -view vsim.wlf
# // add wave *;
# // wave zoom full
# // view objects

