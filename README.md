# FPGA Design Project with LLMs at CERN South Africa

## Introduction

In this project under the auspices of a paid internship at CERN South Africa, we explored the application of Artificial Intelligence (AI) tools, specifically large language models like ChatGPT, in the realm of Field Programmable Gate Array (FPGA) design and integration. The task was to create a Hardware Description Language (HDL) code that can process a serial data stream of 64-bit data points, identify erroneous zero data points, and replace them with the average of the neighbouring points.

# How to Use and Run the Project

This project was designed and tested on an Ubuntu WSL environment and requires the installation of `iverilog`. 

## Installation

You need to install `iverilog` in your system. If you're using Ubuntu or any other Debian-based distribution, you can do so by running the following command:

```sudo apt-get update && sudo apt-get install iverilog```

## Running the Project

After the installation of `iverilog`, you can run the project easily. Each of the folders containing Method 1 and Method 2 has a makefile. You can use these makefiles to compile and run the project. 

Navigate to the directory of the method you want to execute using the `cd` command:

```cd 'Method 2 (Final)```

Then, simply run `make` from the respective directory:

This will compile and execute the code for the respective method. The program should start running, and you will see the output in the terminal.


## Methodologies

### Method 1: Entire System Designed by LLM

In the first approach, we utilized ChatGPT to design the entire system in one go. The program generated by the AI was only accurate within a specific use case, showing a lack of versatility required for a fully functioning system.

### Method 2: LLM Assists with Syntax and Code Chunks

The second approach involved making high-level design decisions while using ChatGPT to generate specific code chunks. This approach yielded a more reliable and versatile system. The iterative process of development, testing, correction, and investigation resulted in a successful system implementation.

## Design Strategy and Implementation

Given the limitations observed in Method 1, we introduced a design strategy that involved using a buffer to store incoming data, which was then processed and output after a predefined number of clock cycles. This approach mitigated the risk of data loss due to premature input of new data.

The task was broken down into manageable code chunks, each assigned to ChatGPT for development. The outputs were rigorously tested, with any necessary corrections made based on the testing results. 

## Results

Our design process concluded with a successful implementation, corroborated by a diverse and comprehensive test case framework. A significant part of the success was the judicious assumptions made throughout the project.

The final system offers flexibility to adjust to different input quantities or contexts. The code includes commented lines for displaying buffers, intermediate steps, and outputs for debugging or tuning.

The output log depicts a system that processes 64-bit inputs and generates 8-bit outputs. It averages new input with prior non-zero data and shifts this through a buffer.

The output is in little endian format, meaning least significant byte first. For instance, the 'Input 5' value '0x6739293791021284' is output as '0x84', '0x12', '0x02', '0x91', '0x37', '0x29', '0x39', '0x67'. The least significant byte '0x84' appears first, signifying little endian output.

## Conclusion

The project successfully designed and implemented a data processing system. The system effectively processed data, managed varying input volumes, and complied with little endian format. This project underscored the valuable role of Language Learning Models (LLMs) in system design, serving as a tool for contextualizing the design process, interpreting results, and drawing concise conclusions.
