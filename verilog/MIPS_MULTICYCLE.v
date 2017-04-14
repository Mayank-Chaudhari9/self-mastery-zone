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
module MIPS_MULTICYCLE(input Clock, input Reset, output reg [15:0] result);
	
	wire PcWr, IoD, MemRD, MemWr, IRWrite, RegWr, IntCause, PCWrCond, Overflow, LoWr, HiWr, EPCWr, CauseWr, CIn, COut, BOut, Branch, PcWrite;
	
	wire [1:0] RegDestSel, WriteDataSel, PCSrc, AluSrcASel;
	
	wire [2:0] AluSrcBSel, RegDest;
	
	wire [3:0] Operation, AluOp;
	
	wire [15:0] PcSrcIn, PcOut, AluOut1, Address, MemOut, WriteData,Instruction, Extended_Mem_Add, 
					RegDataIn, MDROut, RegOut1, RegOut2, ArOut, BrOut, Extended7to16, Extended4to16, Zero7to16,
					AluIn1, AluIn2, HiOut, LoOut, AluOut2, Alu2AluOut1, Alu2AluOut2, EPCOut, CauseIn, CauseOut, Result;
	
	
	
	and(Branch, BOut, PCWrCond);
	or(PcWrite, Branch, PcWr); 
	PC pc(PcOut, PcSrcIn, PcWrite, Clock); //needs to be checked

	Mux2to1_16bit IoDMux(Address, PcOut, AluOut1, IoD); // 16 bit mux
	
	Memory memory(MemOut, Address, WriteData, MemRD, MemWR, Clock);
	
	InstructionRegister IR(Instruction, MemOut, IRWrite, Clock);
	
	signExt8to16 sign_ext_8to16(MemOut[7:0], Extended_Mem_Add); // sign extended address for lb
	
	SimpleReg MDR(Extended_Mem_Add, MDROut, 1'b1, Clock); // MDR storage
	
	Control_Unit control_ckt(Instruction[2:0], Instruction[12:9], PcWR, IoD, MemWR, MemRD, IRWrite, RegDestSel,
									 WriteDataSel, RegWr, AluSrcBSel, AluSrcASel, LoWr, HiWr, EPCWr, CauseWr, IntCause, 
									 PCWrCond, PCSrc, Operation, Reset, Clock, Overflow);
									 
	//module Mux4to1(Output, In0, In1, In2, In3, Select);
	Mux4to1_16bit WriteDataSelMux(RegDataIn, AluOut1,PcOut, MDROut, 16'b11 , WriteDataSel);
	
	//module RegisterFile( RegOut1, RegOut2, RegDataIn, RegIn1, RegIn2, RegDest, RegWR, Clock);
	Mux4to1_3bit RegDestMux(RegDest, Instruction[15:13], 3'b111, Instruction[8:6], 3'b110 , WriteDataSel);
	
	RegisterFile RegFile(RegOut1, RegOut2, RegDataIn, Instruction[5:3], Instruction[8:6], RegDest, RegWR, Clock);
	
	SimpleReg A(RegOut1, ArOut, 1'b1, Clock);
	
	SimpleReg B(RegOut2, BrOut, 1'b1, Clock);
	
	//module signExt7to16( input [6:0] offset, output reg [15:0] SignExtOffset);
	signExt7to16 sign7to16(Instruction[15:9], Extended7to16);

	//module signExt4to16( input [3:0] offset, output reg [15:0] SignExtOffset)
	signExt4to16 sign4to16(Instruction[12:9], Extended4to16);
	
	//module zeroExt7to16( input [6:0] offset, output reg [15:0] zeroExtOffset);
	zeroExt7to16 zero7to16(Instruction[15:9], Zero7to16);
	
	Mux4to1_16bit AluSrcAMux(AluIn1, ArOut,PcOut, HiOut, LoOut , AluSrcASel);
	
	//module Mux8to1(Output, In0, In1, In2, In3, In4, In5, In6, In7, Select);
	Mux8to1 AluSrcBMux(AluIn2, AluOut2, Zero7to16, AluOut1, Extended4to16, {Extended7to16[14:0],1'b0}, Extended7to16, BrOut, 16'd10, AluSrcBSel);
	
	//Alu (AluIn1, AluIn2, AluOp, CIn,  AluOut1, AluOut2, COut, BOut , Overflow);
	Alu alu(AluIn1, AluIn2, AluOp, CIn, Alu2AluOut1, Alu2AluOut2, COut, BOut, Overflow);
	
	
	//AluCtrl(Opcode, Operation, AluOp, SType);
	AluCtrl alu_ctrl(Instruction[2:0], Operation, AluOp, Instruction[15:13]);
	
	//SimpleReg(RegIn, RegOut, RegWr, Clock);
	SimpleReg AluOutReg1(Alu2AluOut1, AluOut1, 1'b1, Clock);
	SimpleReg AluOutReg2(Alu2AluOut2, AluOut2, 1'b1, Clock);
	
	SimpleReg EPC(Alu2AluOut1, EPCOut, EPCWr, Clock);
	SimpleReg HI( Alu2AluOut1, HiOut,  HiWr,  Clock);
	SimpleReg LO( Alu2AluOut1, LoOut,  LoWr,  Clock);
	
	//Mux2to1_16bit(Output, In0,In1, Select);
	Mux2to1_16bit causeMux(CauseIn, 16'd0, 16'd1,IntCause );
	SimpleReg cause( CauseIn, CauseOut,  CauseWr,  Clock);
	
	//CarryReg(RegIn, RegOut, RegWr, Clock);
	CarryReg carry(COut, CIn, 1'b1, Clock);
	
	Mux4to1_16bit PcSrcMux(PcSrcIn, ArOut, Alu2AluOut1, {PcOut[15:14], Instruction[15:3],1'b0},16'd180, PCSrc);
	
	assign Result = AluOut1;
	
endmodule
// top module end here
//------------------------------------------------------------------------------------------

// Zero extension 7 to 16 bit
module zeroExt7to16( input [6:0] offset, output reg [15:0] zeroExtOffset);
	always@(offset)
		zeroExtOffset={{9{1'b0}},offset[6:0]};
endmodule

// sign extension codes start here
// sign entension 8 -> 16  //lb
module signExt8to16( input [7:0] offset, output reg [15:0] SignExtOffset);
	always@(offset)
			SignExtOffset={{8{offset[7]}},offset[7:0]};
endmodule

// sign entension 7 -> 16 // beq
module signExt7to16( input [6:0] offset, output reg [15:0] SignExtOffset);
	always@(offset)
			SignExtOffset={{9{offset[6]}},offset[6:0]};
endmodule

// sign entension 7 -> 16 // beq
module signExt4to16( input [3:0] offset, output reg [15:0] SignExtOffset);
	always@(offset)
			SignExtOffset={{12{offset[3]}},offset[3:0]};
endmodule

//sign extension end here
//----------------------------------------------------------------------------------------------

// Memory module starts here

module Memory(MemOut, Address, WriteData, MemRD, MemWR, Clock);
	
	output [15:0] MemOut;

	input  [15:0] Address, WriteData;
	input  MemRD, MemWR, Clock;
	
	reg [15:0] Memory [0:256];
	
	initial begin
		Memory[0]  = {3'd1, 4'd0, 3'd2, 3'd3, 3'd0}; //add
		Memory[1]  = {3'd4, 4'd1, 3'd5, 3'd6, 3'd0}; //and
		Memory[2]  = {3'd7, 4'd2, 3'd6, 3'd4, 3'd0}; // not
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

// Mux 2 to 1 16 bit version
module Mux2to1_16bit(Output, In0,In1, Select);
	output [15:0] Output;
	
	input [15:0] In0, In1;
	input Select;
	
	reg [15:0] Output;
	
	always @ (In0 or In1 or Select)
		begin
			case(Select)
				1'd0: Output = In0;
				1'd1: Output = In1;
			endcase
		end
endmodule

// Mux 2 to 1 1 bit version
module Mux2to1_1bit(Output, In0,In1, Select);
	output [15:0] Output;
	
	input [15:0] In0, In1;
	input Select;
	
	reg [15:0] Output;
	
	always @ (In0 or In1 or Select)
		begin
			case(Select)
				1'd0: Output = In0;
				1'd1: Output = In1;
			endcase
		end
endmodule

//Mux 4 to 1 3bit

module Mux4to1_3bit(Output, In0, In1, In2, In3, Select);
	output [2:0] Output;
	
	input [2:0] In0, In1, In2, In3;
	input [1:0] Select;
	
	reg [2:0] Output;
	
	always @ (In0 or In1 or In2 or In3 or Select)
		begin
			case(Select)
				2'd0: Output = In0;
				2'd1: Output = In1;
				2'd2: Output = In2;
				2'd3: Output = In3;
			endcase
		end
endmodule

//Mux 4 to 1 16bit

module Mux4to1_16bit(Output, In0, In1, In2, In3, Select);
	output [15:0] Output;
	
	input [15:0] In0, In1, In2, In3;
	input [1:0] Select;
	
	reg [15:0] Output;
	
	always @ (In0 or In1 or In2 or In3 or Select)
		begin
			case(Select)
				2'd0: Output = In0;
				2'd1: Output = In1;
				2'd2: Output = In2;
				2'd3: Output = In3;
			endcase
		end
endmodule

//Mux 8 to 1

module Mux8to1(Output, In0, In1, In2, In3, In4, In5, In6, In7, Select);
	output [15:0] Output;
	
	input [15:0] In0, In1, In2, In3, In4, In5, In6, In7;
	input [2:0] Select;
	
	reg [15:0] Output;
	
	always @ (In0 or In1 or In2 or In3 or In4 or In5 or In6 or In7 or Select)
		begin
			case(Select)
				3'd0: Output = In0;
				3'd1: Output = In1;
				3'd2: Output = In2;
				3'd3: Output = In3;
				3'd4: Output = In4;
				3'd5: Output = In5;
				3'd6: Output = In6;
				3'd7: Output = In7;
			endcase
		end
endmodule

// Mux code ends here

//----------------------------------------------------------------------------

// Instruction register code goes here

module InstructionRegister(Instruction, MemOut, IRWrite, Clock);
    output [15:0] Instruction;
	 
	 input [15:0] MemOut;
	 input IRWrite, Clock;
    
    reg [15:0] Instruction;
    
    always @ (negedge Clock) begin
        if (IRWrite) begin
            Instruction <= MemOut;
        end
    end
    
endmodule

// Instruction Register code ends here
//----------------------------------------------------------------------------
// Simple register code goes here

module SimpleReg(RegIn, RegOut, RegWr, Clock);
    output [15:0] RegOut;
	 
	 input [15:0] RegIn;
	 input RegWr, Clock;
    
    reg [15:0] RegOut;
    
    always @ (negedge Clock) begin
        if (RegWr) begin
            RegOut <= RegIn;
        end
    end
    
endmodule

module CarryReg(RegIn, RegOut, RegWr, Clock);
    output  RegOut;
	 
	 input  RegIn;
	 input RegWr, Clock;
    
    reg RegOut;
    
    always @ (negedge Clock) begin
        if (RegWr) begin
            RegOut = RegIn;
        end
    end
    
endmodule

// Simple Register code ends here
//----------------------------------------------------------------------------



// Program counter code goes here

module PC(PcOut, PcSrcIn, PcWr, Clock);
    output [15:0] PcOut;
	 
	 input [15:0] PcSrcIn;
	 input PcWr, Clock;
    
    reg [15:0] PcOut;
    
    always @ (negedge Clock) begin
        if (PcWr) begin
            PcOut <= PcSrcIn;
        end
    end
    
endmodule

// PC code ends here
//----------------------------------------------------------------------------



// Alu code starts here

module Alu (AluIn1, AluIn2, AluOp, CIn,  AluOut1, AluOut2, COut, BOut , Overflow);
	
	input [15:0] AluIn1, AluIn2;
	input [3:0]	 AluOp;
	input CIn;
	
	output reg [15:0] AluOut1, AluOut2;
	output reg COut, BOut, Overflow;
	
	always @ (AluOp)
		begin
			case(AluOp)
				4'd0: 
					begin
						{COut, AluOut1} 	 = AluIn1 + AluIn2;		// add
						if ( ~(AluIn1[15] ^ AluIn2[15]) != AluOut1[15])
							begin
								Overflow = 1'b1;
							end
						else
							begin
								Overflow = 1'b0;
							end
					end
				4'd1: AluOut1 				 = AluIn1 & AluIn2;		// and
				
				4'd2: AluOut1 				 = ~(AluIn1);				// not
	
				4'd3: {AluOut2, AluOut1} = AluIn1 * AluIn2; 		// mul
				
				4'd4: {COut, AluOut1} 	 = AluIn1 - AluIn2;		// sub
				
				4'd5: AluOut1				 = AluIn1 << AluIn2;		// sll  (shift left logical)
				
				4'd6: AluOut1				 = AluIn1 <<< AluIn2;	// sla  (shift left arithmetic)
				
				4'd7: AluOut1				 = AluIn1 >> AluIn2;		// srl  (shift right logical)
				
				4'd8: AluOut1				 = AluIn1 >>> AluIn2;   // sra  (shift right arithmetic)
				
				4'd9: // set less than (slt/slti)
					begin
						if(AluIn1 < AluIn2)
							begin 
								AluOut1 = 15'd1;
							end
					end
					
				4'd10: // branch equal (beq)
					begin
						if (AluIn1 == AluIn2)
							BOut = 1'b1;
						else 
							BOut = 1'b0;
					end
					
				4'd11: AluOut1 				= 15'd0; 			  // NOP
					
				
			endcase
		end
	
endmodule

// alucode end here 

// Alu control start here 

module AluCtrl(Opcode, Operation, AluOp, SType);
	
	output reg [3:0] AluOp;
	
	input [2:0] Opcode;
	input [3:0] Operation;
	input [2:0] SType; 
	
	always @ (Opcode)
	  begin
		case(Opcode)
			3'd0:
				begin 
					case(Operation)
						4'd0: AluOp = 4'd0; //add
						
						4'd1  : AluOp = 4'd1; //and 
						
						4'd2  : AluOp = 4'd2; //not
						
						4'd3  : AluOp = 4'd3; //mul
						
						4'd4  : AluOp = 4'd4; //sub	

						4'd11 : AluOp = 4'd11; //nop
					endcase
				end
					
			3'd1:
				begin
					case(SType)
						2'd0 : AluOp = 4'd5; //sll
						
						2'd1 : AluOp = 4'd7; //srl
						
						2'd2 : AluOp = 4'd8; //sra
					
					endcase
				end
			
			3'd2 : //slti
				begin
					case(Operation)
						4'd9  : AluOp = 4'd9;   //slt
						4'd11 : AluOp = 4'd11; //nop
					endcase
				end
				
			3'd3 : //addi
				begin
					case(Operation)
						4'd0  : AluOp = 4'd0;   //add
						4'd11 : AluOp = 4'd11; //nop
					endcase
				end
				
			3'd4 : //ld -> add
				begin
					case(Operation)
						4'd0  : AluOp = 4'd0;  //add
						4'd11 : AluOp = 4'd11;//nop
					endcase
				end
				
			3'd5 : // sw -> add
				begin
					case(Operation)
						4'd0  : AluOp = 4'd0;  //add
						4'd11 : AluOp = 4'd11;//nop
					endcase
				end
				
			3'd6 :  // beq
				begin
					case(Operation)
						4'd10 : AluOp = 4'd10;//
						//4'd11 : AluOp = 4'd11;//nop
					endcase
				end
				
			3'd7 :   // NOP
				begin
					case(Operation)
						4'd11 : AluOp = 4'd11;//nop
					endcase
				end
				
				
		endcase
	end 
endmodule
// Alu control end here

// ALU related code end here
//----------------------------------------------------------------------------------------------------------------------------------------------------------


//Control circuit goes here

module Control_Unit(input [2:0] Opcode, input [3:0] Funcode, output reg PcWr, output reg IoD, output reg MemWR, output reg MemRD,
						  output reg IRWrite, output reg [1:0] RegDestSel, output reg [1:0] WriteDataSel, output reg RegWr, output reg [2:0] AluSrcBSel,
						  output reg [1:0] AluSrcASel, output reg LoWr, output reg HiWr, output reg EPCWr, output reg CauseWr, output reg IntCause,
						  output reg PCWrCond, output reg [1:0] PCSrc, output reg [3:0] Operation, input Reset, input Clock, input Overflow);
						  
						  reg [4:0] State, NextState;
						  
		always @(negedge  Clock or Reset)
			begin
				if(Reset)
					begin 
						PcWr		   = 0;
						IoD		   = 0; 
						MemWR		   = 0;
						MemRD		   = 0;
						IRWrite	   = 0;
						RegDestSel  = 2'b00;
						WriteDataSel= 2'b00;
						RegWr			= 0;
						AluSrcASel	= 2'b00;
						AluSrcBSel	= 3'b000;
						LoWr			= 0;
						HiWr			= 0;
						EPCWr			= 0;
						CauseWr		= 0;
						IntCause		= 0;
						PCWrCond		= 0;
						PCSrc			= 2'b00;
						Operation	= 4'd11;
						NextState	= 5'd0;
						//State = 5'd0;
					end
				 else
						State			= NextState; 
			  end
			  
		always @(State)
			begin
				case(State)
					5'd0:  // <<-- instruction fetch
						begin 
							PcWr		   = 1;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 1;
							IRWrite	   = 1;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b01;
							AluSrcBSel	= 3'b111;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd0;
							NextState	= 5'd1;
						end
					
					5'd1:  // <<--- Instruction decode
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b01;
							AluSrcBSel	= 3'b100;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation 	= 4'd0; //add (aluout=pc+ offset <<1)
							//-----------------------------
							// need to decide states on the basis of operations
							case(Opcode)
								3'd0:
									begin 
										case (Funcode)
											4'd0: NextState = 5'd2;  // <-- Add  instruction
											4'd1: NextState = 5'd4;  // <-- And  instruction
											4'd2: NextState = 5'd5;  // <-- Not  instruction
											4'd3: NextState = 5'd6;  // <-- Jalr instruction
											4'd4: NextState = 5'd8;  // <-- madd instruction
											4'd5: NextState = 5'd11; // <-- msub instruction
										endcase
									end
								//3'd1: NextState = 5'd25; // <-- shft instruction
								3'd2: NextState = 5'd14; // <-- sltiu instruction
								3'd3: NextState = 5'd16; // <-- addi instruction
								3'd4: NextState = 5'd17; // <-- lb instruction
								3'd5: NextState = 5'd20; // <-- lw instruction
								3'd6: NextState = 5'd22; // <-- beq instruction
								3'd7: NextState = 5'd23; // <-- jal instruction
								
							endcase
							//--------------------------------
						end
								
					// operation based States start here
					
					5'd2:  // <<-- Add exec 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b110;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd0; //add
							NextState	= 5'd3; //to writeback
						end
															
					5'd3:  // <<-- Common Writeback for Add, And, Not
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 1;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b110;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd11; //NOP
							begin
								if(Overflow)
									NextState	= 5'd25; //to exception EPC
								else
									NextState	= 5'd0;   // writeback completion go to state o;
							end
							 
						end
					
					5'd4:  // <<-- And exec 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b110;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd1; //and
							NextState	= 5'd3; // to writeback
						end
						
					5'd5:  // <<-- Not exec 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b110;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd2; // not
							NextState	= 5'd3; // to writeback
						end
					
					5'd6:  // <<-- Jalr WB1 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b01;
							RegWr			= 1;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b110;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd11; // nop
							NextState	= 5'd7; // to writeback 2 of jalr
						end
					
					5'd7:  // <<-- Jalr WB2 
						begin 
							PcWr		   = 1;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b110;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b00;
							Operation	= 4'd11; // nop
							NextState	= 5'd0; // to next instruction -> 0
						end
						
					5'd8:  // <<-- madd exec1 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b110;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd3; // mul
							NextState	= 5'd9; // to madd exec2
						end
						
					5'd9:  // <<-- madd exec2 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b11;
							AluSrcBSel	= 3'b010;
							LoWr			= 1;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd0; //add
							NextState	= 5'd10; //to madd exec3
						end
						
					5'd10:  // <<-- madd exec3
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b10;
							AluSrcBSel	= 3'b000;
							LoWr			= 0;
							HiWr			= 1;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd0; //add
							NextState	= 5'd0; //to next inst -> 0
						end

					5'd11:  // <<-- msub exec1 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b110;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd3; // mul
							NextState	= 5'd12; // to msub exec2
						end
						
					5'd12:  // <<-- madd exec2 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b11;
							AluSrcBSel	= 3'b010;
							LoWr			= 1;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd4; // sub
							NextState	= 5'd13; //to msub exec3
						end
						
					5'd13:  // <<-- msub exec3
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b10;
							AluSrcBSel	= 3'b000;
							LoWr			= 0;
							HiWr			= 1;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd4; //sub
							NextState	= 5'd0; //to next inst -> 0
						end
						
					5'd14:  // <<-- sltiu exec 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b001;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd9; // slt
							NextState	= 5'd15; // to writeback ->15
						end
					
					5'd15:  // <<-- common WriteBack for sltiu, addi
							begin 
								PcWr		   = 0;
								IoD		   = 0; 
								MemWR		   = 0;
								MemRD		   = 0;
								IRWrite	   = 0;
								RegDestSel  = 2'b10;
								WriteDataSel= 2'b00;
								RegWr			= 1;
								AluSrcASel	= 2'b00;
								AluSrcBSel	= 3'b110;
								LoWr			= 0;
								HiWr			= 0;
								EPCWr			= 0;
								CauseWr		= 0;
								IntCause		= 0;
								PCWrCond		= 0;
								PCSrc			= 2'b01;
								Operation	= 4'd11; // nop
								NextState	= 5'd0; // to next inst ->0
							end

					5'd16:  // <<-- Addi exec 
							begin 
								PcWr		   = 0;
								IoD		   = 0; 
								MemWR		   = 0;
								MemRD		   = 0;
								IRWrite	   = 0;
								RegDestSel  = 2'b00;
								WriteDataSel= 2'b00;
								RegWr			= 0;
								AluSrcASel	= 2'b00;
								AluSrcBSel	= 3'b101;
								LoWr			= 0;
								HiWr			= 0;
								EPCWr			= 0;
								CauseWr		= 0;
								IntCause		= 0;
								PCWrCond		= 0;
								PCSrc			= 2'b01;
								Operation	= 4'd0; //add
								NextState	= 5'd15; //to writeback ->15
							end

					5'd17:  // <<-- lb exec (address calculation)
							begin 
								PcWr		   = 0;
								IoD		   = 0; 
								MemWR		   = 0;
								MemRD		   = 0;
								IRWrite	   = 0;
								RegDestSel  = 2'b00;
								WriteDataSel= 2'b00;
								RegWr			= 0;
								AluSrcASel	= 2'b00;
								AluSrcBSel	= 3'b101;
								LoWr			= 0;
								HiWr			= 0;
								EPCWr			= 0;
								CauseWr		= 0;
								IntCause		= 0;
								PCWrCond		= 0;
								PCSrc			= 2'b01;
								Operation	= 4'd0; //add ---->for mem[offset+rs]
								NextState	= 5'd18; //to mem ->18
							end
							
					5'd18:  // <<-- lb MEM
							begin 
								PcWr		   = 0;
								IoD		   = 1; 
								MemWR		   = 0;
								MemRD		   = 1; // mem read
								IRWrite	   = 0;
								RegDestSel  = 2'b00;
								WriteDataSel= 2'b00;
								RegWr			= 0;
								AluSrcASel	= 2'b00;
								AluSrcBSel	= 3'b101;
								LoWr			= 0;
								HiWr			= 0;
								EPCWr			= 0;
								CauseWr		= 0;
								IntCause		= 0;
								PCWrCond		= 0;
								PCSrc			= 2'b01;
								Operation	= 4'd11; //nop
								NextState	= 5'd19; //to writeback ->19
							end
		
					5'd19:  // <<-- lb WB
							begin 
								PcWr		   = 0;
								IoD		   = 0; 
								MemWR		   = 0;
								MemRD		   = 0;
								IRWrite	   = 0;
								RegDestSel  = 2'b00;
								WriteDataSel= 2'b10; // data from mdr
								RegWr			= 0;
								AluSrcASel	= 2'b00;
								AluSrcBSel	= 3'b101;
								LoWr			= 0;
								HiWr			= 0;
								EPCWr			= 0;
								CauseWr		= 0;
								IntCause		= 0;
								PCWrCond		= 0;
								PCSrc			= 2'b01;
								Operation	= 4'd11; //nop
								NextState	= 5'd0; //to next inst ->0
							end
					
					5'd20:  // <<-- sw exec (address calculation)
							begin 
								PcWr		   = 0;
								IoD		   = 0; 
								MemWR		   = 0;
								MemRD		   = 0;
								IRWrite	   = 0;
								RegDestSel  = 2'b00;
								WriteDataSel= 2'b00;
								RegWr			= 0;
								AluSrcASel	= 2'b00;
								AluSrcBSel	= 3'b101;
								LoWr			= 0;
								HiWr			= 0;
								EPCWr			= 0;
								CauseWr		= 0;
								IntCause		= 0;
								PCWrCond		= 0;
								PCSrc			= 2'b01;
								Operation	= 4'd0; //add ---->for mem[offset+rs]
								NextState	= 5'd21; //to writeback ->21
							end
					
					5'd21:  // <<-- lb WB
							begin 
								PcWr		   = 0;
								IoD		   = 1; 
								MemWR		   = 0;
								MemRD		   = 0; // mem read
								IRWrite	   = 1; // mem write
								RegDestSel  = 2'b00;
								WriteDataSel= 2'b00;
								RegWr			= 0;
								AluSrcASel	= 2'b00;
								AluSrcBSel	= 3'b101;
								LoWr			= 0;
								HiWr			= 0;
								EPCWr			= 0;
								CauseWr		= 0;
								IntCause		= 0;
								PCWrCond		= 0;
								PCSrc			= 2'b01;
								Operation	= 4'd11; //nop
								NextState	= 5'd0; //to next inst ->0
							end
					
					5'd22:  // <<-- beq exec
							begin 
								PcWr		   = 0;
								IoD		   = 0; 
								MemWR		   = 0;
								MemRD		   = 0; 
								IRWrite	   = 0; 
								RegDestSel  = 2'b00;
								WriteDataSel= 2'b00;
								RegWr			= 0;
								AluSrcASel	= 2'b00;
								AluSrcBSel	= 3'b100; //offset <<1
								LoWr			= 0;
								HiWr			= 0;
								EPCWr			= 0;
								CauseWr		= 0;
								IntCause		= 0;
								PCWrCond		= 0;
								PCSrc			= 2'b01;
								Operation	= 4'd10; //beq
								NextState	= 5'd0; //to next inst ->0
							end
					
					5'd23:  // <<-- Jal WB1 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b01;
							WriteDataSel= 2'b01;
							RegWr			= 1;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b110;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b01;
							Operation	= 4'd11; // nop
							NextState	= 5'd24; // to writeback 2 of jal
						end
					
					5'd24:  // <<-- Jalr WB2 
						begin 
							PcWr		   = 1;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b110;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b10;
							Operation	= 4'd11; // nop
							NextState	= 5'd0; // to next instruction -> 0
						end	
						
					5'd25:  // <<-- Exception state EPC
						begin 
							PcWr		   = 1;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b01; // select pc
							AluSrcBSel	= 3'b111; // select 2
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 1;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b11;
							Operation	= 4'd4; // subtract  EPC = PC-2
							NextState	= 5'd0; // to next instruction -> 0
						end
						
					5'd26:  // <<--  shift exec 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b10;
							WriteDataSel= 2'b00;
							RegWr			= 0;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b011;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b10;
							Operation	= 4'd11; // nop -> does'nt matter resolve in alu control
							NextState	= 5'd27; // to next instruction -> 0
						end
						
					5'd27:  // <<-- shift  WB2 
						begin 
							PcWr		   = 0;
							IoD		   = 0; 
							MemWR		   = 0;
							MemRD		   = 0;
							IRWrite	   = 0;
							RegDestSel  = 2'b00;
							WriteDataSel= 2'b00;
							RegWr			= 1;
							AluSrcASel	= 2'b00;
							AluSrcBSel	= 3'b110;
							LoWr			= 0;
							HiWr			= 0;
							EPCWr			= 0;
							CauseWr		= 0;
							IntCause		= 0;
							PCWrCond		= 0;
							PCSrc			= 2'b10;
							Operation	= 4'd11; // nop
							NextState	= 5'd0; // to next instruction -> 0
						end
					
					
					
				endcase
			end
endmodule
