# Procesor
In this repository there is a project with represents a simpified procesor written in verilog language.
This project contains following files:
- testbench.sv
- exmemory.sv
- procesor.sv
- controller.sv
- datapath.sv
- statelogic.sv
- outputlogic.sv
- aludec.sv
- logic_components.v
- regfile.sv
- alu.sv
- memfile.dat
- start.bat

## Running project
To run the project you have to double click start.bat.

NOTE: to run the project if yuo don't have installed icarius verilog you will have to install it. You can download it  [here](http://bleyer.org/icarus/).

## Supported operations
In this project, only operations for 8 bit values are supported. The supported operation are shown in picture below.

![This is an image.](https://github.com/ArsicAntonijo/procesor/blob/main/photos/supportedOperations.png)

## Supported addressing 
In this project supported types of addresing are:
- register direct
- memory direct
- PC relativеly
- immed

### Explanation of logic in files

1. testbench.sv

This file represent the top module, in which the clock is started and the procesor and exmemory modules are implemented.

2. exmemory.sv

This file is used for writting and reading data from memory( in this case from memfile.dat).

3. procesor.sv

This file is module which represents the procesor. In this module controller and datapath are implemented.

4. logic_components.v

This is file where the basic logic gates and structures are created.

5. datapath.sv, statelogic.sv, outputlogic.sv

With the code of these files, the main flow of this project will be presented.