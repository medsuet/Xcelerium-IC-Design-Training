# Xcelerium IC Design Training

This repository contains code for the Xcelerium IC Design Training. The code is divided into different experiments, each located in separate directories.

## Directory Structure

/Xcelerium-IC-Design-Training
└── Nasir
  └── src
     ├── exp1
        └── day1.c

└── Nasir
   └── src
     └── exp2
        ├── day2.c
        └── final.c


        



## How to Clone the Repository

To clone this repository, use the following command:

```bash
git clone https://github.com/mnasirEE/Xcelerium-IC-Design-Training.git
```
## How to Compile and Run the Code
### Experiment 1 (exp1)

1. Navigate to the exp1 directory:

```bash
cd /Xcelerium-IC-Design-Training/Nasir/src/exp1
```

2. Compile day1.c using gcc:

```bash
gcc day1.c -o day1
```

3. Run the compiled program:

```bash
./day1
```

### Experiment 2 (exp2)


1. Navigate to the exp2 directory:

```bash
cd /Xcelerium-IC-Design-Training/Nasir/src/exp2
```

2. Compile day2.c using gcc:

```bash
gcc day2.c -o day2
```

3. Run the compiled program:

```bash
./day2
```
4. Compile final.c using gcc:

```bash
gcc finalTask.c -o finalTask
```

3. Run the compiled final program:

```bash
./finalTask
```

### Experiment 3 (exp3) Shell Scripting and Makefile

└── Nasir
   └── src
     └── exp3
        ├── lab1
        └── lab2
        ├── lab3
        └── lab4
        ├── lab5

1. Navigate to the exp3 directory:

```bash
cd /Xcelerium-IC-Design-Training/Nasir/src/exp3
```

2. Convert mode of .sh file into executable
   
```bash
   chmod +x filename.sh
```
#### Explanation:

   It will change mode of .sh file into executable
   #### Note: 
            Change filename with actual filename to execute

3. run shell script

```bash
   ./filename.sh
```

#### Explanation:

   It will run .sh file
   #### Note: 
            Change filename with actual filename to execute

### Experiment 4 (exp4) TCL Scripting

└── Nasir
   └── src
     └── exp4
        ├── task1.tcl
        └── task2.tcl

1. Navigate to the exp4 directory:

```bash
cd /Xcelerium-IC-Design-Training/Nasir/src/exp4
```

2. Convert mode of .tcl file into executable
   
```bash
   chmod +x filename.tcl
```
#### Explanation:
   It will change mode of TCL file into executable
   #### Note:
            Change filename with actual filename to execute

3. run .tcl script

```bash
   tclsh filename.tcl
```

#### Explanation:

   It will run TCL file
   #### Note: 
            Change filename with actual filename to execute

### Experiment 5 (exp3) RISC-V Assembly

└── Nasir
   └── src
     └── exp5


1. Navigate to the exp5 directory:

```bash
cd /Xcelerium-IC-Design-Training/Nasir/src/exp5
```

#### Use of Makefile
##### 1. Change Makefile 
   Change PROG variable with the actual assembly file without extension, you want to run

##### 2. RUN Makefile
1. make all
```bash
   make all 
```

#### Explanation:

   Compile the RISC-V Assembly script into objectfile and link it by linker script

2. make run
```bash
   make run 
```

#### Explanation:

   run the RISC-V Assembly script without any flag

3. make debug
```bash
   make debug 
```

#### Explanation:

   run the RISC-V Assembly script with flags -d --log-commits.
   These flags show line by line execuation with information given below

   """
   core   0: >>>>  _start
   core   0: 0x0000000080000020 (0x00000297) auipc   t0, 0x0
   core   0: 3 0x0000000080000020 (0x00000297) x5  0x0000000080000020
   (spike) 
   core   0: 0x0000000080000024 (0xfe028293) addi    t0, t0, -32
   core   0: 3 0x0000000080000024 (0xfe028293) x5  0x0000000080000000

   """

4. make clean
```bash
   make clean
```

#### Explanation:

   It will remove .o files



### Experiment 6 (exp6) Python Problems

└── Nasir
   └── src
     └── exp6


1. Navigate to the exp5 directory:

```bash
cd /Xcelerium-IC-Design-Training/Nasir/src/exp6
```

2. Run .py files

   Convert mode of .py file into executable
   
```bash
   chmod +x boothMultiplier.py
```
#### Explanation:

   It will change mode of boothMultiplier.py into executable mode
```bash
   chmod +x nonRestoringDivision.py
```
#### Explanation:

   It will change mode of nonRestoringDivision.py into executable mode


```bash
   python3 boothMultiplier.py
```
#### Explanation:

   It will run boothMultiplier.py

```bash
   python3 nonRestoringDivision.py
```

#### Explanation:

   It will run nonRestoringDivision.py


