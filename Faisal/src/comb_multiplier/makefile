# Compiler for system verilog
CC = iverilog
# Compiler flags
CFLAGS = -g2012

# Source files ( system verilog .sv)
SRCS = comb_16bit_mul.sv tb_comb_16bit_mul.sv

# Executable name
TARGET = sim

# Default target
all: $(TARGET)
	./$(TARGET)

# Rule to link object files into executable
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(SRCS) -o $(TARGET)

# Target to clean object files and executable
clean:
	rm -f $(TARGET)
