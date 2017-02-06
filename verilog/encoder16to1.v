`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:14:15 02/06/2017 
// Design Name: 
// Module Name:    encoder16to1 
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
module encoder16to1( encoder_in, encoder_out, enable);
	output [3:0] encoder_out;
	input enable;
	input [15:0] encoder_in;
	reg [3:0] encoder_out;
	
	always @ (enable or encoder_in)
	
	begin
		encoder_out = 0;
		if(enable) begin
			if( encoder_in == 16'h0002) begin
				encoder_out = 1;
			end if ( encoder_in == 16'h0004) begin
				encoder_out = 2;
			end if ( encoder_in == 16'h0008) begin
				encoder_out = 3;
			end if ( encoder_in == 16'h0010) begin
				encoder_out = 4;
			end if ( encoder_in == 16'h0020) begin
				encoder_out = 5;
			end if ( encoder_in == 16'h0040) begin
				encoder_out = 6;
			end if ( encoder_in == 16'h0080) begin
				encoder_out = 7;
			end if ( encoder_in == 16'h0100) begin
				encoder_out = 8;
			end if ( encoder_in == 16'h0200) begin
				encoder_out = 9;
			end if ( encoder_in == 16'h0400) begin
				encoder_out = 10;
			end if ( encoder_in == 16'h0800) begin
				encoder_out = 11;
			end if ( encoder_in == 16'h1000) begin
				encoder_out = 12;
			end if ( encoder_in == 16'h2000) begin
				encoder_out = 13;
			end if ( encoder_in == 16'h4000) begin
				encoder_out = 14;
			end if ( encoder_in == 16'h8000) begin
				encoder_out = 15;
			end
		end
	end
		
				
				
endmodule
