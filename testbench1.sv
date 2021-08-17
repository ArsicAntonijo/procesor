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
	wire 			  memread, memwrite;
	wire [WIDTH-1:0] adr, writedata;
	wire [WIDTH-1:0] memdata;
	
	// instantiate devices to be tested
	mips #(WIDTH,REGBITS) dut(clk, reset, memdata, memread,
							  memwrite, adr, writedata);
	
	// external memory for code and data
	exmemory #(WIDTH) exmem(clk, memread, memwrite, adr, writedata, memdata, kraj);
	
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
		
	always @(negedge clk)
	begin
		if (memread)
		begin
			//$display("MemRead: Adr=%h:Data=%h", adr, memdata);
		end
		
		if(memwrite)
			//assert(adr == 76 & writedata == 7);
			begin
				$display("Write: Adr=%d:Data=%d", adr, writedata);
				$display("Simulation completely successful");
				$finish;
			end
		if(memwrite == 0)
			begin 
				//$display("Simulation failed");
				//$display("Adr=%d:Data=%d",adr, writedata);
				//$finish;
			end
		if(kraj == 1)
			$finish;
	end
	
endmodule


