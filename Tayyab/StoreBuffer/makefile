
PARAMS = param/sb_defs.svh
SOURCES = src/priority_encoder.sv src/store_buffer.sv src/store_buffer_datapath.sv src/store_buffer_controller.sv
TB_SV = sim/store_buffer_tb.sv

SIMTIME = 1 us
NUM_RAND_TESTS = 100
RANDOM_SEED = `date +%s`

# Flags for vsim
VSIM_FLAGS = -c -quiet -voptargs=+acc=npr 
VSIM_WAVE_FLAGS = -do "vcd file waveform.vcd" -do "vcd add -r /*"
VSIM_RUN_FLAGS = -do "run $(SIMTIME)" -do "exit"
VSIM_PRAMS = -g NUM_RAND_TESTS=$(NUM_RAND_TESTS) -g RANDOM_SEED=$(RANDOM_SEED)

# Modelsim
.PHONY: compile
compile: work/_lib.qdb
.PHONY: wave
wave: waveform.vcd


work/_lib.qdb: $(PARAMS) $(SOURCES) $(TB_SV)
	@vlog -nologo $? -suppress 13314

sim: compile
	@vsim $(VSIM_FLAGS) $(basename $(notdir $(TB_SV))) $(VSIM_RUN_FLAGS) $(VSIM_PRAMS) -suppress 3829

waveform.vcd: compile
	@vsim $(VSIM_FLAGS) $(basename $(notdir $(TB_SV))) $(VSIM_WAVE_FLAGS) $(VSIM_RUN_FLAGS) $(VSIM_PRAMS) -suppress 3829

clean:
	@rm -r -f waveform.vcd transcript work