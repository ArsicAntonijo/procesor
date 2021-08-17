/****************************************************************************
 * aludec.sv
 ****************************************************************************/

/**
 * Module: aludec
 * 
 * TODO: Add module documentation
 */
module aludec(input logic  [1:0] aluop,
			  input logic  [5:0] funct,
			  output logic [2:0] alucontrol);
	
	always @(*)
		begin
			case(aluop)
				2'b00:
				begin
					case(funct) // R-Type instructions
						6'b110_000: alucontrol = 3'b100;
						6'b110_001: alucontrol = 3'b101;
						6'b110_010: alucontrol = 3'b111;
						6'b110_011: alucontrol = 3'b110;
						6'b110_100: alucontrol = 3'b000;
						6'b110_101: alucontrol = 3'b001;
						6'b110_110: alucontrol = 3'b010;
						6'b110_111: alucontrol = 3'b011;
						default: alucontrol = 3'b101;
							// should never happen
					endcase
				end
				2'b01: alucontrol = 3'b100;
			endcase
		end
endmodule


