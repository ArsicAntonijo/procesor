/****************************************************************************
 * outputlogic.sv
 ****************************************************************************/

/**
 * Module: outputlogic
 * 
 * TODO: Add module documentation
 */
module outputlogic(input logic [5:0] state,
				   output logic 		memread, memwrite,
				   output logic			memtoreg, iord, bckAB, ldSP,
				   output logic 		regwrite, regdst, ldAB, ldBB,
				   output logic [1:0] 	adrend, adrsrc, pcsrc, alusrca, alusrcb, stekSRC, srcmdr,
				   output logic [3:0] 	irwrite,
				   output logic 		pcwrite, wrCPU,
				   output logic [1:0] 	aluop, branch,
				   output logic [2:0] shiftsrc);
	always @(state)
	begin
		// set all outputs to zero, then
		// conditionally assert just the appropriate ones
		irwrite = 4'b0000;
		pcwrite = 0; branch = 0;
		regwrite = 0; regdst = 0;
		memread = 0; memwrite = 0;
		alusrca = 2'b00; alusrcb = 2'b00; aluop = 2'b00;
		pcsrc = 2'b00;
		iord = 0; memtoreg = 0;
		adrsrc = 2'b00; adrend = 2'b00;
		ldAB = 0; ldBB = 0;
		shiftsrc = 3'b000;
		bckAB = 0;
		stekSRC = 2'b00;
		wrCPU = 0; srcmdr = 2'b00;
		ldSP = 0;
		case (state)
			6'd0:
			begin
				ldSP = 1;
			end
			6'd1:
			begin			
				memread = 1;
				irwrite = 4'b1000;
				alusrcb = 2'b01;
			end
			6'd2:
			begin
				memread = 1;
				irwrite = 4'b0100;
				alusrcb = 2'b01;
				//adrend = 2'b01;
			end
			6'd3:
			begin
				memread = 1;
				irwrite = 4'b0010;
				alusrcb = 2'b01;
				//adrend = 2'b10;
			end
			6'd4:
			begin
				memread = 1;
				irwrite = 4'b1000;
				alusrcb = 2'b01;
				//adrend = 2'b11;
			end
			6'd5:
			begin
				/*  */
			end
			6'd6:
			begin		
				/*  */
				bckAB = 1;
			end
			6'd7:
			begin
				/* ucitava se operand u akumulator BB */
				alusrcb = 2'b11;
				ldBB = 1;		
				ldAB = 1;
			end
			6'd8:
			begin
				/* ucitava se operand u BB akumulator 
				i pokrece se alu operacija */
				alusrcb = 2'b11;
				ldBB = 1;
			end			
			6'd9:
			begin
				/* registersko direktno adresiranje*/
				ldBB = 1;
			end
			6'd10:
			begin
				/* memdir */
				adrsrc = 2'b01;
				memread = 1;
			end
			6'd11:
			begin
				/* memdir 2 */
				alusrcb = 2'b01;
				ldBB = 1;
			end
			6'd12:
			begin
				/* PC rel */
				alusrcb = 2'b10;
				ldBB = 1;
				ldAB = 1;
			end
			6'd13:
			begin
				/* PC rel 2 */
				alusrcb = 2'b11;
				ldBB = 1;
				aluop = 2'b01;
			end
			6'd14:
			begin
				/* PC rel 3 */
				alusrca = 2'b01;
				ldAB = 1;
			end
			6'd15:
			begin
				/* PC rel 4 */
				adrsrc = 2'b10;
				memread = 1;
			end
			6'd16:
			begin
				/* PC rel 5 */
				alusrcb = 2'b01;
				ldBB = 1;
				alusrca = 2'b11;
				ldAB = 1;
			end
			6'd17:
			begin
				/* ASR */
				shiftsrc = 3'b001;
			end
			6'd18:
			begin
				/* LSR */
				shiftsrc = 3'b010;
			end
			6'd19:
			begin
				/* ASL */
				shiftsrc = 3'b011;
			end
			6'd20:
			begin
				/* LSL */
				shiftsrc = 3'b100;
			end
			6'd21:
			begin
				/* JMP */
				pcsrc = 2'b10;
				pcwrite = 1;
			end
			6'd22:
			begin
				/* jump if zero */
				pcsrc = 2'b10;
				branch = 2'b01;
			end
			6'd23:
			begin
				/* jump if not zero */
				pcsrc = 2'b10;
				branch = 2'b10;
			end
			6'd24:
			begin
				/* POP */
				/*stekSRC = 2'b10;
				alusrca = 2'b11;
				ldAB = 1;*/

				stekSRC = 2'b01;
				ldSP = 1;
				
				adrsrc = 2'b11;
				memread = 1;
			end
			6'd25:
			begin
				/* PUSH */
				//stekSRC = 2'b01;
				adrsrc = 2'b11;
				srcmdr = 2'b01;
				wrCPU = 1;
				memwrite = 1;
			end
			6'd26:
			begin
				/* POP part 2*/
				alusrcb = 2'b01;
				ldBB = 1;
				ldAB = 1;

			end
			6'd27:
			begin
				/* PUSH part 2 */
				stekSRC = 2'b10;
				ldSP = 1;
			end
			
			6'd28:
			begin
				/* upisivanje u registarksi fajl */
				regwrite = 1;
			end
			6'd29:
			begin
				/* upis shiftovane vrednosti u acumulator AB */
				alusrca = 2'b10;
				ldAB = 1;
			end
			6'd30:
			begin
				/* loading result from alu in AB acumulator */
				alusrca = 2'b01;
				ldAB = 1;
			end
			6'd31:
			begin
				/* kraj programa */
				//kraj = 1;
			end
			6'd32:
			begin
				/* inkrement pc brojac */
				/*pcsrc = 2'b01;
				pcwrite = 1;		*/		
			end
			6'd35:
			begin
				/* inkrement pc brojac */
				pcsrc = 2'b01;
				pcwrite = 1;				
			end
			6'd36:
			begin
				/* inkrement pc brojac */
				pcsrc = 2'b01;
				pcwrite = 1;				
			end
			6'd37:
			begin
				/* inkrement pc brojac */
				pcsrc = 2'b01;
				pcwrite = 1;				
			end
		endcase
	end
endmodule
			
