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

### Assembly:
  Contains the implementation of codes using risc-v assembly.To run the files commands are as follows:
  
    ```bash
      riscv64-unknown-elf-as -o example.o example.s
      riscv64-unknown-elf-ld -T link.ld -o example example.o

    for debigging spike is used:
    ```bash
      spike -d example


### Lab1:
  Contains the implementation of codes in basic C Syntax.
        ```bash 
        gcc example.c


### Lab_2:
  Contains the implementation of codes in advanced(pointers) C Syntax.
  
          ```bash 
              gcc example.c

### Lab_3:
  Contains the implementation of codes in Shell Scripting and basics of makefile.
          ```bash 
              ./example.sh
  for make file:
          ```bash make

          Note: makefile should be in same folder 
             
          
### Python:
    Contains the implementation of Booth Multiplier, Restoring division and direct cache mapping
        ```bash 
            python example.py

### TCL_Lab:
  Contains the implementation of codes in basic tcl_sh Syntax.
        ```bash 
            tclsh example.sh


## Author
- Hira Firdous

