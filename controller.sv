/****************************************************************************
 * controller.sv
 ****************************************************************************/

/**
 * Module: controller
 * 
 * TODO: Add module documentation
 */
module controller(input logic 		 clk, reset,
				  input logic [5:0]  op, 
				  input logic [2:0] funct,
				  input logic 		 zero,
				  output  		 memread, memwrite, wrCPU,
				  output  		 memtoreg, iord, bckAB, ldSP, pcen,
				  output  		 regwrite, regdst, ldAB, ldBB,
				  output   [1:0] adrend, adrsrc, pcsrc, alusrca, alusrcb, stekSRC, srcmdr,
				  output   [2:0] shiftsrc, alucontrol,
				  output   [3:0] irwrite);
	
	wire [5:0] state;
	wire pcwrite;
	wire [1:0] aluop, branch;
	
	// control FSM
	statelogic statelog(clk, reset, op, funct, zero, state);
	
	outputlogic outputlog(state, memread, memwrite,
			memtoreg, iord, bckAB, ldSP,
			regwrite, regdst, ldAB, ldBB, adrend, adrsrc, pcsrc, alusrca, alusrcb, stekSRC, srcmdr, irwrite,
			pcwrite, wrCPU, aluop, branch, shiftsrc);
	
	// other control decoding
	aludec ac(aluop, op, alucontrol);
			
	// program counter enable
	assign pcen = pcwrite | (branch[0] & zero) | (branch[1] & (zero == 0));
	
endmodule



