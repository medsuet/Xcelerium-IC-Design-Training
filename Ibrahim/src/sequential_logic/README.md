# Sequential logic Timing Analysis
This project include two sequential circuit designs `pop_quiz` and `4bit_counter` . The two designs are tested and compared with the timing diagrams drawn on wavedrom(in docs folder of two folders respectively) 
## Prerequisites

Ensure you have the following tools installed:
- [Icarus Verilog](http://iverilog.icarus.com/)
- [GTKWave](http://gtkwave.sourceforge.net/)

## Usage

### Default Targets

- **Compile and Simulate both projects:**
  ```bash
  make all
  ```
`pop_quiz` Project
- Compile and Simulate:
    ```bash
    make pop_quiz
    ```
- View Waveform:
    ```bash
    make view_pop_quiz
    ```
`4bit_counter` Project
- Compile and Simulate:
    ```bash
    make counter
    ```
- View Waveform:
    ```bash
    make view_counter
    ```
- **Clean Up**
     
    Remove generated files:
    ```bash
    make clean
    ```