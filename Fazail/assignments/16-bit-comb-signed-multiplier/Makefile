SRC_SV:= src/multiplier.sv  			\
	 test/tb_multiplier.sv

COMP_OPTS_SV := --incr --relax

TB_TOP := tb_multiplier

#==== Default target - running VIVADO simulation without drawing waveforms ====#
.PHONY: vivado viv_elaborate viv_compile

vivado : $(TB_TOP)_snapshot.wdb

viv_elaborate : .elab.timestamp

viv_compile : .comp_sv.timestamp .comp_v.timestamp .comp_vhdl.timestamp

#==== WAVEFORM DRAWING ====#
.PHONY: viv_waves
viv_waves : $(TB_TOP)_snapshot.wdb
	@echo
	@echo "### OPENING VIVADO WAVES ###"
	xsim --gui $(TB_TOP)_snapshot.wdb

#==== SIMULATION ====#
$(TB_TOP)_snapshot.wdb : .elab.timestamp 
	@echo
	@echo "### RUNNING SIMULATION ###"
	xsim $(TB_TOP)_snapshot --tclbatch xsim_cfg.tcl

#==== ELABORATION ====#
.elab.timestamp : .comp_sv.timestamp .comp_v.timestamp .comp_vhdl.timestamp
	@echo 
	@echo "### ELABORATION ###"
	xelab -debug all -top $(TB_TOP) -snapshot $(TB_TOP)_snapshot
	touch $@	

#==== COMPILING SYSTEMVERILOG ====#	
ifeq ($(SRC_SV),)
.comp_sv.timestamp :
	@echo 
	@echo "### NO SYSTEMVERILOG SOUCES GIVEN ###"
	@echo "### SKIPPED SYSTEMVERILOG COMPILATION ###"
	touch $@
else 
.comp_sv.timestamp : $(SRC_SV)
	@echo
	@echo "### COMPILING SYSTEMVERILOG ###"
	rm -rf xsim_cfg.tcl
	@echo "log_wave -recursive *" > xsim_cfg.tcl
	@echo "run all" >> xsim_cfg.tcl
	@echo "exit" >> xsim_cfg.tcl
	#verilog -VIVADO  
	xvlog -sv $(COMP_OPTS_SV) $(SRC_SV)
	touch $@
endif

#==== COMPILING VERILOG ====#	
ifeq ($(SRC_V),)
.comp_v.timestamp :
	@echo
	@echo "### NO VERILOG SOURCES GIVEN ###"
	@echo "### SKIPPED VERILOG COMPILATION ###"
	touch $@
else
.comp_v.timestamp : $(SRC_V)
	@echo 
	@echo "### COMPILING VERILOG ###"
	xvlog $(COMP_OPTS_V) $(SRC_V)
	touch $@
endif 

#==== COMPILING VHDL ====#	
ifeq ($(SRC_VHDL),)
.comp_vhdl.timestamp :
	@echo
	@echo "### NO VHDL SOURCES GIVEN ###"
	@echo "### SKIPPED VHDL COMPILATION ###"
	touch $@
else
.comp_vhdl.timestamp : $(SRC_VHDL)
	@echo 
	@echo "### COMPILING VHDL ###"
	xvhdl $(COMP_OPTS) $(SRC_VHDL)
	touch $@
endif

.PHONY : clean
clean :
	rm -rf *.jou *.log *.pb *.wdb xsim.dir *.str
	rm -rf .*.timestamp *.tcl *.vcd .*.verilate
	rm -rf obj_dir .Xil