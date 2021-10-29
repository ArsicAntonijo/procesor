iverilog -o des alu.sv aludec.sv controller.sv datapath.sv exmemory.sv logic_components.v procesor.sv outputlogic.sv regfile.sv statelogic.sv testbench1.sv
vvp des
pause