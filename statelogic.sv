/****************************************************************************
 * statelogic.sv
 ****************************************************************************/

/**
 * Module: statelogic
 * 
 * TODO: Add module documentation
 */
module statelogic(input logic 		clk, reset,
				  input logic [5:0] op,
				  input logic [2:0] funct,
				  input logic zero,
				  output logic [5:0] state);
	
	logic [5:0] nextstate;

	logic [5:0] JMP = 6'b001_001;
	logic [5:0] BEQL = 6'b010_000;
	logic [5:0] BNEQL = 6'b010_001;
	logic [5:0] LOAD = 6'b100_000;
	logic [5:0] REGLOAD = 6'b100_001;
	logic [5:0] POP = 6'b100_100;
	logic [5:0] PUSH = 6'b100_110;
	logic [5:0] ADD = 6'b110_000;
	logic [5:0] SUB = 6'b110_001;
	logic [5:0] INC = 6'b110_010;
	logic [5:0] DEC = 6'b110_011;
	logic [5:0] AND = 6'b110_100;
	logic [5:0] OR = 6'b110_101;
	logic [5:0] XOR = 6'b110_110;
	logic [5:0] NOT = 6'b110_111;
	logic [5:0] ASR = 6'b111_000;
	logic [5:0] LSR = 6'b111_001;
	logic [5:0] ASL = 6'b111_100;
	logic [5:0] LSL = 6'b111_101;
	logic [5:0] STOP = 6'b111_111;

	logic [2:0] REGDIR = 3'b000;
	logic [2:0] MEMDIR = 3'b010;
	logic [2:0] PCREL = 3'b110;
	logic [2:0] IMMED = 3'b111;

	always @(posedge clk)
		if (reset) begin 
			state <= 6'd0;
			$display("State = FETCH1r");
		end
		else begin 
			state <= nextstate;
			case(state)
				6'd0: $display("setting SP");
				6'd1: $display("NEW STATE = FETCH1");
				6'd2: $display("NEW STATE = FETCH2");
				6'd3: $display("NEW STATE = FETCH3");
				6'd4: $display("NEW STATE = FETCH4");
				6'd5: $display("NEW STATE = DEKODIRANJE OPERACIJE");
				6'd6: $display("NEW STATE = DEKODIRANJE ADRESE");
				6'd7: $display("NEW STATE = LOAD");
				6'd8: $display("NEW STATE = IMMED");
				6'd9: $display("NEW STATE = REGDIR");
				6'd10: $display("NEW STATE = MEMDIR");
				6'd12: $display("NEW STATE = PC REL");
				6'd17: $display("NEW STATE = ASR");
				6'd18: $display("NEW STATE = LSR");
				6'd19: $display("NEW STATE = ASL");
				6'd20: $display("NEW STATE = LSL");
				6'd21: $display("NEW STATE = JMP");
				6'd22: $display("NEW STATE = JMP IF ZERO");
				6'd23: $display("NEW STATE = JMP IF NOT ZERO");
				6'd24: $display("NEW STATE = POP");
				6'd25: $display("NEW STATE = PUSH");
				6'd31: $display("NEW STATE = END OF PROGRAM");
				//default: $display("NEW STATE = UNKNOWN");
			endcase
		end
	
	always @(posedge clk)
	  begin
		case (state)
			6'd0: nextstate = 6'd1; 
			/*----- FETCH1------ */
			6'd1: nextstate = 6'd35;				
			/*----- FETCH2------ */
			6'd2: nextstate = 6'd36;
			/*----- FETCH3------ */
			6'd3: nextstate = 6'd37;
			/*----- FETCH4------ */
			6'd4: nextstate = 6'd5;
			6'd5: 
			begin	
				/* dekodiranje funkcije izvrsavanja*/
				case(op)
					6'b000_000: nextstate = 6'd28;
					JMP: nextstate = 6'd21;
					BEQL: 
					begin
						/* jump if zero */
						case(zero)
							1'b0: nextstate = 6'd32;
							1'b1: nextstate = 6'd22;
						endcase
					end
					BNEQL:	
					begin
						/* jump if not zero */
						case(zero)
							1'b0: nextstate = 6'd23;
							1'b1: nextstate = 6'd32;
						endcase
					end	
					LOAD: nextstate = 6'd7;
					REGLOAD: nextstate = 6'd28;
					POP: nextstate = 6'd24;
					PUSH: nextstate = 6'd25;
					ADD: nextstate = 6'd6;
					SUB: nextstate = 6'd6;
					INC: nextstate = 6'd6;
					DEC: nextstate = 6'd6;
					AND: nextstate = 6'd6;
					OR: nextstate = 6'd6;
					XOR: nextstate = 6'd6;
					NOT: nextstate = 6'd6;
					ASR: nextstate = 6'd17;
					LSR: nextstate = 6'd18;
					ASL: nextstate = 6'd19;
					LSL: nextstate = 6'd20;
					STOP: nextstate = 6'd31;
					default: nextstate = 6'd32;
				endcase
			end
			6'd6:
			begin
				/* dekodiranje nacina adresiranja */
				case(funct)
					REGDIR: nextstate = 6'd9;
					MEMDIR: nextstate = 6'd10;
					PCREL: nextstate = 6'd12;
					IMMED: nextstate = 6'd8;
					default: nextstate = 6'd8;
				endcase
			end
			6'd7: 
			begin
				/* LOAD */
				nextstate = 6'd32;
			end
			6'd8: 
			begin
				/* ucitaj operand i racinaj (immed adresiranje) */
				nextstate = 6'd30;
			end
			6'd9:
			begin
				/* registersko direktno adresiranje*/
				nextstate = 6'd30;
			end
			6'd10:
			begin
				/* memdir */
				nextstate = 6'd11;
			end
			6'd11:
			begin
			 	/* memdir 2 */
				nextstate = 6'd30;
			end
			6'd12: 
			begin
				/* PC rel */
				nextstate = 6'd13;
			end
			6'd13:
			begin
				/* PC rel 2 */
				nextstate = 6'd14;
			end
			6'd14:
			begin
				/* PC rel 3 */
				nextstate = 6'd15;
			end
			6'd15:
			begin
				/* PC rel 4 */
				nextstate = 6'd16;
			end
			6'd16:
			begin
				/* PC rel 5 */
				nextstate = 6'd30;
			end
			6'd17:
			begin
				/* ASR */
				nextstate = 6'd29;
			end
			6'd18:
			begin
				/* LSR */
				nextstate = 6'd29;
			end
			6'd19:
			begin
				/* ASL */
				nextstate = 6'd29;
			end
			6'd20:
			begin
				/* LSL */
				nextstate = 6'd29;
			end
			6'd21:
			begin
				/* JMP */
				nextstate = 6'd1;
			end
			6'd22:
			begin
				/* JMP if zero */
				nextstate = 6'd1;
			end
			6'd23:
			begin
				/* JMP if not zero*/
				nextstate = 6'd1;
			end
			6'd24:
			begin
				/* POP */
				nextstate = 6'd26;
			end
			6'd25:
			begin
				/* PUSH */
				nextstate = 6'd27;
			end
			6'd26:
			begin
				/* POP 2 */
				nextstate = 6'd32;
			end
			6'd27:
			begin
				/* PUSH 2 */
				nextstate = 6'd32;
			end
			6'd28: nextstate = 6'd32;
			6'd29: nextstate = 6'd32;
			6'd30: nextstate = 6'd32;
			6'd31: nextstate = 6'd1;
			6'd32: 
			begin
				/* inkrement pc brojaca */
				nextstate = 6'd1;
			end
			6'd35:
			begin
				//nextstate = 6'd2; 
				case(op)
					POP: nextstate = 6'd5;
					PUSH: nextstate = 6'd5;
					default: nextstate = 6'd2;
				endcase
			end
			6'd36:
				case(op)
					JMP: nextstate = 6'd5;
					BEQL: nextstate = 6'd5;
					BNEQL: nextstate = 6'd5;
					LOAD: nextstate = 6'd3;
					default: 
						begin 
							case(funct)
								REGDIR: nextstate = 6'd5;
								default: nextstate = 6'd3;
							endcase
						end
				endcase
			6'd37: nextstate = 6'd5;
			default: nextstate = 6'd1;
				// should never happen
		endcase
	  end
		
endmodule

