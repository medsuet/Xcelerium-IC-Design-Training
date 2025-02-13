tb = decimator_tb
sources = src/*.sv
tb_file = sim/decimator_tb.sv
SIMTIME = 4400 ns

compile:work/_lib.qdb

work/_lib.qdb:$(sources) $(tb_file)
	@vlog -nologo $?
    
simulate:compile 
	echo "">build/sv_outputs.txt
	@vsim -c -quiet $(tb) -do "run $(SIMTIME)" -do "exit"
    
waveform.vcd:compile
	@vsim -c -quiet $(tb) -do "run $(SIMTIME)" -do "exit" -do "vcd file waveform.vcd" -do "vcd add -r /*"
	
generate_cases:
	@python3 sim/generate_test_cases.py

compare:simulate
	@diff build/output_file.txt build/sv_outputs.txt

clean:
	rm -rf build work  transcript
