# Compiler for system verilog
CC = iverilog
# Compiler flags
CFLAGS = -g2012

# Source files ( system verilog .sv)
SRCS = counter_4bit.sv tb_counter_4bit.sv

# Executable name
TARGET = test

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
