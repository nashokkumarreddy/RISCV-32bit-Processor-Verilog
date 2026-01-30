# RISCV-32bit-Processor-Verilog
A Single-Cycle RISC-V Core designed in Verilog and simulated in ModelSim
# 32-bit RISC-V Single-Cycle Processor (RV32I)

## 📌 Project Overview
This project involves the design and implementation of a **32-bit Single-Cycle Processor** based on the open-source **RISC-V Instruction Set Architecture (ISA)**. The core is designed using **Verilog HDL** and verified using **ModelSim**.

The processor supports a subset of the **RV32I** base integer instruction set, including R-Type (Arithmetic) and I-Type (Immediate) instructions. It was successfully tested by executing a **Fibonacci Sequence algorithm**, demonstrating correct data processing, register manipulation, and memory access.

## 🚀 Features
- **Architecture:** 32-bit RISC-V (Single-Cycle Datapath).
- **Instruction Support:** ADD, SUB, AND, OR, XOR, SLT, ADDI.
- **Modular Design:**
  - **ALU (Arithmetic Logic Unit):** Performs arithmetic and logical operations.
  - **Register File:** 32x32-bit registers (x0 hardwired to 0).
  - **Control Unit:** Decodes opcodes and generates control signals.
  - **Instruction Memory:** Stores the program code (Hex machine code).
  - **Immediate Generator:** Handles sign extension for immediate values.
- **Verification:** Verified with a custom testbench running the Fibonacci Sequence.

## 📂 File Structure
| File Name | Description |
| :--- | :--- |
| `riscv_top.v` | **Top Module:** Connects all components (ALU, RegFile, Control, etc.). |
| `alu.v` | **ALU:** Handles math logic (Add, Sub, AND, OR, etc.). |
| `reg_file.v` | **Register File:** 32 registers (x0-x31) with synchronous write and asynchronous read. |
| `control_unit.v` | **Control Unit:** Decodes instructions and manages control signals. |
| `imem.v` | **Instruction Memory:** ROM containing the Fibonacci machine code. |
| `imm_gen.v` | **Immediate Generator:** Extracts and extends immediate values from instructions. |
| `tb_riscv_top.v` | **Testbench:** Generates clock/reset and monitors simulation output. |

## 📊 Simulation Results
The design was verified in **ModelSim**. The waveform below shows the processor calculating the **Fibonacci Sequence**:
`1, 1, 2, 3, 5, 8, 13...`

> **Note:** See the `ALUResult` signal in the waveform for the sequence output.

![Simulation Waveform](simulation_result.png)
<img width="1919" height="1199" alt="image" src="https://github.com/user-attachments/assets/2c824e1a-096f-4ffb-b046-5dbf4ab3fcee" />
<img width="1914" height="1198" alt="image" src="https://github.com/user-attachments/assets/ea7b4bbc-4aa7-421e-8cd0-d625669340d6" />




## 🛠️ Tools Used
- **Language:** Verilog HDL
- **Simulator:** ModelSim - Intel FPGA Starter Edition
- **Waveform Viewer:** ModelSim Wave

## ⚙️ How to Run
1.  Clone this repository:
    ```bash
    git clone [https://github.com/nashokkumarreddy/RISCV-32bit-Processor-Verilog.git](https://github.com/your-username/RISCV-32bit-Processor-Verilog.git)
    ```
2.  Open **ModelSim** and create a new project.
3.  Add all `.v` files from the repository to the project.
4.  Compile all files.
5.  Run the simulation on `tb_riscv_top.v`.
6.  Add `ALUResult` to the wave window and set Radix to **Decimal** to view the output sequence.

## 👤 Author
**N ASHOK KUMAR REDDY**
*Electronics and Communication Engineering (ECE)*
*AUDISANKARA COLLAGE OF ENGG AND TECH *
