
PARAMS = param/cache_parameters.sv param/axi4lite_parameters.sv
SOURCES = src/cache.sv src/cache_controller.sv src/cache_datapath.sv
TB_CPP = sim/cache_tb.cpp
TB_SV = sim/cache_tb.sv

SIMTIME = 1 ms
NUM_RANDOM_TESTS = 100

# Flags for vsim
VSIM_FLAGS = -c -quiet -voptargs=+acc=npr 
VSIM_WAVE_FLAGS = -do "vcd file waveform.vcd" -do "vcd add -r /*"
VSIM_RUN_FLAGS = -do "run $(SIMTIME)" -do "exit"
VSIM_PRAMS = -g NUM_RANDOM_TESTS=$(NUM_RANDOM_TESTS)

# Modelsim
.PHONY: compile
compile: work/_lib.qdb
.PHONY: wave
wave: waveform.vcd

work/_lib.qdb: $(PARAMS) $(SOURCES) $(TB_SV)
	@vlog -nologo $? -suppress 13314

sim: compile
	@vsim $(VSIM_FLAGS) $(basename $(notdir $(TB_SV))) $(VSIM_RUN_FLAGS) -g NUM_RANDOM_TESTS=$(NUM_RANDOM_TESTS) $(VSIM_PRAMS)

waveform.vcd: compile
	@vsim $(VSIM_FLAGS) $(basename $(notdir $(TB_SV))) $(VSIM_WAVE_FLAGS) $(VSIM_RUN_FLAGS) $(VSIM_PRAMS)

clean:
	@rm -r waveform.vcd transcript work