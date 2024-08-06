#!/bin/bash

INSTALL_DIR = installScripts
SCRIPTS := sum.sh number.sh factorial.sh


all: check test
check:
	@echo "Checking scripts for syntax errors"
	@for script in $(SCRIPTS); do \
		if ! bash -n $$script; then \
			exit 1; \
		fi; \
	done
	@echo "Syntax check passed for all scripts."

test:
	@echo "Running unit tests..."
	./number.sh 5
	./number.sh 13
	./factorial.sh
	./factorial.sh
	./sum.sh

install:
	@echo "Installing scripts to $(INSTALL_DIR)"
	mkdir -p $(INSTALL_DIR)
	cp $(SCRIPTS) $(INSTALL_DIR)
	@echo "Scripts installed successfully to $(INSTALL_DIR)"

clean:
	@echo "Cleaning up"
	rm -R $(INSTALL_DIR)

