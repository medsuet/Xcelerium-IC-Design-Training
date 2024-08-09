# Makefile for managing shell scripts

# Variables
SCRIPTS_DIR = Scripts

# List of scripts to install
SCRIPTS = $(wildcard $(SCRIPTS_DIR)/*.sh)
TARGET_SCRIPTS = $(notdir $(SCRIPTS))

# Targets and Rules
.PHONY: all install clean run_script1 run_script2 run_script3

all: install

install: $(TARGET_SCRIPTS)

$(TARGET_SCRIPTS):
	@echo "Setting executable permissions for $@..."
	@chmod +x $(SCRIPTS_DIR)/$@

clean:
	@echo "Cleaning up..."
	# Add cleaning commands if needed

run_script1:
	@echo "Running script1.sh..."
	@$(SCRIPTS_DIR)/script1.sh

run_script2:
	@echo "Running script2.sh..."
	@$(SCRIPTS_DIR)/script2.sh

run_script3:
	@echo "Running script3.sh..."
	@$(SCRIPTS_DIR)/script3.sh
