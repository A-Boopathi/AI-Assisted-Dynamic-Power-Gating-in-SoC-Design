# AI-Assisted-Dynamic-Power-Gating-in-SoC-Design
AI-powered SoC design with dynamic power gating to reduce runtime leakage power.

## Project Overview
This project implements an **AI-assisted dynamic power-gating technique** for minimizing **runtime leakage power** in **System-on-Chip (SoC)** designs.  
Unlike traditional static power-gating, which is inefficient under variable workloads, this design integrates a **lightweight ML model** into the power controller to predict idle blocks and gate their supply dynamically — reducing leakage without performance loss.

##  Objectives
- Develop a **runtime activity monitor** for SoC blocks (CPU, memory, accelerators).  
- Use **machine learning prediction** to classify blocks as *active*, *likely idle*, or *idle*.  
- Implement a **dynamic power-gating controller** to control sleep transistors.  
- Validate design through **RTL simulation** and power analysis.  


##  Features
- Real-time SoC block activity monitoring  
- ML-powered idle state prediction (Decision Tree, TinyML models)  
- Power-gating controller with safe wake-up transitions  
- Achieves **15–20% leakage power reduction** in idle mode  
- Scalable for **multi-core, multi-block SoC architectures**  


##  System Components
- **Activity Monitor Module** – Tracks SoC block runtime stats  
- **ML Prediction Unit** – Predicts idleness using lightweight classifiers  
- **Power-Gating Control Unit** – Drives sleep transistors safely  
- **Sleep Transistors** – Circuit-level isolation of idle blocks  
- **Testbench & Benchmarks** – MiBench, CoreMark workloads  
- **Reporting Module** – Leakage savings, prediction accuracy, performance metrics  


##  Tools & Technologies
- **HDL Design**: Verilog / SystemVerilog  
- **Simulation**: Xilinx Vivado  
- **Synthesis**: Vivado Synthesis  
- **Power Analysis**: Vivado Power Estimator   
- **ML Development**: Python   

