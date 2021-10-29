/****************************************************************************
 * procesor.sv
 ****************************************************************************/

/**
 * Module: procesor
 * 
 * TODO: Add module documentation
 */
// simplified  processor

module procesor #(parameter WIDTH = 8, REGBITS = 3)
			 (input logic 			   clk, reset,
			  input logic [WIDTH-1:0]  memdata,
			  output 			   memread, memwrite,
			  output [WIDTH-1:0] mar, writedata);
	
	wire [31:0] instr;
	wire [1:0]  adrend, adrsrc, pcsrc, alusrca, alusrcb, stekSRC, srcmdr;
	wire [3:0]  irwrite;
	wire [2:0]  shiftsrc, alucontrol;
	wire [5:0]  op;
	wire [2:0] funct;
	wire  regdst, regwrite, pcen, memtoreg, iord, bckAB, zero, ldAB, ldBB, carry, wrCPU, ldSP;
	
	assign op = instr[31:26];
	assign funct = instr[23:21];
	
	controller cont(clk, reset, op, funct, zero, memread, memwrite, wrCPU,
			 memtoreg, iord, bckAB, ldSP, pcen, regwrite, regdst, ldAB, ldBB,
			adrend, adrsrc, pcsrc, alusrca, alusrcb, stekSRC, srcmdr, shiftsrc, alucontrol, irwrite);
	datapath #(WIDTH, REGBITS)
		dp(clk, reset, memdata, memtoreg, iord, bckAB, ldSP, pcen,
			regwrite, regdst, ldAB, ldBB, wrCPU, adrend, adrsrc, pcsrc, alusrca, alusrcb, stekSRC, srcmdr, irwrite, shiftsrc, alucontrol,
			zero, carry, instr, mar, writedata);

endmodule


