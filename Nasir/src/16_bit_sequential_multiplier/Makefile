# make file for compiling and running 16 bit combinational signed multiplier

# compiler
COMPILER = iverilog
# flags
FLAGS = -g2012
# target or output
TARGET = signed_multiplier
# degin files
DESIGNFILE = src/sequential_multiplier.sv src/datapath.sv src/controller.sv
# test bench file
TESTBENCH = tests/sequential_multiplier_tb.sv
# compile first then run executable
all: $(TARGET)
	./$(TARGET)

# compiling using iverilog
$(TARGET): $(DESIGNFILE) $(TESTBENCH)
	$(COMPILER) $(FLAGS) -o $(TARGET) $(TESTBENCH) $(DESIGNFILE) 
# run the compiled output after compiling
run: $(TARGET)
	./$(TARGET)

# simulation
vsim: $(TARGET)
	gtkwave $(TARGET).vcd
# clean object files and executables
clean: 
	rm -f *.o *.vcd $(TARGET)

.PHONY: all run clean
			


