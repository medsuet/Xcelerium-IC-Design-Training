
# Valid Ready interface restoring division

## State machine
![state_machine](./docs/state_machine.jpg)

## Data path and controller
![data_path_and_controller](./docs/data_path_and_controller.jpg)

## Pinout diagram
![pinout](./docs/pinout_diagram.jpg)

# Run 
Making virtual environment
```bash
python3 -m venv venv
```
	
Activate virtual environment
```bash
source venv/bin/activate  
```

Install pytest cocotb
```bash
pip3 install pytest cocotb cocotb-bus cocotb-coverage
```

Run
```bash
make 
```

To delete files made by simulator
```bash
make clean
```

