`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:29:25 02/12/2017 
// Design Name: 
// Module Name:    MIPS 
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
module MIPS(
    );


endmodule

// 4to1 multiplexer  used for mux6, mux1, mux2, mux8, mux9;
module mux4to1( input [31:0] outR0, input [31:0] outR1, input [31:0] outR2, input [31:0] outR3, input [1:0] Sel, output reg [31:0] outBus );

always@(outR0,outR1,outR2,outR3,outR4,Sel)
	case(Sel)
		2'd0:
			outBus=outR0;
		2'd1:
			outBus=outR1;
		2'd2:
			outBus=outR2;
		2'd3:
			outBus=outR3;
		//2'd4:outBus=outR4;
	endcase
endmodule

// 2to1 mux used for mux5, mux7, mux3
module mux2to1( input [31:0] outR0, input [31:0] outR1, input Sel, output reg [31:0] outBus );

always@(outR0,outR1,outR2,outR3,outR4,Sel)
	case(Sel)
		1'd0:
			outBus=outR0;
		1'd1:
			outBus=outR1;
		
	endcase
endmodule

// 8to1 mux used for mux4
module mux8to1( input [31:0] outR0, input [31:0] outR1, input [31:0] outR2, input [31:0] outR3, input [31:0] outR4, input [31:0] outR5, 
input [31:0] outR6, input [31:0] outR7, input [2:0] Sel, output reg [31:0] outBus );

always@(outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,Sel)
	case(Sel)
		3'd0:outBus=outR0;
		3'd1:outBus=outR1;
		3'd2:outBus=outR2;
		3'd3:outBus=outR3;
		3'd4:outBus=outR4;
		3'd5:outBus=outR5;
		3'd6:outBus=outR6;
		3'd7:outBus=outR7;
	endcase
endmodule

// 32bit adder used for adder1 and adder2
module Adder32Bit(input1, input2, out);
  
  input [31:0] input1, input2;
  output [31:0] out;
  reg [31:0]out;
  
      always@(input1 or input2)
        begin
          
          out = input1 + input2;
          
        end
    
endmodule

// 64bit adder cum subtractor used for adding 64 bit (ALU.ALU) bit adder output and 64 bit (HI.LO) outputs
module AdderSubtractor64Bit(input1, input2, out, operation);
  
  input [63:0] input1, input2;
  output [63:0] out;
  reg [63:0]out;
  
     always@(input1 or input2)
       if (operation == 1'b1)
			begin
				out = input1 + input2;
			end
		else
			begin
				out = input1 - output1;
			end
endmodule

// sign extension 5 to 32 bit
module signExt16to32( input [15:0] offset, output reg [31:0] signExtOffset);
	always@(offset)
			signExtOffset={{26{offset[15]}},offset[15:0]};
endmodule
// sign extension 8 to 32 bit
module signExt8to32( input [7:0] offset, output reg [31:0] signExtOffset);
	always@(offset)
			signExtOffset={{24{offset[7]}},offset[7:0]};
endmodule

// Zero extension 16 to 32 bit
module zeroExt16to32( input [15:0] offset, output reg [31:0] zeroExtOffset);
	always@(offset)
		zeroExtOffset={{16{1'b0}},offset[15:0]};
endmodule

// Zero extension 5 to 32 bit
module zeroExt5to32( input [4:0] offset, output reg [32:0] zeroExtOffset);
	always@(offset)
		zeroExtOffset={{27{1'b0}},offset[4:0]};
endmodule

// Zero extension 8 to 32 bit
module zeroExt8to32( input [7:0] offset, output reg [32:0] zeroExtOffset);
	always@(offset)
		zeroExtOffset={{27{1'b0}},offset[7:0]};
endmodule

