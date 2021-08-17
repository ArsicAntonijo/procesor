/****************************************************************************
 * datapath.sv
 ****************************************************************************/

/**
 * Module: datapath
 * 
 * TODO: Add module documentation
 */

module datapath #(parameter WIDTH = 8, REGBITS = 3)
		(input logic 			clk, reset,
		input logic [WIDTH-1:0] memdata,
		input logic 			memtoreg, iord, bckAB, 
		input logic 			pcen, regwrite, regdst, ldAB, ldBB,
		input logic [1:0] 		adrend, adrsrc, pcsrc, alusrca, alusrcb, stekSRC,
		input logic [3:0] 		irwrite,
		input logic [2:0] 		shiftsrc, alucontrol,
		output 			zero, carry,
		output  [31:0] 	instr,
		output  [WIDTH-1:0] adr, writedata);
	
	wire [REGBITS-1:0] ra1, ra2, wa;
	logic [WIDTH-1:0]  data, a, immx4;
	
	wire [WIDTH-1:0] shiftAB, wd, rd1, rd2, mxBB, acumulatorBB, mxAB, acumulatorAB,
		instrValue, incpc, pc, nextpc, aluresult, aluout, backupAB, alterAB, stekVAL;
	
	wire cout;

	logic [WIDTH-1:0] CONST_ZERO = 0;
	logic [WIDTH-1:0] CONST_ONE = 1;
	
	// register file address fields
	assign ra1 = instr[REGBITS+20:21];	
	assign ra2 = instr[20:16];
	
	
	// independent of bit width,
	// load instruction into four 8-bit registers over four cycles
	flopen #(8) ir0(clk, irwrite[0], memdata[7:0], instr[7:0]);
	flopen #(8) ir1(clk, irwrite[1], memdata[7:0], instr[15:8]);
	flopen #(8) ir2(clk, irwrite[2], memdata[7:0], instr[23:16]);
	flopen #(8) ir3(clk, irwrite[3], memdata[7:0], instr[31:24]);
	
	/* preuzimanje vredsnoti iz operanda */
	mux2 mxVALUE(instr[15:8], memdata[7:0], 1'b0, instrValue);

	/* pc counter */
	incen pcCounter(pc, 8'd0, clk, incpc);
	mux4 #(WIDTH) pcmux(8'd0, incpc, instr[23:16], immx4, 
			pcsrc, nextpc);
	flopenr #(WIDTH) pcreg(clk, reset, pcen, nextpc, pc);

	/* formiranje adrese */
	mux4 #(6) mxADR1(pc[5:0], instrValue[7:2], acumulatorAB[7:2], 6'd1, adrsrc, adr[7:2]);
	mux4 #(2) mxADR2(adrend, instrValue[1:0], acumulatorAB[1:0], 2'd1, adrsrc, adr[1:0]);


	/* formiranje operanda AB */
	mux4 #(WIDTH) src1mux(acumulatorBB, aluout, shiftAB, alterAB, alusrca, mxAB);
	buffer b3(mxAB, ldAB, acumulatorAB);
	buffer b7(acumulatorAB, bckAB, backupAB);
	mux2 m21(backupAB, stekVAL, stekSRC[1], alterAB);

	/* formiranje operanda BB */
	mux4 #(WIDTH) src2mux(rd2, memdata[7:0], pc,
			instrValue, alusrcb, mxBB);
	buffer b4(mxBB, ldBB, acumulatorBB);

	/* alu jedinica */
	alu #(WIDTH) alunit(acumulatorAB, acumulatorBB, alucontrol, clk, aluresult, cout);
	flop #(WIDTH) resreg(clk, aluresult, aluout);

	/* registarski fajl */
	buffer b5(instrValue, regwrite, wd);
	buffer #(3) b6(instr[18:16], regwrite, wa);
	regfile #(WIDTH,REGBITS) rf(clk, regwrite, ra1, ra2,
		wa, wd, rd1, rd2);

	/* stek */
	stek s2(acumulatorAB, stekSRC, clk, stekVAL);

	/* modul za shiftanje */
	shift s1(acumulatorAB, shiftsrc, clk, shiftAB);

	/* zero flag aktivacija */
	zerodetect #(WIDTH) zd(acumulatorAB, zero);

	/* carry flag activacija */
	wire ldcarry = ldAB & (alusrca == 2'b01);
	buffer #(1) b23(cout, ldcarry, carry);

	always @(posedge clk)
		begin
			$display("TRENUTNA INSTUKCIJA JE : -> %h <- , PC je: %h, AB je %h , BB je %h, zero flag: %h", instr, pc, acumulatorAB, acumulatorBB, zero);
		end
endmodule

