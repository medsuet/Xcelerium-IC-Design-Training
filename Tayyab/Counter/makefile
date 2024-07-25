
COMPILER = vlog
SIMULATOR = vsim

SIMTIME = 0.5 ns		# Simulation running time
RESETTIME = 0			# Time after which reset signal is given to the counter

compile : work/_lib.qdb

work/_lib.qdb : sim/Counter_tb.sv src/Counter.sv
	$(COMPILER) -nologo $?

simulate : compile
	@$(SIMULATOR) -c Counter_tb -quiet -do "run $(SIMTIME)" -do "exit" -g RESETTIME=$(RESETTIME)