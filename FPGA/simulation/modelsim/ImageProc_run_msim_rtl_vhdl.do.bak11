transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/mihai/Desktop/Personal Profesional/Projects/FPGA/obrada-slike-fpga/FPGA/CustomTypes.vhd}
vcom -93 -work work {C:/Users/mihai/Desktop/Personal Profesional/Projects/FPGA/obrada-slike-fpga/FPGA/Kernel.vhd}

vcom -93 -work work {C:/Users/mihai/Desktop/Personal Profesional/Projects/FPGA/obrada-slike-fpga/FPGA/simulation/modelsim/Kernel.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  KernelTestbench

add wave *
view structure
view signals
run -all
