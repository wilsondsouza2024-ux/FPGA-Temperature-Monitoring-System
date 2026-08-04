# FPGA-Based Real-Time Temperature Monitoring System with Digital Signal Filtering

## Overview

This project implements a real-time temperature monitoring system on an FPGA using Verilog HDL. A 4-tap Moving Average FIR filter is used to reduce noise from temperature sensor readings, providing stable and accurate temperature measurements with low latency.

The project demonstrates how FPGA-based digital signal processing can improve the reliability of temperature monitoring systems for environmental monitoring, industrial automation, biomedical devices, and IoT applications.

MATLAB is used to generate synthetic temperature signals and expected outputs, while Vivado is used to simulate and verify the hardware implementation.

---

## Features

- FPGA implementation using Verilog HDL
- 4-Tap Moving Average FIR Filter
- Real-time temperature signal processing
- MATLAB-based temperature signal generation
- Automatic generation of test vectors (.mem files)
- Verilog Testbench for functional verification
- Vivado simulation and waveform analysis
- Noise reduction using digital signal filtering

---

## Technologies Used

- Verilog HDL
- MATLAB
- Xilinx Vivado
- FPGA
- Digital Signal Processing (DSP)

---

## Project Workflow

Temperature Signal
        │
        ▼
MATLAB Signal Generation
        │
        ▼
temp_data.mem
        │
        ▼
Verilog Moving Average FIR Filter
        │
        ▼
Filtered Temperature Output
        │
        ▼
Vivado Simulation & Verification

---

## Repository Structure

```
FPGA-Temperature-Monitoring-System/

│── matlab/
│   ├── generate_temp_signal.m
│   ├── temp_data.mem
│   ├── expected_output.mem
│
│── verilog/
│   ├── moving_avg_filter.v
│   ├── sensor_interface.v
│   ├── adc_controller.v
│   ├── temperature_processing.v
│   └── display_controller.v
│
│── testbench/
│   └── tb_moving_avg_filter.v
│
│── simulation_results/
│
│── images/
│
│── report/
│
├── README.md
├── LICENSE
└── .gitignore
```

---

## MATLAB

The MATLAB script generates a synthetic temperature signal with Gaussian sensor noise.

It performs:

- Temperature signal generation
- Noise addition
- Fixed-point quantization
- Generation of temp_data.mem
- Generation of expected_output.mem
- Visualization of clean and filtered signals

---

## Verilog Design

The FPGA design implements a 4-Tap Moving Average FIR Filter.

The filter computes:

y[n] = (x[n] + x[n−1] + x[n−2] + x[n−3]) / 4

The design processes one sample every clock cycle while maintaining low hardware complexity and low latency.

---

## Testbench

The Verilog testbench:

- Reads temperature samples from temp_data.mem
- Applies them to the FIR filter
- Compares the output against expected_output.mem
- Displays PASS/FAIL results
- Generates Vivado simulation waveforms

---

## Simulation Results

The simulation demonstrates:

- Successful removal of high-frequency sensor noise
- Stable temperature measurements
- Correct Moving Average FIR filter operation
- Functional verification using Vivado

(Add MATLAB plots and Vivado waveform screenshots here.)

---

## Applications

- Environmental Monitoring
- Industrial Automation
- Biomedical Devices
- IoT Systems
- Smart Agriculture
- Embedded Systems

---

## Future Improvements

- Real LM35 sensor interface
- ADC hardware integration
- LCD display interface
- UART communication
- Wireless IoT connectivity
- Multi-sensor monitoring
- FPGA hardware implementation

---

## Contributors

This project was developed as part of a Course Level Problem Based Learning (CLPBL) project.

Team Members:

- Wilson Dsouza
- Mokshith S. V.
- Pratham K. S.
- Shaman Rai

Faculty Guide:

Ms. Chaithra U. R.

---

## License

This project is licensed under the MIT License.
