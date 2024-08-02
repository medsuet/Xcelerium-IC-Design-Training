AS := /home/Bilal-Matloob/Documents/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin/riscv64-unknown-elf-as
LD := /home/Bilal-Matloob/Documents/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin/riscv64-unknown-elf-ld
GCC := /home/Bilal-Matloob/Documents/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin/riscv64-unknown-elf-gcc
SPIKE := spike

SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := bin
ASS_DIR := ass

SOURCES_ASS := $(wildcard $(SRC_DIR)/*.s) # Use wildcard to find all .s files
SOURCES_C   := $(wildcard $(SRC_DIR)/*.c) # Use wildcard to find all .c files

ASS         := $(patsubst $(SRC_DIR)/%.c, $(ASS_DIR)/%.s, $(SOURCES_C))
# Uses the patsubst function to convert each .s file path in SOURCES to a corresponding .o file path in the obj directory
OBJECTS     := $(patsubst $(SRC_DIR)/%.s, $(OBJ_DIR)/%.o, $(SOURCES_ASS)) 
# Uses the patsubst function to convert each .s file path in SOURCES to a corresponding executable path in the bin directory
EXECUTABLES := $(patsubst $(SRC_DIR)/%.s, $(BIN_DIR)/%, $(SOURCES_ASS))

# Default target
all : $(EXECUTABLES) $(ASS)

# Make an executable file by first converting the assembly file into an object file using the assembler
# Then linking the object file through the linker to make the executable
$(BIN_DIR)/%: $(SRC_DIR)/%.s
	@echo "Compiling $< to $(OBJ_DIR)/$*.o"
	@mkdir -p $(OBJ_DIR)
	$(AS) -o $(OBJ_DIR)/$*.o $< 
	@echo "Linking $(OBJ_DIR)/$*.o to $@"
	@mkdir -p $(BIN_DIR)
	$(LD) -T linker.ld -o $@ $(OBJ_DIR)/$*.o 

# Make the assembly file from the C file
$(ASS_DIR)/%.s: $(SRC_DIR)/%.c
	@echo "Compiling $< to $(ASS_DIR)/$*.s"
	@mkdir -p $(ASS_DIR)
	$(GCC) -I /home/Bilal-Matloob/Documents/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/include -L /home/Bilal-Matloob/Documents/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/lib -S $< -o $@

# Running with Spike
run: $(BIN_DIR)/$(EXECUTABLE)
	$(SPIKE) $<

# Debugging using Spike
debug: $(BIN_DIR)/$(EXECUTABLE)
	$(SPIKE) -d --log-commits $<	

# Cleaning up
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR) $(ASS_DIR)

.PHONY: all clean run debug
