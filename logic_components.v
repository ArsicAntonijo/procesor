/****************************************************************************
 * logic_components.sv
 ****************************************************************************/

/**
 * Module: logic_components
 * 
 * TODO: Add module documentation
 */
module zerodetect #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a,
		output  y);
	assign y = (a==0);
endmodule

module flop #(parameter WIDTH = 8)
		(input logic clk,
		input logic [WIDTH-1:0] d,
		output logic [WIDTH-1:0] q);
	always @(posedge clk)
		q <= d;
endmodule

module flopen #(parameter WIDTH = 8)
		(input logic clk, en,
		input logic [WIDTH-1:0] d,
		output logic [WIDTH-1:0] q);
	always @(posedge clk)
		if (en) q <= d;
endmodule

module flopenr #(parameter WIDTH = 8)
		(input logic clk, reset, en,
		input logic [WIDTH-1:0] d,
		output logic [WIDTH-1:0] q);
	always @(posedge clk)
		if (reset) q <= 0;
		else if (en) q <= d;
endmodule

module mux3 #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] d0, d1, d2,
		input logic [1:0] s,
		output logic [WIDTH-1:0] y);
	always @(*)
		begin
			case(s) 
				2'b00: y = d0;
				2'b01: y = d1;
				2'b1?: y = d2;
			endcase
		end
endmodule


// multiplekser 2 ulaza
module mux2 #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] d0, d1,
		input logic s,
		output  [WIDTH-1:0] y);
	assign y = s ? d1 : d0;
endmodule

// multiplekser 4 ulaza
module mux4 #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] d0, d1, d2, d3,
		input  [1:0] s,
		output  logic [WIDTH-1:0] y);
	always @(*)
	begin
		case (s)
			2'b00: y = d0;
			2'b01: y = d1;
			2'b10: y = d2;
			2'b11: y = d3;
		endcase
	end
endmodule

// multiplekser 8 ulaza
module mux8 #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] d0, d1, d2, d3, d4, d5, d6, d7,
		input logic [2:0] s,
		output logic [WIDTH-1:0] y);
	always @(*)
	 begin
		case (s)
			3'b000: y = d0;
			3'b001: y = d1;
			3'b010: y = d2;
			3'b011: y = d3;
			3'b100: y = d4;
			3'b101: y = d5;
			3'b110: y = d6;
			3'b111: y = d7;			
		endcase
	end
endmodule

// logicko i kolo
module andN #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		output [WIDTH-1:0] y);
	assign y = a & b;
endmodule

// logicko ili kolo
module orN #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		output  [WIDTH-1:0] y);
	assign y = a | b;
endmodule

// logicko xor kolo
module xorN #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		output  [WIDTH-1:0] y);
	assign y = a ^ b;
endmodule

// logicko ne kolo
module inv #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a,
		output  [WIDTH-1:0] y);
	assign y = ~a;
endmodule

// sabiranje
module adder #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		input logic cin,
		output  [WIDTH-1:0] y,
		output cout);
	wire [8:0] tmp;
	assign tmp = a + b + cin;
	assign y = tmp[7:0];
	assign cout = tmp[8];
endmodule

// oduzimanje
module sub #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		input logic cin,
		output  [WIDTH-1:0] y);
	assign y = a - b;
endmodule

// dekrement
module dec #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		input logic cin,
		output  [WIDTH-1:0] y);	
	assign y = a - 1;
endmodule

// inkrement
module inc #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		input logic cin,
		output  [WIDTH-1:0] y);	
	assign y = a + 1;
endmodule

// buffer
module buffer #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] d0,
		input logic s,
		output logic [WIDTH-1:0] y);
	always @(*)
		begin
			if(s)
				y <= d0;
		end
endmodule

// inkrement sa enable
module incen #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		input logic clk,
		output logic [WIDTH-1:0] y);	
	always @(posedge clk)
	begin
		y = a + 1;
	end
endmodule

// dekrement sa enable
module decen #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		input logic clk,
		output logic [WIDTH-1:0] y);	
	always @(posedge clk)
	begin
		y = a - 1;
	end
endmodule

// modul za izvrsavanje pomeracke funkcije
module shift #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a,
		input logic [2:0] con,
		input logic clk,
		output logic [WIDTH-1:0] y);

	logic [WIDTH-1:0] tmp;
	always @(posedge clk)
	begin
		case(con)
			3'b001:
			begin
				y[6:0] = a[7:1];
				y[7] = a[0];
			end
			3'b010:
			begin
				y[6:0] = a[7:1];
				y[7] = 0;
			end
			3'b011:
			begin
				y[7:1] = a[6:0];
				y[0] = a[7];
			end
			3'b100:
			begin
				y[7:1] = a[6:0];
				y[0] = 0;
			end
		endcase
	end
endmodule

