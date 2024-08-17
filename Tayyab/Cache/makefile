
PARAMS = param/*.sv
SOURCES = src/*/*.sv
TB_CPP = sim/cache_tb.cpp
TB_SV = sim/cache_tb.sv

SIMTIME = 500

# Flags for vsim
VSIM_FLAGS = -c -quiet -voptargs=+acc=npr 
VSIM_WAVE_FLAGS = -do "vcd file waveform.vcd" -do "vcd add -r /*"
VSIM_RUN_FLAGS = -do "run $(SIMTIME) ps" -do "exit"

# Modelsim
.PHONY: compile
compile: work/_lib.qdb
.PHONY: wave
wave: waveform.vcd

work/_lib.qdb: $(PARAMS) $(SOURCES) $(TB_SV)
	vlog -nologo $? -suppress 13314

sim: compile
	@vsim $(VSIM_FLAGS) $(basename $(notdir $(TB_SV))) $(VSIM_RUN_FLAGS)

waveform.vcd: compile
	@vsim $(VSIM_FLAGS) $(basename $(notdir $(TB_SV))) $(VSIM_WAVE_FLAGS) $(VSIM_RUN_FLAGS)

clean:
	@rm -r waveform.vcd transcript work