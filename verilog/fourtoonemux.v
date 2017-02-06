`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:02:31 02/06/2017 
// Design Name: 
// Module Name:    fourtoonemux 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fourtoonemux( select , d , q);
	input [1:0] select;
	input [3:0] d;
	output q;
	wire q;
	wire [1:0] select;
	wire [3:0] d;
	
	assign q = d [select];

endmodule
