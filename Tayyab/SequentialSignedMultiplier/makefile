
SOURCES = src/SequentialSignedMultiplier.sv src/datapath.sv src/controller.sv
TB = sim/SequentialSignedMultiplier_tb.cpp

NUMTESTS = 10000

verilate: $(SOURCES)
	verilator --cc $?

simulate : $(TB) $(SOURCES)
	verilator --trace --build --cc $(SOURCES) --exe $(TB)
	./obj_dir/VSequentialSignedMultiplier $(NUMTESTS)

clean:
	@rm -r obj_dir *.vcd