
SOURCES = src/axi4lite_controller.sv
TB_SV = sim/axi4lite_controller_tb.sv

SIMTIME = 2 ns
NUM_RANDOM_TESTS = 20
RANDOM_SEED = `date +%s`

# Flags for vsim
VSIM_FLAGS = -c -quiet -voptargs=+acc=npr 
VSIM_WAVE_FLAGS = -do "vcd file waveform.vcd" -do "vcd add -r /*"
VSIM_RUN_FLAGS = -do "run $(SIMTIME)" -do "exit"
VSIM_PRAMS = -g NUM_RANDOM_TESTS=$(NUM_RANDOM_TESTS) -g RANDOM_SEED=$(RANDOM_SEED)

# Modelsim
.PHONY: compile
compile: work/_lib.qdb
.PHONY: wave
wave: waveform.vcd

work/_lib.qdb: $(SOURCES) $(TB_SV)
	@vlog -nologo $? -suppress 13314

sim: compile
	@vsim $(VSIM_FLAGS) $(basename $(notdir $(TB_SV))) $(VSIM_RUN_FLAGS) $(VSIM_PRAMS)

waveform.vcd: compile
	@vsim $(VSIM_FLAGS) $(basename $(notdir $(TB_SV))) $(VSIM_WAVE_FLAGS) $(VSIM_RUN_FLAGS) $(VSIM_PRAMS)

clean:
	@rm -r waveform.vcd transcript work