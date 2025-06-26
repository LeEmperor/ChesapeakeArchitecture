# // main compile script
vlog -sv -incr \
    ../src/muxes_v1.sv \
    ../src/ALU_v1.sv \
    ../src/controller_v1.sv \
    ../src/registerFile_v1.sv \
    ../src/register_v1.sv \
    ../src/ram_v1.sv \
    ../src/memory_v1.sv \
    ../src/toplevel_v1.sv \
    \
    ../testbenches/ALU_v1_tb.sv \
    ../testbenches/mux2_v1_tb.sv \
    ../testbenches/ram_v1_tb.sv \
    ../testbenches/registerFile_v1_tb.sv ;
    # // ../testbenches/memory_v1_tb.sv

# // main sim script
# // vsim -t 1ps -L work -voptargs="+acc" testbench_ALU_v1\ ;
vsim -t 1ps -L work -voptargs="+acc" testbench_ram_v1 ;
add wave * ;
run -all ;
wave zoom full ;
view wave ;

# // main view script
# // vsim -view vsim.wlf -do "add wave *; wave zoom full; view objects" ;
# // vsim -view vsim.wlf
# // add wave *;
# // wave zoom full
# // view objects

