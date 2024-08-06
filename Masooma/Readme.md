
# Xcelerium Training Tasks

This document provides guidelines for compiling and evaluating lab tasks using the provided Makefile in the Xcelerium-IC-Design-Training/Masooma directory.


## LAB 1
The file lab1_x.c contains source code for Lab 1 tasks. To compile and run the Lab 1 executable, execute the following command in Xcelerium-IC-Design-Training/Masooma directory:

    make lab1

## Lab 2

The file lab2_x.c contains source code for first seven tasks of Lab 2. To compile and run the Lab 2 executable, execute the following command in Xcelerium-IC-Design-Training/Masooma directory:

    make lab2

## Lab 3

The lab3 directory contains tasks for Lab 3. To run the first four tasks of Lab 3, execute the following command in the Xcelerium-IC-Design-Training/Masooma directory:

    make lab3
To run task 5.1 of lab 3, run the following command in Xcelerium-IC-Design-Training/Masooma/lab3/task5_1_x directory:
 

    make -f task5_1.mk
To run task 5.2 of lab 3, run the following command in Xcelerium-IC-Design-Training/Masooma/lab3/task5_2_x directory:
 

    make -f task5_2.mk
To run task 5.3 of lab 3, run the following command in Xcelerium-IC-Design-Training/Masooma/lab3/task5_3_x directory:
 

    make -f task5_3.mk
   

## Booth Multiplication Task

The file booth.c contains the source code for Booth Multiplication and its test cases. To compile and run the Booth Multiplication executable with different test cases, execute the following command in the Xcelerium-IC-Design-Training/Masooma directory:

    make booth

## Lab 5

The folder named lab5 contains the tcl files. To run both of the files write the following command in the Xcelerium-IC-Design-Training/Masooma directory:

    make lab5
## 	Maze code
To compile and run maze code execute the following command in the Xcelerium-IC-Design-Training/Masooma directory:

    make maze
## Lab 6

The folder named lab6 contains the tasks of lab 6. To compile and link an assembly file, run the following command in the 
Xcelerium-IC-Design-Training/Masooma/lab6 directory:

    make PROG=program.S
  To run code on spike:

    make run PROG=program.S
Log of spike will be saved into spike.log file

**Task 1--part(a):**
 To compile and link:
 
      make PROG=task1_a.S

To run on Spike:

    make run PROG=task1_a.S

**Task1--part(b) :**
 To compile and link :
 
    make PROG=task1_b.S
To run on Spike:

    make run PROG=task1_b.S
**Task 1--part(c):**
 To compile and link:  
 
    make PROG=task1_c.S
 To run on Spike :

    make run PROG=task1_c.S
**Task 1--part(d):**
 To compile and link :
 
    make PROG=task1_d.S
  To run on Spike:

    make run PROG=task1_d.S
**Task 1--part(e):**
 To compile and link:
 
    make PROG=task1_e.S
  To run on Spike:

    make run PROG=task1_e.S
**Task 2:**
To compile and link:
  
    make PROG=restore.S march=rv32ima_zicsr mabi=ilp32 elf=elf32lriscv
 To run on Spike:

    make run PROG=restore.S march=rv32ima_zicsr mabi=ilp32 elf=elf32lriscv isa=RV32IM
To convert restore.c into assembly(ass.S):

    make assembly CFILE=restore.c
Using Optimization Flags:

    make ass_optimize CFILE=restore.c OFLAG=O2

  **Task 3(Bit Clear):**
  To compile and link:
  
    make PROG=bit_clear.S march=rv32ima_zicsr mabi=ilp32 elf=elf32lriscv
To run on Spike:

    make run PROG=bit_clear.S march=rv32ima_zicsr mabi=ilp32 elf=elf32lriscv isa=RV32IM
 To convert bit_clear.c into assembly(ass.S):

    make assembly CFILE=bit_clear.c
Using Optimization Flags:

    make ass_optimize CFILE=bit_clear.c OFLAG=O2
  **Task 3(Bit Set):**
  To compile and link:
  
    make PROG=bit_set.S march=rv32ima_zicsr mabi=ilp32 elf=elf32lriscv
To run on Spike:

    make run PROG=bit_set.S march=rv32ima_zicsr mabi=ilp32 elf=elf32lriscv isa=RV32IM

To convert bit_set.c into assembly(ass.S):

    make assembly CFILE=bit_set.c
Using Optimization Flags:

    make ass_optimize CFILE=bit_set.c OFLAG=O2
 **Task 3:**
 To compile and link:
    
    make PROG=non_restore.S march=rv32ima_zicsr mabi=ilp32 elf=elf32lriscv
To run on Spike:

    make run PROG=non_restore.S march=rv32ima_zicsr mabi=ilp32 elf=elf32lriscv isa=RV32IM

To convert non_restore.c into assembly(ass.S):

    make assembly CFILE=non_restore.c
Using Optimization Flags:

    make ass_optimize CFILE=non_restore.c OFLAG=O2

## Lab 7
The folder named lab7 contains the .py files. To run a file write the following command in the Xcelerium-IC-Design-Training/Masooma directory:

    make lab7 TASK=mytask.py
To run task1:

    make lab7 TASK=task1.py
To run task2:

    make lab7 TASK=task1=2.py
To run task3:

    make lab7 TASK=task3.py
##Lab 8
The folder named multiplier contains the .sv files. To compile a source files and testbench on verilator, write the following command in the Xcelerium-IC-Design-Training/Masooma/multiplier directory:

    make
To run testbench

    make run
To clean obj_dir and .vcd:

    make clean




