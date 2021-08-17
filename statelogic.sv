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
	
	always @(posedge clk)
		if (reset) begin 
			state <= 6'd1;
			$display("State = FETCH1r");
		end
		else begin 
			state <= nextstate;
			case(state)
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
				default: $display("NEW STATE = UNKNOWN");
			endcase
		end
	
	always @(posedge clk)
	  begin
		case (state)
			6'd0: nextstate = 6'd1;
			6'd1: nextstate = 6'd2; 
			6'd2: nextstate = 6'd3;
			6'd3: nextstate = 6'd4;
			6'd4: nextstate = 6'd5;
			6'd5: 
			begin	
				/* dekodiranje funkcije izvrsavanja*/
				case(op)
					6'b000_000: nextstate = 6'd28;
					6'b001_001: nextstate = 6'd21;
					6'b010_000: 
					begin
						/* jump if zero */
						case(zero)
							1'b0: nextstate = 6'd32;
							1'b1: nextstate = 6'd22;
						endcase
					end
					6'b010_001:	
					begin
						/* jump if not zero */
						case(zero)
							1'b0: nextstate = 6'd23;
							1'b1: nextstate = 6'd32;
						endcase
					end	
					6'b100_000: nextstate = 6'd7;
					6'b100_001: nextstate = 6'd28;
					6'b100_100: nextstate = 6'd24;
					6'b100_110: nextstate = 6'd25;
					6'b110_000: nextstate = 6'd6;
					6'b110_001: nextstate = 6'd6;
					6'b110_010: nextstate = 6'd6;
					6'b110_011: nextstate = 6'd6;
					6'b110_100: nextstate = 6'd6;
					6'b110_101: nextstate = 6'd6;
					6'b110_110: nextstate = 6'd6;
					6'b110_111: nextstate = 6'd6;
					6'b111_000: nextstate = 6'd17;
					6'b111_001: nextstate = 6'd18;
					6'b111_100: nextstate = 6'd19;
					6'b111_101: nextstate = 6'd20;
					6'b111_111: nextstate = 6'd31;
					default: nextstate = 6'd32;
				endcase
			end
			6'd6:
			begin
				/* dekodiranje adresiranja */
				case(funct)
					3'b000: nextstate = 6'd9;
					3'b010: nextstate = 6'd10;
					3'b110: nextstate = 6'd12;
					3'b111: nextstate = 6'd8;
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
				nextstate = 6'd32;
			end
			6'd25:
			begin
				/* PUSH */
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
			default: nextstate = 6'd1;
				// should never happen
		endcase
	  end
		
endmodule

