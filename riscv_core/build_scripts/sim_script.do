# // alias s="vsim -c -do \"vsim -t 1ps -L work -voptargs=\"+acc\" testbench_alu_v1\" -do \"add wave *; run -all; quit\""

# // runs the sim
vsim -t 1ps -L work -voptargs="+acc" testbench_ALU_v1\ ;
add wave * ;
run -all
quit ;

