# Store buffer for UETRV_PVore

Current status: Combinational loop when integrating store buffer into UETRV_PCore.

### Simulation
There are two makefiles: "makefile" for unit testing and "makefile_int" for integration testing. Corressponding to the two make files are two testbenches: "store_buffer_tb" and "store_buffer_integartion_tb". 

By default, make targets (listed below) run from "makefile". To run integration tests, use `-f makefile_int` flag to specify makefile.

`make sim-vsim`\
Simulates using Modelsim. Compiles modules if required.

`make sim-verilator`\
Simulates using Verilator. Verilates modules if required.

### Folder: uetrv_pcore_memory_storebuffer
This folder contains memory module from UETRV_PCore, with store buffer integrated into it. The store_buffer subfolder contains a copy of files in src/src.