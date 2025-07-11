# // alias design_comp="vsim -c -do \"vlog -reportprogress 300 -sv -work work \"+incdir+$windows_SRC_DIRECTORY\" C:/FPGA_stuff/test_project_1/src/code_ALU_v1.sv; quit\""

# // vlog -sv -work work "+incdir+C:/FPGA_stuff/ChesapeakeArchitecture/riscv_core/src" C:/FPGA_stuff/ChesapeakeArchitecture/riscv_core/src/ALU_v1.sv ;

# // vlog -sv -incr "+incdir+C:/FPGA_stuff/ChesapeakeArchitecture/riscv_core/src" C:/FPGA_stuff/ChesapeakeArchitecture/riscv_core/src/ALU_v1.sv ;

# // vlog -sv "+incdir+C:/FPGA_stuff/ChesapeakeArchitecture/riscv_core/src" C:/FPGA_stuff/ChesapeakeArchitecture/riscv_core/src/ALU_v1.sv ;

# // vlog -sv C:/FPGA_stuff/ChesapeakeArchitecture/riscv_core/src/ALU_v1.sv ;

vlog -sv -incr \
    ../src/muxes_v1.sv \
    ../src/ALU_v1.sv \
    ../src/controller_v1.sv \
    ../src/registerFile_v1.sv \
    ../src/register_v1.sv \
    ../src/ram_v1.sv \
    ../src/memory_v2.sv \
    ../src/memory_ctrl_v1.sv \
    ../src/toplevel_v1.sv \
    \
    ../testbenches/ram_v1_tb.sv \
    ../testbenches/ALU_v1_tb.sv \
    ../testbenches/mux2_v1_tb.sv \
    ../testbenches/registerFile_v1_tb.sv \
    ../testbenches/memory_v2_tb.sv \
    ../testbenches/memory_ctrl_v1_tb.sv \
    ../testbenches/param_mux_v1_tb.sv 
    # // ../testbenches/memory_v1_tb.sv \
    # // ../testbenches/register_v1_tb.sv

quit ; 

