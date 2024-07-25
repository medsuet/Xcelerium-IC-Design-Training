SOURCES_SV := src/counter.sv \
              test/counter_tb.sv

COMP_OPT_SV := \
    --incr \
    --relax

TB_TOP := counter_tb

.PHONY: simulate elaborate compile

simulate: $(TB_TOP)_snapshot.wdb

elaborate: .elab.timestamp

compile: .comp_sv.timestamp

### ===== WAVEFORMS DRAWINGS ===== ###

.PHONY: waves
viv_waves: $(TB_TOP)_snapshot.wdb
	@echo "### OPENING WAVES ###"
	xsim --gui $(TB_TOP)_snapshot.wdb

### ==== Simulation ========== ###

$(TB_TOP)_snapshot.wdb: .elab.timestamp
	@echo
	@echo "### RUNNING SIMULATIONS ###"
	xsim $(TB_TOP)_snapshot --tclbatch xsim_cfg.tcl

### ======= ELABORATION ======= ######
.elab.timestamp: .comp_sv.timestamp
	@echo
	@echo "### RUNNING ELABORATION ###"
	xelab -debug all -top $(TB_TOP) -snapshot $(TB_TOP)_snapshot
	touch .elab.timestamp

#### ======= COMPILATION ======= ####
.comp_sv.timestamp: $(SOURCES_SV)
	@echo 
	@echo "### COMPILING SYSTEM VERILOG ###"
	rm -rf xsim_cfg.tcl
	xvlog --sv $(SOURCES_SV) $(COMP_OPT_SV)
	@echo "log_wave -recursive *" > xsim_cfg.tcl
	@echo "run 200us" >> xsim_cfg.tcl
	@echo "exit" >> xsim_cfg.tcl
	touch .comp_sv.timestamp

.PHONY: clean
clean: 
	rm -rf *.jou *.log *.pb *.wdb xsim.dir *.str *.tcl
	rm -rf .*.timestamp
	rm -rf .stamp.*
	rm -rf ./obj_dir
	rm -rf waveform.vcd
