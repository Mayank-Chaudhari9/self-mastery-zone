`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: BITS Goa
// Engineer: Mayank Chaudhari
// 
// Create Date:    20:14:20 04/08/2017 
// Design Name: 	 MIPS
// Module Name:    MIPS_MULTICYCLE 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 1.0
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MIPS_MULTICYCLE(
    );


endmodule

// Memory module starts here

module Memory(MemOut, Address, WriteData, MemRD, MemWR, Clock);
	
	output [15:0] MemOut;

	input  [15:0] Address, WriteData;
	input  MemRD, MemWR, Clock;
	
	reg [15:0] Memory [0:256];
	
	initial begin
		Memory[0]  = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[1]  = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[2]  = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[3]  = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[4]  = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[5]  = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[6]  = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[7]  = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[8]  = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[9]  = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[10] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[11] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[12] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[13] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[14] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[15] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[16] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[17] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[18] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[19] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[20] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[21] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[22] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[23] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[24] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[25] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[26] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[27] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[28] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[29] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[30] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[31] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		
		Memory[32] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[33] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[34] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[35] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[36] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[37] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[38] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[39] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[40] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[41] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[42] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[43] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[44] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[45] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[46] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[47] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[48] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[49] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[50] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[51] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[52] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[53] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[54] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[55] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[56] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[57] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[58] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[59] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[60] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[61] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[62] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		Memory[63] = {3'd0, 4'd0, 3'd0, 3'd0, 3'd0};
		
	end

	assign MemOut = MemRD ? Memory[Address] : 0;
	
	
	always @ (negedge Clock) 
		begin
			if(MemWR)
				begin
					Memory[Address] <= WriteData;
				end
		end

endmodule

// Memory module ends here
//----------------------------------------------------

// RegisterFile module start here
//						  << A, 		B,		data_towrite,  rs			rt,		rd,  signal, clock >> 
module RegisterFile( RegOut1, RegOut2, RegDataIn, RegIn1, RegIn2, RegDest, RegWR, Clock);  
		
		output [15:0] RegOut1, RegOut2;
		
		input  [15:0] RegDataIn;
		input  [2:0]  RegIn1, RegIn2, RegDest;
		input  RegWR, Clock;
		
		reg [15:0] RegFile [0:31];
		
		initial begin
			RegFile[0]  = 16'd0;
			RegFile[1]  = 16'd0;
			RegFile[2]  = 16'd0;
			RegFile[3]  = 16'd0;
			RegFile[4]  = 16'd0;
			RegFile[5]  = 16'd0;
			RegFile[6]  = 16'd0;
			RegFile[7]  = 16'd0;
			RegFile[8]  = 16'd0;
			RegFile[9]  = 16'd0;
			RegFile[11] = 16'd0;
			RegFile[12] = 16'd0;
			RegFile[13] = 16'd0;
			RegFile[14] = 16'd0;
			RegFile[15] = 16'd0;
		end
		
		assign RegOut1 = RegFile[RegIn1];  // output1 = registerFile[address 1]
		assign RegOut2 = RegFile[RegIn2]; //  output2 = registerFile[address 2]
		
		always @ (negedge Clock) 
			begin
				if (RegWR)
					begin
						RegFile[RegDest] <= RegDataIn;  // writing to regfile <= Data_to_Write
					end
			end
endmodule

//Register File module ends here
//-------------------------------------------------------------------

// Mux Modules start here

// Mux 2 to 1
module Mux2to1(Output, In0,In1, Select);
	output [15:0] Output;
	
	input [15:0] In0, In1;
	input Select;
	
	reg [15:0] Output;
	
	always @ (In0 or In1 or Select)
		begin
			case(Select)
				0: Output = In0;
				1: Output = In1;
			endcase
		end
endmodule

//Mux 4 to 1

module Mux4to1(Output, In0, In1, In2, In3, Select);
	output [15:0] Output;
	
	input [15:0] In0, In1, In2, In3;
	input [1:0] Select;
	
	reg [15:0] Output;
	
	always @ (In0 or In1 or In2 or In3 or Select)
		begin
			case(Select)
				0: Output = In0;
				1: Output = In1;
				2: Output = In2;
				3: Output = In3;
			endcase
		end
endmodule

//Mux 8 to 1

module Mux8to1(Output, In0, In1, In2, In3,
					In4, In5, In6, In7, Select);
	output [15:0] Output;
	
	input [15:0] In0, In1, In2, In3, In4, In5, In6, In7;
	input [2:0] Select;
	
	reg [15:0] Output;
	
	always @ (In0 or In1 or In2 or In3 or In4 or In5 or In6 or In7 or Select)
		begin
			case(Select)
				0: Output = In0;
				1: Output = In1;
				2: Output = In2;
				3: Output = In3;
				4: Output = In4;
				5: Output = In5;
				6: Output = In6;
				7: Output = In7;
			endcase
		end
endmodule

// Mux code ends here

//----------------------------------------------------------------------------

// Instruction register code goes here

module InstructionRegister(Instruction, JumpAddr, Immediate, OpCode, RS, RT, RD, SHAMT, FUNCT, MemOut, IRWrite, Clock);
    output [15:0] Instruction;
    output [12:0] JumpAddr;
    output [6:0] Immediate;
    output [2:0] OpCode;
	output [3:0] FUNCT;
    output [2:0] RS, RT, RD, SHAMT;
    input  [15:0] MemOut;
    input IRWrite, Clock;
    
    reg [15:0] Instruction;
    
    always @ (negedge Clock) begin
        if (IRWrite) begin
            Instruction <= MemOut;
        end
    end
    
    assign OpCode = Instruction[2:0];
    assign RS = Instruction[5:3];
    assign RT = Instruction[8:6];
    assign RD = Instruction[15:13];
    assign SHAMT = Instruction[12:9];
    assign FUNCT = Instruction[12:9];
    assign Immediate = Instruction[15:9];
    assign JumpAddr = Instruction[15:3];
endmodule

// Instruction Register code ends here
//----------------------------------------------------------------------------
