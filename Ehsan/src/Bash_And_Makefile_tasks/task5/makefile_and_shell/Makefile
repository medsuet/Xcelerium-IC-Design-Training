SCRIPTS_DIR := scripts        
INSTALL_DIR := installation_dir      

SCRIPTS := $(wildcard ./scripts/*.sh)

all: check-syntax install

check-syntax:
	@echo "checking_syntax"
	@echo $(SCRIPTS)
	@for script in $(SCRIPTS); do \
		bash -n $$script || exit 1; \
		done
	@echo "syntax_is_okay"
	
# Target to install scripts to the specified directory
install: $(SCRIPTS)
	@echo "installing_scripts_to $(INSTALL_DIR)"
	@mkdir -p $(INSTALL_DIR)
	@for script in $^; do \
		install -m 755 $$script $(INSTALL_DIR); \
	done
	@echo "installation_complete"

# Phony targets
.PHONY: check-syntax install

clean:
	rm -rf $(INSTALL_DIR)
	






















