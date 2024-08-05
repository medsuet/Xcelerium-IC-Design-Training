# Default file names
default_files = src/seqMul.sv src/seqMul_tb.sv

# Use the provided files or default files if none are provided
file = $(if $(FILES),$(FILES),$(default_files))

# Extract the base names for cleanup (removing the "src/" prefix and ".sv" suffix)
base_files = $(basename $(notdir $(file)))

compile:
	vlog $(file)

simulate: compile
	vsim -c Counter_tb -quiet -do "run 400 ns; quit -f" | grep -v '^#' | tee transcript

clean:
	rm -rf work transcript vsim.wlf \
		$(foreach bf, $(base_files), src/$(bf).sv.bak src/$(bf).cr.mti src/$(bf).mpf)

