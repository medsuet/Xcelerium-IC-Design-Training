SCRIPTS = script1.sh script2.sh
TESTS = test1.sh test2.sh
INSTALL_DIR = /home/muhammadramzan/XCELERIUM/modules/module_03/Rough

all: check test

check:
	@for script in $(SCRIPTS); do \
		bash -n $$script; \
	done

test:
	@for test_script in $(TESTS); do \
		bash $$test_script; \
	done

install:
	@for script in $(SCRIPTS); do \
		install -m 755 $$script $(INSTALL_DIR); \
	done

clean:
	rm -f $(INSTALL_DIR)/script1.sh $(INSTALL_DIR)/script2.sh

.PHONY: all check test install clean

