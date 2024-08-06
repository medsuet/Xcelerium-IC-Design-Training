# _*_ Makefile _*_ 

# Compiler and emulator 
AS = riscv64-unknown-elf-as 
LD = riscv64-unknown-elf-ld 
SPIKE = spike
PROG = restoring_division nonRestore_division abs_diff count_sbits example factorial insertion_sort reverse_array set_clear_bit 
   
# Default target 
all: $(PROG)

# Rule to assemble and link 
$(PROG): %: %.S
	@$(AS) -o $@.o $@.S 
	@$(LD) -T linker.ld -o $@ $@.o 

# Rule to run with Spike 
run: $(PROG) 
	@$(foreach prog,$(PROG),$(SPIKE) $(prog);)

clean:
	@rm -f *.o $(PROG) 

# Rule to debug with Spike 
debug:
	@$(SPIKE) -d --log-commits $(prog) 

.PHONY: all run debug clean
