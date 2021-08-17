iverilog -o des alu.sv aludec.sv controller.sv datapath.sv exmemory.sv logic_components.v mips.sv outputlogic.sv regfile.sv statelogic.sv testbench1.sv
vvp des
type redosled.txt
pause