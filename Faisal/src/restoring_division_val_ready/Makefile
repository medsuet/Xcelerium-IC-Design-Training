# Compiler for system verilog
CC = iverilog
# Compiler flags
CFLAGS = -g2012

# Source files ( system verilog .sv)
SRCS = src/restoring_division.sv test/tb_restoring_division.sv 

# Executable name
TARGET = restoring_division

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