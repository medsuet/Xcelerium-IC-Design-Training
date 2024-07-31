
# SystemVerilog source files
SOURCES = src/PosedgeDetector_moore.sv src/PosedgeDetector_mealy.sv
TB = PosedgeDetector_tb.sv	# SV testbench present in sim/ folder

COMPILER = vlog
SIMULATOR = vsim

# Flags for vsim in simulate target
VSIM_FLAGS = -c -quiet -voptargs=+acc=npr
VSIM_WAVE_FLAGS = -do "vcd file waveform.vcd" -do "vcd add -r /$(TB)/*"
VSIM_RUN_FLAGS = -do "run $(SIMTIME)" -do "exit"
VSIM_PARAMS = -g SIGNAL=$(_LENSIGNAL)\'b$(SIGNAL)

SIMTIME = 100 ps			# Simulation running time
SIGNAL = 00111010 			# Input signal to posedge detectors

# Calculate length of input signal
_LENSIGNAL := $(shell printf '%s' '$(subst ','"'"',$(SIGNAL))' | wc -c)

.PHONY: compile
compile : work/_lib.qdb
.PHONY: simulate
simulate : waveform.vcd


work/_lib.qdb : sim/$(TB) $(SOURCES)
	$(COMPILER) -nologo $?

waveform.vcd : compile
	@$(SIMULATOR) $(VSIM_FLAGS) $(basename $(TB)) $(VSIM_WAVE_FLAGS) $(VSIM_RUN_FLAGS) $(VSIM_PARAMS)

clean:
	@rm -f -r work transcript waveform.vcd