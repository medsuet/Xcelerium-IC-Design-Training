# Makefile for running Verilator on multiplier.sv and multiplier_tb.cpp
VERILATOR = verilator
VERILATOR_FLAGS = --cc
VERILATOR_TB_FLAGS = -Wall --trace --cc
OBJ_DIR = obj_dir
TARGET = Vmultiplier
SRC = multiplier.sv
TB = multiplier_tb.cpp
all: $(OBJ_DIR)/$(TARGET)
# Run Verilator to compile the SystemVerilog source and testbench
$(OBJ_DIR)/$(TARGET): $(SRC) $(TB)
	$(VERILATOR) $(VERILATOR_TB_FLAGS) $(SRC) --exe $(TB)
	make -C $(OBJ_DIR) -f $(TARGET).mk $(TARGET)
# Run the simulation
run: $(OBJ_DIR)/$(TARGET)
	./$(OBJ_DIR)/$(TARGET)
# Clean up generated files
clean:
	rm -rf $(OBJ_DIR) *.vcd

.PHONY: all run clean
