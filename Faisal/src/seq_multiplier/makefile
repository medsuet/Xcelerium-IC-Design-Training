# Compiler for system verilog
CC = iverilog
# Compiler flags
CFLAGS = -g2012

# Source files ( system verilog .sv)
SRCS = src/seq_multiplier.sv test/tb_seq_multiplier.sv src/datapath.sv src/controller.sv

# Executable name
TARGET = seq_multiplier

# Default target
all: $(TARGET)
	./$(TARGET)

# Rule to link object files into executable
$(TARGET):
	$(CC) $(CFLAGS) $(SRCS) -o $(TARGET)

simulate: ./$(TARGET)
	gtkwave $(TARGET).vcd

# Target to clean object files and executable
clean:
	rm -f $(TARGET) $(TARGET).vcd
# Clean target
.PHONY: clean