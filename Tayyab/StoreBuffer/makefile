
PARAMS = defines/*.svh
SOURCES = src/src/*.sv
TB_SV = sim/store_buffer_tb.sv

SIMTIME = 1 ms
NUM_RAND_TESTS = 100
RANDOM_SEED = `date +%s`

# Flags for vsim
VSIM_FLAGS = -c -quiet -voptargs=+acc=npr 
VSIM_WAVE_FLAGS = -do "vcd file waveform.vcd" -do "vcd add -r /*"
VSIM_RUN_FLAGS = -do "run $(SIMTIME)" -do "exit"
VSIM_PRAMS = -g NUM_RAND_TESTS=$(NUM_RAND_TESTS) #-g RANDOM_SEED=$(RANDOM_SEED)

# Modelsim
.PHONY: compile
compile: work/_lib.qdb
.PHONY: wave
wave: waveform.vcd


work/_lib.qdb: $(PARAMS) $(SOURCES) $(TB_SV)
	@vlog -nologo $? -suppress 13314

sim-vsim: compile
	@vsim $(VSIM_FLAGS) $(basename $(notdir $(TB_SV))) $(VSIM_RUN_FLAGS) $(VSIM_PRAMS) -suppress 3829

waveform.vcd: compile
	echo $(RANDOM_SEED)
	@vsim $(VSIM_FLAGS) $(basename $(notdir $(TB_SV))) $(VSIM_WAVE_FLAGS) $(VSIM_RUN_FLAGS) $(VSIM_PRAMS) -suppress 3829

# Verilator
verilate:
	@verilator --binary -Idefines $(TB_SV) $(PARAMS) $(SOURCES) --trace --trace-structs

sim-verilator: verilate
	@./obj_dir/V$(basename $(notdir $(TB_SV)))

clean:
	@rm -r -f waveform.vcd transcript work obj_dir