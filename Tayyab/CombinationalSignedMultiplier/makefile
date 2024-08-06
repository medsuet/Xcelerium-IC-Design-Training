
COMPILER = vlog
SIMULATOR = vsim

N = 1e3				# Number of times to run simulation with random tests
SIMTIME = 10 ns		# Simulation running time

compile : work/_lib.qdb

work/_lib.qdb : sim/SignedMultiplier_tb.sv src/SignedMultiplier.sv src/FullAdder.sv
	@$(COMPILER) -nologo $?

simulate:compile
ifdef Num1
	@$(SIMULATOR) -c SignedMultiplier_tb -quiet -do "run $(SIMTIME)" -do "exit" -g RandomTestFlag=0 -g Num1=$(Num1) -g Num2=$(Num2)
else
	@$(SIMULATOR) -c SignedMultiplier_tb -quiet -do "run $(SIMTIME)" -do "exit" -g NumRandTests=$(N) -g RandomTestFlag=1
endif

clean:
	@rm -r work transcript
