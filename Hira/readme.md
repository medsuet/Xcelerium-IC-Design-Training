# Training Material.
This repository contains resources and materials related to IC design training 

## File: 
  Following are the files so far:
  - Assembly
  - Lab1
  - Lab_2
  - Lab_3
  - Python
  - TCL_Lab 
  - Verilog
  - Signed Multiplier

### Assembly:
  Contains the implementation of codes using risc-v assembly.To run the files commands are as follows:
  
    ```bash
      riscv64-unknown-elf-as -o example.o example.s
      riscv64-unknown-elf-ld -T link.ld -o example example.o
    ```
    for debugging spike is used:
    
`spike -d example`


### Lab1:
  Contains the implementation of codes in basic C Syntax.     
`gcc example.c`


### Lab_2:
  Contains the implementation of codes in advanced(pointers) C Syntax.
  `gcc example.c`

### Lab_3:
  Contains the implementation of codes in Shell Scripting and basics of makefile. 
`./example.sh`
for make file:
    `make`
Note: makefile should be in same folder 
             
          
### Python:
    Contains the implementation of Booth Multiplier, Restoring division and direct cache mapping
`python example.py`

### TCL_Lab:
  Contains the implementation of codes in basic tcl_sh Syntax. 
`tclsh example.sh`

### Signed Multiplier:
  Verilog imlementation of signed multiplier and verification environment using COCTB 
  `make`


## Author
- Hira Firdous

