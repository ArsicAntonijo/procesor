/****************************************************************************
 * exmemory.sv
 ****************************************************************************/

/**
 * Module: exmemory
 * 
 * TODO: Add module documentation
 */
// external memory accessed by procesor
module exmemory #(parameter WIDTH = 8)
				 (input logic 			   clk,
				  input logic 			   memread,
				  input logic 			   memwrite,
				  input logic  [WIDTH-1:0] mar, writedata,
				  output logic [WIDTH-1:0] memdata,
				  output logic kraj);
	
	logic [31:0] 	  mem [2**(WIDTH-2)-1:0];
	wire [31:0] 	  word;
	initial
	begin 
		kraj = 0;
		$readmemh("memfile.dat", mem);
		$display("%h", mem[1]);
	end
	
	
	// read and write bytes from 32-bit word
	always @(posedge clk)
	begin
		if(memwrite)
			case (mar[1:0])
				2'b00: mem[mar[WIDTH-1:2]][31:24] <= writedata;
				2'b01: mem[mar[WIDTH-1:2]][23:16] <= writedata;
				2'b10: mem[mar[WIDTH-1:2]][15:8] <= writedata;
				2'b11: mem[mar[WIDTH-1:2]][7:0] <= writedata;
			endcase
	end
	assign word = mem[mar[WIDTH-1:2]];
	always @(posedge clk)
	begin
		if (memread)
			begin 
				case (mar[1:0])
				2'b00: memdata = word[31:24];
				2'b01: memdata = word[23:16];
				2'b10: memdata = word[15:8]; 
				2'b11: memdata = word[7:0];
				
				endcase
				$display("MemRead: mar= %h, ByteSel=%h, MemData=%h", mar[WIDTH-1:2], mar[1:0], memdata);		
			end	
		if(word[31:0] == 32'hffffffff)
		begin
			kraj = 1;
		end
	end
		
endmodule


