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

### Example

memfile.dat constains data that procesor is goint to use in this example. The data is put in order that can be seen in the photo below. So when we clik on batch file and start the procesor, we can see in command prompt how the procesor is working and how the operations and states are executed.

![This is an image.](https://github.com/ArsicAntonijo/procesor/blob/main/photos/primer.png)

