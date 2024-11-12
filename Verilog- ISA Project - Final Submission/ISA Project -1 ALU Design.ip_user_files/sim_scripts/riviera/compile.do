transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/blk_mem_gen_v8_4_8
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap blk_mem_gen_v8_4_8 riviera/blk_mem_gen_v8_4_8
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr -l xpm -l blk_mem_gen_v8_4_8 -l xil_defaultlib \
"/home/tuhin/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"/home/tuhin/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_4_8  -incr -v2k5 -l xpm -l blk_mem_gen_v8_4_8 -l xil_defaultlib \
"../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 -l xpm -l blk_mem_gen_v8_4_8 -l xil_defaultlib \
"../../../ISA Project -1 ALU Design.gen/sources_1/ip/blk_mem_gen_1/sim/blk_mem_gen_1.v" \
"../../../ISA Project -1 ALU Design.gen/sources_1/ip/blk_mem_gen_0/sim/blk_mem_gen_0.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/ALU32.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/Data_Memory.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/Instruction_Memory.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/Lib_Arithmetic.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/Lib_Comp.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/Lib_Logical.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/Lib_Mux.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/Lib_Shift.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/REG_BANK.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/branch_control.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/control_unit.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/datapath.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/lib_datapath.v" \
"../../../ISA Project -1 ALU Design.srcs/sources_1/new/processor_top.v" \
"../../../ISA Project -1 ALU Design.srcs/sim_1/new/test_processor_tb.v" \

vlog -work xil_defaultlib \
"glbl.v"

