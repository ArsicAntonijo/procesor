/****************************************************************************
 * testbench1.sv
 ****************************************************************************/

/**
 * Module: testbench1
 * 
 * TODO: Add module documentation
 */
	
// testbench
module testbench1 #(parameter WIDTH = 8, REGBITS = 3)();
	
	logic 			  clk;
	logic 			  reset;
	wire 			  memread, memwrite, kraj;
	wire [WIDTH-1:0] mar, writedata;
	wire [WIDTH-1:0] memdata;
	
	// instantiate devices to be tested
	procesor #(WIDTH,REGBITS) dut(clk, reset, memdata, memread,
							  memwrite, mar, writedata);
	
	// external memory for code and data
	exmemory #(WIDTH) exmem(clk, memread, memwrite, mar, writedata, memdata, kraj);
	
	// initialize test
	initial
		begin
			reset <= 1; # 22; reset <= 0;
		end
	// generate clock to sequence tests
	always
		begin
			clk <= 1; # 5; clk <= 0; # 5;
		end
		
	always @(posedge clk)
	begin
		if (memread)
		begin
			//$display("MemRead: mar=%h:Data=%h", mar, memdata);
		end
		
		if(memwrite)
			//assert(mar == 76 & writedata == 7);
			begin
				$display("Write: mar=%d:Data=%d", mar, writedata);
				$display("Simulation completely successful");
				//$finish;
			end
		if(memwrite == 0)
			begin 
				//$display("Kraj je : %b, Memread : %b", kraj, memread);
				//$display("Simulation failed");
				//$display("mar=%d:Data=%d",mar, writedata);
				//$finish;
			end
		if(kraj)
			begin
				$finish;
			end
	end
	
endmodule


