# Variables 
SRC_DIR = src
TEST_DIR = test
SRC_FILE := $(SRC_DIR)/pop_quiz.sv
TB_FILE := $(TEST_DIR)/pop_quiz_tb.sv

TB_CPP := pop_quiz_tb
MODULE := pop_quiz_tb

# Define Iverilog and VSIM variables
IVERILOG = iverilog
VVP = vvp
VSIM = vsim
VSIM_FLAGS = -c -do "run -all; quit"

IVERILOG_OUT = iverilog_sim.vvp
VSIM_OUT = modelsim_sim.out
GTKWAVE = pop_quiz.vcd

# Define Verilator variable
VERILATOR = verilator
VERILATOR_FLAGS = -Wall --cc

DEFINES_VER:= src/defines/verilator.svh

# Default target
all: help

# Verilator Compile and run and view waveform
verilator: 
	@echo "Running Verilator simulation..."
	verilator --trace -cc $(SRC_FILE) $(TB_FILE) $(DEFINES_VER) \
	  	  --top-module $(MODULE)     \
		  -Wno-DECLFILENAME 		 \
		  -Wno-WIDTH 				 \
		  -Wno-REDEFMACRO			 \
		  -Wno-INITIALDLY			 \
		  --exe ./test/$(TB_CPP).cpp \
		  --timing
	make -C obj_dir -f V$(MODULE).mk V$(MODULE)
	./obj_dir/V$(MODULE)
	@echo "Opening waveform with GTKWave..."
	gtkwave $(GTKWAVE)

# Icarus Verilog compile and run
iverilog: $(SRC_FILE) $(TB_FILE)
	@echo "Compiling with Icarus Verilog..."
	$(IVERILOG) -g2012 -o $(IVERILOG_OUT) $(TB_FILE) $(SRC_FILE)
	@echo "Running simulation with Icarus Verilog..."
	$(VVP) $(IVERILOG_OUT)

# ModelSim compile and run
vsim: $(SRC_FILE) $(TB_FILE)
	@echo "Compiling with ModelSim..."
	vlog $(SRC_FILE) $(TB_FILE)
	@echo "Running simulation with ModelSim..."
	$(VSIM) $(VSIM_FLAGS) $(MODULE)

# View waveform using GTKWave
view: 
	@echo "Opening waveform with GTKWave..."
	gtkwave $(GTKWAVE)

# Clean up generated files
clean:
	@echo "Cleaning up..."
	rm -f $(IVERILOG_OUT) $(VSIM_OUT) $(VCD_FILE) $(GTKWAVE) .stamp.verilate
	rm -rf work obj_dir
	@echo "Clean complete."

# Help target
help:
	@echo "Makefile for compiling and running simulations with Verilator, Icarus Verilog and ModelSim"
	@echo
	@echo "Usage:"
	@echo "  make verilator      Compile, run simulation and view waveform with Verilator"
	@echo "  make iverilog       Compile and run simulation with Icarus Verilog"
	@echo "  make vsim           Compile and run simulation with ModelSim"
	@echo "  make view           View waveform using GTKWave"
	@echo "  make clean          Clean up generated files"
	@echo "  make help           Display this help message"

# Phony targets
.PHONY: all iverilog vsim view clean help verilator
