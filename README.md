
# AHB Protocol Verification using UVM

## Overview

This project focuses on the verification of the Advanced High-performance Bus (AHB) protocol using Universal Verification Methodology (UVM) in SystemVerilog.

The verification environment is designed to validate AHB read and write transactions, burst transfers, address and data phases, reset functionality, and protocol compliance using reusable UVM components such as driver, monitor, sequencer, agent, scoreboard, functional coverage, and SystemVerilog assertions.

---

## About AHB Protocol

Advanced High-performance Bus (AHB) is a high-speed AMBA bus protocol developed by ARM for connecting high-performance masters and slaves in System-on-Chip (SoC) designs.

AHB supports:

- Single and Burst Transfers
- Pipelined Address and Data Phases
- Multiple Bus Masters
- Split and Retry Responses (AHB)
- Wait State Insertion
- High Throughput Data Transfers

The protocol is widely used for communication between processors, DMA controllers, memories, and high-speed peripherals.

---

## UVM Verification Environment

The verification environment consists of:

- Sequence Item
- Sequence
- Sequencer
- Driver
- Monitor
- Agent
- Scoreboard
- Functional Coverage
- Environment
- Testcases

---

## Verification Architecture

<img width="878" height="511" alt="image" src="https://github.com/user-attachments/assets/1512bdd8-10e3-40a7-94fe-5d6f5256da7b" />





## Components Description

### Sequence Item

Generates randomized AHB transactions including address, write/read control, transfer type, burst information, transfer size, and write data.

---

### Sequence

Creates constrained-random AHB transactions and sends them to the sequencer.

---

### Sequencer

Controls the flow of transactions between the sequence and the driver.

---

### Driver

Converts sequence items into AHB bus transactions and drives the DUT through the virtual interface while following the AHB protocol timing.

---

### Monitor

Observes bus activity, captures transactions, and forwards them to the scoreboard and coverage collector.

---

### Agent

Encapsulates the driver, sequencer, and monitor to create a reusable verification component.

---

### Scoreboard

Compares expected and actual DUT behavior to verify data integrity and protocol correctness.

---

### Functional Coverage

Collects coverage on important protocol features including:

- Read and Write Operations
- Transfer Types
- Burst Types
- Transfer Sizes
- Address Coverage
- Cross Coverage

---

### Assertions

SystemVerilog Assertions (SVA) are implemented inside the interface to verify protocol correctness such as:

- Valid Transfer Detection
- Address Stability
- Control Signal Stability
- Reset Behavior
- Handshake Timing
- Protocol Compliance

---

## Testcases Verified

The verification environment includes the following test scenarios:

- Reset Verification
- Single Write Transfer
- Single Read Transfer
- Back-to-Back Transfers
- Randomized Transactions
- Different Transfer Sizes
- Different Burst Types
- Wait State Verification
- Functional Coverage Collection

---

## Simulation Results

### AHB Write Transaction

![Write Waveform](images/AHB_write_transaction.png)

---

### AHB Read Transaction

![Read Waveform](images/AHB_read_transaction.png)

---

### AHB Burst Transfer

![Burst Waveform](images/AHB_burst_transaction.png)

---

### Functional Coverage Report

![Coverage](images/AHB_coverage_report.png)

---

## Directory Structure

```
AHB-UVM-Verification
│
├── rtl
│   └── ahb_slave.v
│
├── tb
│   ├── package.sv
│   ├── interface.sv
│   ├── seq_item.sv
│   ├── sequence.sv
│   ├── sequencer.sv
│   ├── driver.sv
│   ├── monitor.sv
│   ├── agent.sv
│   ├── env.sv
│   ├── scoreboard.sv
│   ├── coverage.sv
│   ├── test.sv
│   └── top.sv
│
├── sim
│   └── makefile
│
└── README.md
```

---

## Tools and Technologies

- SystemVerilog
- Universal Verification Methodology (UVM)
- Cadence SimVision
- Linux
- GNU Make

---

## Verification Features

- Reusable UVM Testbench Architecture
- Constrained Random Verification
- Functional Coverage
- Self-checking Scoreboard
- SystemVerilog Assertions (SVA)
- Protocol Compliance Checking
- Modular and Scalable Verification Environment

---

## Future Enhancements

- Incrementing Burst Verification
- Wrapping Burst Verification
- Error Response Verification
- Multiple Slave Verification
- Regression Automation
- Coverage Closure

---

## Conclusion

This project demonstrates a reusable and scalable UVM-based verification environment for the AHB protocol. The environment validates protocol functionality using constrained-random stimulus, functional coverage, protocol assertions, and transaction-level checking. The modular architecture enables easy extension for additional features and supports industry-standard verification methodologies for high-performance bus protocols.
