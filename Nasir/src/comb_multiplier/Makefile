# make file for compiling and running 16 bit combinational signed multiplier

# compiler
COMPILER = iverilog
# flags
FLAGS = -g2012
# target or output
TARGET = mul
# degin files
DESIGNFILE = comb_16_bit_multiplier.sv
# test bench file
TESTBENCH = comb_16_bit_multiplier_tb.sv
# compile first then run executable
all: $(TARGET)
	./$(TARGET)

# compiling using iverilog
$(TARGET): $(DESIGNFILE) $(TESTBENCH)
	$(COMPILER) $(FLAGS) -o $(TARGET) $(TESTBENCH) $(DESIGNFILE) 
# run the compiled output after compiling
run: $(TARGET)
	./$(TARGET)
# clean object files and executables
clean: 
	rm -f *.o $(TARGET)

.PHONY: all run clean
			


