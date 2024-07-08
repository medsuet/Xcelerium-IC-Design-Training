# Define directories for the Shell Scripts
SCRIPTS_DIR := scripts           #indicating where the shell scripts are located
INSTALL_DIR := install_dir       #indicating where the install scripts are present

SCRIPTS := $(wildcard ./scripts/*.sh)

all: check-syntax install

# Target to check syntax of all scripts
# Checks the syntax of all shell scripts using bash -n.
# If any script has a syntax error, make will stop with an error.

check-syntax:
	@echo "Checking syntax of scripts..."
	@echo $(SCRIPTS)
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

# Phony targets
.PHONY: check-syntax install

# Clean up object files and executables
clean:
	rm -rf $(INSTALL_DIR)
	






















