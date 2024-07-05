CC := gcc
CFLAGS := -Wall

# Define directories for the C FILES
SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := bin

# Find all source files and corresponding object files
SOURCES := $(wildcard $(SRC_DIR)/*.c)   #Uses the wildcard function to find all .c

OBJECTS := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SOURCES))
# Uses the patsubst function to convert each .c file path in SOURCES to a corresponding .o file path in the obj directory and assigns them to the OBJECTS variable.

EXECUTABLES := $(patsubst $(SRC_DIR)/%.c, $(BIN_DIR)/%, $(SOURCES))

#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////#

# Define directories for the Shell Scripts
SCRIPTS_DIR := scripts           #indicating where the shell scripts are located
INSTALL_DIR := install_dir       #indicating where the install scripts are present

SCRIPTS := $(wildcard $(SCRIPTS_DIR)/*.sh)

# Default target to build all executables and check shell scripts
all: all_C all_shell

#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////#
# 													C Makefile section
#////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////#

# Default target to build all executables
all_C: $(EXECUTABLES)

# Rule to create object files from source files dependency generation (-MMD -MP).
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@echo "Compiling $< to $@"
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

# Rule to link object files into executables
$(BIN_DIR)/%: $(OBJ_DIR)/%.o
	@echo "Linking $< to $@"
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) $< -o $@

# Add a 'debug' target that compiles with debugging symbols
debug: CFLAGS += -g
debug: clean all

# Include dependency files
-include $(OBJECTS:.o=.d)
# -include $(OBJECTS:.o=.d): Includes the generated dependency files (.d), allowing Make to track header file dependencies.
# The - suppresses errors if the files don't exist yet.

#//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////#
# 											Shell Makefile section
#/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////#

all_shell: check-syntax install

# Target to check syntax of all scripts
# Checks the syntax of all shell scripts using bash -n.
# If any script has a syntax error, make will stop with an error.
check-syntax:
	@echo "Checking syntax of scripts..."
	@for script in $(SCRIPTS); do \
		bash -n $$script || exit 1; \
	done
	@echo "Syntax check passed!"

# Target to install scripts to the specified directory
install: $(SCRIPTS)
	@echo "Installing scripts to $(INSTALL_DIR)..."
	@mkdir -p $(INSTALL_DIR)
	@for script in $^; do \
		install -m 755 $$script $(INSTALL_DIR); \
	done
	@echo "Installation completed!"

# Clean up object files and executables
clean:
	@echo "Cleaning for C Compilation"
	@echo ""
	rm -rf $(OBJ_DIR) $(BIN_DIR)
	@echo ""
	@echo "Nothing to clean for Shell Scripts"

# Phony targets
.PHONY: all all_C all_shell clean debug check-syntax install
