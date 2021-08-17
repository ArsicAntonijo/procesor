/****************************************************************************
 * exmemory.sv
 ****************************************************************************/

/**
 * Module: exmemory
 * 
 * TODO: Add module documentation
 */
// external memory accessed by MIPS
module exmemory #(parameter WIDTH = 8)
				 (input logic 			   clk,
				  input logic 			   memread,
				  input logic 			   memwrite,
				  input logic  [WIDTH-1:0] adr, writedata,
				  output logic [WIDTH-1:0] memdata,
				  output logic kraj);
	
	logic [31:0] 	  mem [2**(WIDTH-2)-1:0];
	wire [31:0] 	  word;
	
	initial
	begin 
		$readmemh("memfile.dat", mem);
		$display("%h", mem[1]);
	end
	
	
	// read and write bytes from 32-bit word
	always @(posedge clk)
	begin
		if(memwrite)
			case (adr[1:0])
				2'b00: mem[adr[WIDTH-1:2]][7:0] <= writedata;
				2'b01: mem[adr[WIDTH-1:2]][15:8] <= writedata;
				2'b10: mem[adr[WIDTH-1:2]][23:16] <= writedata;
				2'b11: mem[adr[WIDTH-1:2]][31:24] <= writedata;
			endcase
	end
	assign word = mem[adr[WIDTH-1:2]];
	always @(posedge clk)
	begin
		if (memread)
			begin 
				case (adr[1:0])
				2'b00: memdata = word[7:0];
				2'b01: memdata = word[15:8];
				2'b10: memdata = word[23:16];
				2'b11: memdata = word[31:24];
				
				endcase
				$display("MemRead: Adr= %h, ByteSel=%h, MemData=%h", adr[WIDTH-1:2], adr[1:0], memdata);		
			end	
	end
		
endmodule


