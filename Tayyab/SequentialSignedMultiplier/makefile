
SOURCES = src/SequentialSignedMultiplier.sv src/controller.sv src/datapath.sv
TB = SequentialSignedMultiplier_tb.sv	# SV testbench present in sim/ folder

COMPILER = vlog
SIMULATOR = vsim

SIMTIME = 1 ms			# Simulation running time
NUMTESTS = 1e4			# Number of random tests to run

.PHONY: compile
compile : work/_lib.qdb
.PHONY: simulate
simulate : transcript


work/_lib.qdb : sim/$(TB) $(SOURCES)
	$(COMPILER) -nologo $?

transcript : compile
	@$(SIMULATOR) -c $(basename $(TB)) -quiet -do "run $(SIMTIME)" -do "exit" -g NUMTESTS=$(NUMTESTS)

clean:
	@rm -f -r work transcript