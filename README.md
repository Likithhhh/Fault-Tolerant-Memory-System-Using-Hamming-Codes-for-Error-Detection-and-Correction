
# **Fault-Tolerant Memory System Using Hamming Codes for Error Detection and Correction**

## **Project Overview**

This project focuses on designing and implementing a fault-tolerant memory system that employs **Hamming codes** for **error detection and correction**. The goal is to ensure reliable data storage and retrieval in memory modules, capable of detecting and correcting single-bit errors and identifying two-bit errors. The system uses **Hamming (12,8) encoding** to encode 8-bit data into a 12-bit word with error detection and correction capabilities.

### **Key Features:**
- **Error Detection**: Identifies single-bit errors during data transmission or storage.
- **Error Correction**: Corrects single-bit errors and ensures data integrity.
- **Fault-Tolerant Memory**: Simulates memory with built-in error correction, ensuring robustness for real-world applications.

---

## **Components of the System**

### **1. Hamming Encoder**
The **Hamming Encoder** takes an 8-bit input and generates a 12-bit encoded output by adding four parity bits (P1, P2, P4, P8). These parity bits help in error detection and correction.

### **2. Hamming Decoder**
The **Hamming Decoder** processes the 12-bit encoded data, checks for errors using the parity bits, and corrects any single-bit errors. It also indicates whether an error was detected and corrected.

### **3. Memory Module (EDAC)**
The **MemoryEDAC** module simulates memory with error detection and correction. It stores the encoded data, retrieves it, and performs error correction on read operations. The system is designed to handle single-bit errors by automatically correcting them and flagging the occurrence of errors.

---

## **Project Objective**

The primary objective of this project is to design a **reliable memory system** that integrates **error detection and correction** (EDAC) using **Hamming codes**. The memory module simulates realistic storage systems used in environments where data integrity is critical, such as data centers and embedded systems.

The project ensures that:
- Data integrity is maintained even in the presence of errors.
- The system can recover from single-bit errors automatically.
- The system flags and identifies errors, aiding debugging and maintenance.

---

## **System Design**

### **Hamming Encoder**
- The 8-bit input data is encoded into a 12-bit word using the Hamming encoding algorithm.
- The encoder calculates four parity bits based on specific bits in the data word.

### **Hamming Decoder**
- The decoder checks for errors in the 12-bit word using a syndrome vector.
- If errors are detected, the decoder identifies and corrects single-bit errors.

### **MemoryEDAC**
- Simulates a memory system with multiple memory cells.
- Uses the encoder to store encoded data and the decoder to read and correct errors when retrieving data.

---

## **Project Setup and Simulation**

### **1. Tools Required**
- **Verilog**: The hardware description language used for designing and simulating the system.
- **EDA Playground**: An online platform to write, compile, and simulate Verilog code.
- **GTKWave**: A waveform viewer for inspecting the simulation results.
- **iverilog**: The compiler used to compile Verilog code.

### **2. How to Run the Project**
1. Clone or download the project repository to your local machine.
2. Open the `design.sv` and `testbench.sv` files in an online IDE like **EDA Playground** or any Verilog simulator.
3. Compile and simulate the project using the commands below:
   ```bash
   iverilog -Wall -g2012 design.sv testbench.sv
   vvp a.out
   ```
4. View the simulation results using **GTKWave** or your simulator's waveform viewer.
5. The testbench provides a sequence where data is written to memory and then read back with and without errors to test the system’s fault tolerance.

---

## **Testbench**

The **testbench** simulates the entire memory module operation, including:
- Writing data to memory using the **Hamming Encoder**.
- Reading data from memory, checking for errors, and correcting them using the **Hamming Decoder**.
- Introducing a simulated error (bit-flip) in memory to test error detection and correction.

---

## **Project Structure**

```
.
├── design.sv          # Verilog design for Hamming Encoder, Decoder, and MemoryEDAC
├── testbench.sv       # Verilog testbench for simulation
├── simulation.vcd     # VCD file for waveform visualization
└── README.md          # Project documentation (you are here!)
```

---

## **Simulation Results**

The simulation demonstrates:
- Correct operation of the **Hamming Encoder** and **Hamming Decoder**.
- The ability to detect and correct single-bit errors in data.
- Error detection flags (`error_detected`) and error correction flags (`error_corrected`) are updated appropriately.

For debugging purposes, the project includes **VCD (Value Change Dump)** files to visualize waveform outputs using **GTKWave**.

---

## **Contributions**

Feel free to fork this repository, make changes, and contribute by improving the design or adding new features. Some potential future improvements include:
- Support for detecting and correcting multiple-bit errors.
- Optimizations for higher-speed applications.

---

## **Acknowledgements**

- The **Hamming Code** is widely used in telecommunications and computer systems for error detection and correction.
- Thanks to the **Verilog** community for providing open-source simulation and synthesis tools that made this project possible.


