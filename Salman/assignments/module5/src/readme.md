## Module 5: Assembly Language

This module gives a comprehensive insight to the assembly language. In this module, we've used the RISCV 64-bit Architecture toolchain. To run and test the code, we've used SPIKE Simulation software specially designed for RISC-V Architecture.

### Running Assembly Files in Problems
To run assembly files provided in the Problems directory, you will use the following command to display usage:
```
make
```
This command will display the usage of how you can compile a specific file and generate its executeable.

Once you've generated the executeable, you can run it using
```
make run
make debug
```

Once you've entered the debug mode, you can press 'ENTER' to progress within the debugger.

### Tasks

In the tasks directory, you will find 3 other directories, simply move into any directory from where you would like to run the code.

You will find a '.s' file which is Assembly code created for that specific task. You will also find a '.c' file which is the equivalent C code for that specific task. To compile them, use the following command:
```
make
```

This make command will generate an executeable file for the assembly file, and generate a '.s' file for the '.c' file.
To run and debug the executeable file, use:
```
make run
make debug
```

Unfortunately, I've not created a generic linker script to be able to run assembly files generated from C codes, so you can only view their assembly through
```
nano filename.s
```
