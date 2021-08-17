module hello;

	logic clk;
	logic memread, memwrite;
	logic [2:0] ra1, ra2, wa;
	logic [7:0] adr, writedata;
	wire [7:0] memdata;
	exmemory m(clk, memread, memwrite, adr, writedata, memdata);

	always
		begin
			clk <= 1; # 5; clk <= 0; # 5;
		end

	initial 
	begin
		memread = 1;
        memwrite = 0;
        adr = 8'b0000_0011;
        writedata = 0;        
		
		#20
		$display("izlaz je %h", memdata);

        memread = 0;
        memwrite = 1;
        adr = 8'b0000_0011;
        writedata = 8'h69;

        #20 
        memread = 1;
        memwrite = 0;
        adr = 8'b0000_0011;
        writedata = 8'h69;

        #2
        $display("%h", memdata);
	
	
		$finish ;
	end
    /*
    integer i;
    reg [7:0] memory [0:15]; // 8 bit memory with 16 entries
    reg [31:0] 	  mem [2**(8-2)-1:0];
    initial begin
        for (i=0; i<16; i++) begin
            memory[i] = i;
        end
        //$writememb("memory_binary.dat", memory);
        $readmemh("memfile.dat", mem);
        //$writememh("memory_hex.txt", memory);
        $display("%h", mem[0]);
    end*/
endmodule
