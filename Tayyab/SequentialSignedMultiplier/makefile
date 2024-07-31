
SOURCES = src/SequentialSignedMultiplier.sv src/controller.sv src/datapath.sv
TB = SequentialSignedMultiplier_tb.sv	# SV testbench present in sim/ folder

COMPILER = vlog
SIMULATOR = vsim

# Flags for vsim in simulate target
VSIM_FLAGS = -c -quiet 
VSIM_WAVE_FLAGS = -voptargs=+acc=npr -do "vcd file waveform.vcd" -do "vcd add -r /$(TB)/*"
VSIM_RUN_FLAGS = -do "run $(SIMTIME)" -do "exit"

SIMTIME = 1 ms			# Simulation running time
NUMTESTS = 1e4			# Number of random tests to run

.PHONY: compile
compile : work/_lib.qdb
.PHONY: simulate
simulate : transcript


work/_lib.qdb : sim/$(TB) $(SOURCES)
	$(COMPILER) -nologo $?

transcript : compile
	@$(SIMULATOR) $(VSIM_FLAGS) $(basename $(TB)) $(VSIM_RUN_FLAGS) -g NUMTESTS=$(NUMTESTS)

waveform.vcd : compile
	@$(SIMULATOR) $(VSIM_FLAGS) $(basename $(TB)) $(VSIM_WAVE_FLAGS) $(VSIM_RUN_FLAGS) $(VSIM_PARAMS) -g NUMTESTS=0

clean:
	@rm -f -r work transcript