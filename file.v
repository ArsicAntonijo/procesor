// sabiranje
module adderche #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		input logic cin,
		output  [WIDTH-1:0] y);
	assign y = a + b + cin;
endmodule
module suberche #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		input logic cin,
		output  [WIDTH-1:0] y);
	
	assign y = a - 1;
endmodule
// logicko i kolo
module andN #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] a, b,
		output [WIDTH-1:0] y);
	assign y = a & b;
endmodule
// multiplekser 4 ulaza
module mux4 #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] d0, d1, d2, d3,
		input  [1:0] s,
		output  logic [WIDTH-1:0] y);
	always @ (s) begin
		case (s)
			2'b00: y = d0;
			2'b01: y = d1;
			2'b10: y = d2;
			2'b11: y = d3;
		endcase
	end
endmodule