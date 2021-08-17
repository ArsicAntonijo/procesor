/****************************************************************************
 * alu.sv
 ****************************************************************************/

/**
 * Module: alu
 * 
 * TODO: Add module documentation
 */
module alu #(parameter WIDTH = 8)
		(input logic [WIDTH-1:0] 	a, b,
		input logic  [2:0] 			alucontrol,
		input logic clk,
		output  [WIDTH-1:0] 	result,
		output cout);
	
	wire [WIDTH-1:0] b2, andresult, orresult, xorresult, notresult, 
		addresult, subresult, incresult, decresult, rs;
	
	andN 	andblock(a, b, andresult);
	orN 	orblock(a, b, orresult);
	xorN	xorblock(a, b, xorresult);
	inv		invblock(a, notresult);
	adder 	addblock(a, b, 1'b0, addresult, cout);
	sub		subblock(a, b, 1'b0, subresult);
	dec		decblock(a, b, 1'b0, decresult);
	inc		incblock(a, b, 1'b0, incresult);
	
	mux8 resultmux(andresult, orresult, xorresult, notresult, 
			addresult, subresult, decresult, incresult,
			alucontrol[2:0], rs);

	flop f1(clk, rs, result);
	
endmodule


