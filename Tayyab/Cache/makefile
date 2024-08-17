
PARAMS = param/*.sv
SOURCES = src/*/*.sv
TB_CPP = sim/cache_tb.cpp
TB_SV = sim/cache_tb.sv

SIMTIME = 500

# Flags for vsim
VSIM_FLAGS = -c -quiet -voptargs=+acc=npr
VSIM_WAVE_FLAGS = -do "vcd file waveform.vcd" -do "vcd add -r /$(TB)/*"
VSIM_RUN_FLAGS = -do "run $(SIMTIME) ps" -do "exit"

# Modelsim
vlog: work/_lib.qdb

work/_lib.qdb: $(PARAMS) $(SOURCES) $(TB_SV)
	vlog -nologo $?

vsim_sim: vlog
	@vsim $(VSIM_FLAGS) $(basename $(notdir $(TB_SV))) $(VSIM_WAVE_FLAGS) $(VSIM_ADDWAVE_FLAGS) $(VSIM_RUN_FLAGS) -suppress 3839

# Verilator
verilate: $(PARAMS) $(SOURCES)
	@verilator --cc $?

verilator_sim : $(TB_CPP) $(PARAMS) $(SOURCES)
	@verilator --trace --build --cc $(PARAMS) $(SOURCES) --exe $(TB_CPP) 
#-Wno-fatal
	./obj_dir/Vcache

clean:
	@rm -r obj_dir *.vcd work