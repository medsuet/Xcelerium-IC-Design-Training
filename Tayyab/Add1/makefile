
COMPILER = vlog
SIMULATOR = vsim

SIMTIME = 1 ns			# Simulation running time

compile : work/_lib.qdb

work/_lib.qdb : sim/Add1_tb.sv src/Add1.sv
	$(COMPILER) -nologo $?

simulate : compile
	@$(SIMULATOR) -c Add1_tb -quiet -do "run $(SIMTIME)" -do "exit"

clean:
	@rm -f -r work transcript