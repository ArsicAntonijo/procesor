/****************************************************************************
 * mips.sv
 ****************************************************************************/

/**
 * Module: mips
 * 
 * TODO: Add module documentation
 */
// simplified MIPS processor

// states and instructions
/*
typedef enum logic [3:0]
	{FETCH1 = 4'b0000, FETCH2, FETCH3, FETCH4,
	DECODE, MEMADR, LBRD, LBWR, SBWR,
	RTYPEEX, RTYPEWR, BEQEX, JEX} statetype;
	
typedef enum logic [5:0] {LB = 6'b100000,
	SB = 6'b101000,
	RTYPE = 6'b000000,
	BEQ = 6'b000100,
	J = 6'b000010} opcode;
	
typedef enum logic [5:0] {
	JMP = 6'b001_001,
	BEQL = 6'b010_000,
	BNEQL = 6'b010_001,
	LDB = 6'b100_000,
	ADD = 6'b110_000} functcode;

typedef enum logic [2:0] {
	REGDIR = 3'b000,
	MEMDIR = 3'b010,
	PCDIR =  3'b110,
	IMMED =  3'b111} adrcode;*/

module mips #(parameter WIDTH = 8, REGBITS = 3)
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


