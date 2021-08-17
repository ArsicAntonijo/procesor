module hello;

	
	logic [7:0] a;
	logic [7:0] b;
	logic [1:0] c;
	wire [7:0] y;
	logic zero;
	wire z;
	logic clk;

	logic regwrite;
	logic [2:0] ra1, ra2, wa;
	logic [7:0] wd;
	wire [7:0] rd1, rd2;
	wire cout;

	//regfile r(clk, regwrite, ra1, ra2, wa, wd, rd1, rd2);
	adderche aklashd(a,b,1'b0, y, cout);

	//suberche ad(a,b, 1'b0,y);
	//alu alublock(a,b,c, y, zero);
	//andN andblock(a, b, y);
	//mux4 m(b, a, b, b, c, y);
	/*
	logic clk;
	logic regwrite;
	logic [2:0] ra1, ra2, wa;
	logic [7:0] wd;
	wire [7:0] rd1, rd2;*/

	//shift asd(a, c, clk, y);

//	regfile regf(clk, regwrite, ra1, ra2, wa, wd, rd1, rd2);
/*
	always
		begin
			clk <= 1; # 5; clk <= 0; # 5;
		end
*/
//	assign z = c[1] & (zero == 0);
	always
		begin
			clk <= 1; # 5; clk <= 0; # 5;
		end

	initial 
	begin
		regwrite = 1;
		ra1 = 1;
		ra2 = 3;
		wa = 3'd3;
		wd = 8'd7;


		a = 8'hff;
		b = 1;
		
		
		#10
		$display("izlaz je %d, prenos %d", y, cout);
		



		/*
		clk = 0;
		regwrite = 1'b1;
		wa = 3'b000;
		wd = 3;
		ra1 = 1;

		 #1
		 clk = 1;

		 #2
		 clk = 0;
		regwrite = 1'b1;
		wa = 3'b001;
		wd = 4;
		ra1 = 1;
		 #1
		 clk = 1;

		#20
		regwrite = 1'b0;
		wa = 3'b000;
		wd = 3;
		ra1 = 1;
		
		#20
		$display("izlaz je %d", rd1);
	
		#2
		ra1 = 0;

		#20
		$display("izlaz je %d", rd1);
		*/

	/*	a= 4;

		#1
		$display("izalza = %d", y);*/

		$finish;
	end
endmodule
