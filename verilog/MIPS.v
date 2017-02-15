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
module MIPS(   input clk, input reset, output [31:0] result );

		wire regwrite, as, aluIn1sel, regwritesel,  hiW, lowW, mw, mr, b, B_out, bFlag;
		wire [1:0] aluIn2sel, pcVal, lowsel, highsel, destsel;
		wire [2:0] outputsel;
		wire [3:0] aluctrl, aluOp;
		wire [5:0] dest_reg_sel;
		wire [31:0] pcmuxVal, pc_out, pcaddopt, im_out, signExt_16to32_out, jump_to_offset, outputsel_data, regwritesel_data,
						rf_out1, rf_out2, zeroExt_16to32_out, zeroExt_5to32_out, aluOut1, aluOut2, aluIn1sel_out, aluIn1se2_out,
						lomux_out, himux_out, final_branch, outputsel_out, dest_reg_sel_out, HiReg_out,LoReg_out;

		register_32bit PC( clk, reset, pcmuxVal, pc_out);
		
		Adder32Bit pc_adder(pc_out, {32'd4}, pcaddopt);
		
		IM ins_Mem( clk, reset , pc_out [5:0], im_out);
		
		control_CKT mips_ctrl( im_out[31:26] , im_out[5:0] , regwrite, as, aluIn1sel, outputsel, regwritesel, aluIn2sel,
									  lowsel, highsel, hiW, lowW, pcVal, destsel,  mw, mr, b, aluctrl);
									  
		Adder32Bit b_adder(pcaddopt, {signExt_16to32_out[29:0], 2'b00}, jump_to_offset);
		
		mux64to1 instruction(im_out[20:16], im_out[15:11], {5'b11111}, dest_reg_sel, dest_reg_sel_out);
		
		mux2to1 sel_regfile_wb_data( outputsel_data, pcaddopt, regwritesel, regwritesel_data);
		
		mux4to1 pc_final( rf_out1, final_branch, {pcaddopt[31:28],BRANCH_out, im_out[25:0],2'b00},pcVal,pcmuxVal);
		
		registerFile rf(clk, reset, regwrite, im_out[25:21], im_out[20:16], im_out[15:11], result, rf_out1, rf_out2);
		
		zeroExt5to32 zext5to32(im_out[10:6], zeroExt_5to32_out);	
		zeroExt16to32 zext16to32(im_out[15:0], zeroExt_16to32_out);	
		signExt16to32 sext16to32(im_out[15:0], signExt_16to32_out);
		
		alu_ctrl aluctrl_1(aluctrl, im_out[5:0], aluOp);
		
		mux2to1 RF_OP1(zeroExt_5to32_out,rf_out1, aluIn1sel, aluIn1sel_out);						 
		mux4to1 RF_OP2(zeroExt_16to32_out, signExt_16to32_out,rf_out2,aluIn2sel, aluIn2sel_out);
		
		alu alu1(aluIn1sel_out, aluIn2sel_out, aluOp, aluOut1, aluOut2, bFlag);
		
		and B(B_out, b, bFlag);
		mux2to1 BRANCH(pcaddopt , jump_to_offset,B_out, final_branch);
		mux4to1 HI_IP(aluOut2,rf_out1, addsub_out, highsel, himux_out);
		mux4to1 lo_ip(aluOut1, rf_out1, as_out, lowsel,lomux_out);
		
		register_32bit hi(clk,reset,hiW,himux_out,HiReg_out);
		register_32bit lo(clk,reset,lowW,lomux_out,LoReg_out);
		
		AdderSubtractor64Bit add_sub({aluOut1,aluOut2}, {HiReg_out,LoReg_out}, addsub_out, as);
	
		mux8to1 FINAL(HiReg_out,LoReg_out,aluOut1,{32'd2},{32'd2},{32'd2},{32'd2},{32'd2}, outputsel, outputsel_out);
		assign Result = aluOut1;
		


endmodule

// 4to1 multiplexer  used for mux6, mux1, mux2, mux8, mux9;
module mux4to1( input [31:0] outR0, input [31:0] outR1, input [31:0] outR2, input [31:0] outR3, input [1:0] Sel, output reg [31:0] outBus );

always@(outR0,outR1,outR2,outR3,Sel)
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

always@(outR0,outR1,Sel)
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
module AdderSubtractor64Bit(input [63:0] input1, input [63:0] input2,output reg [63:1] out, input operation);
  
  //input [63:0] input1, input2;
  //output [63:0] out;
  //reg [63:0]out;
  
     always@(input1 or input2)
       if (operation == 1'b1)
			begin
				out = input1 + input2;
			end
		else
			begin
				out = input1 - input2;
			end
endmodule

// sign extension 16 to 32 bit
module signExt16to32( input [15:0] offset, output reg [31:0] signExtOffset);
	always@(offset)
			signExtOffset={{16{offset[15]}},offset[15:0]};
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
module zeroExt5to32( input [4:0] offset, output reg [31:0] zeroExtOffset);
	always@(offset)
		zeroExtOffset={{27{1'b0}},offset[4:0]};
endmodule

// Zero extension 8 to 32 bit
module zeroExt8to32( input [7:0] offset, output reg [31:0] zeroExtOffset);
	always@(offset)
		zeroExtOffset={{27{1'b0}},offset[7:0]};
endmodule

//Instruction Memory Code Starts
module D_ff_IM(input clk, input reset, input d, output reg q);
	always@(reset or posedge clk)
	if(reset)
		q=d;
endmodule

module register_IM(input clk, input reset, input [31:0] d_in, output [31:0] q_out);
	D_ff_IM dIM0  (clk, reset, d_in[0], q_out[0]);
	D_ff_IM dIM1  (clk, reset, d_in[1], q_out[1]);
	D_ff_IM dIM2  (clk, reset, d_in[2], q_out[2]);
	D_ff_IM dIM3  (clk, reset, d_in[3], q_out[3]);
	D_ff_IM dIM4  (clk, reset, d_in[4], q_out[4]);
	D_ff_IM dIM5  (clk, reset, d_in[5], q_out[5]);
	D_ff_IM dIM6  (clk, reset, d_in[6], q_out[6]);
	D_ff_IM dIM7  (clk, reset, d_in[7], q_out[7]);
	D_ff_IM dIM8  (clk, reset, d_in[8], q_out[8]);
	D_ff_IM dIM9  (clk, reset, d_in[9], q_out[9]);
	D_ff_IM dIM10 (clk, reset, d_in[10], q_out[10]);
	D_ff_IM dIM11 (clk, reset, d_in[11], q_out[11]);
	D_ff_IM dIM12 (clk, reset, d_in[12], q_out[12]);
	D_ff_IM dIM13 (clk, reset, d_in[13], q_out[13]);
	D_ff_IM dIM14 (clk, reset, d_in[14], q_out[14]);
	D_ff_IM dIM15 (clk, reset, d_in[15], q_out[15]);
	
	D_ff_IM dIM16 (clk, reset, d_in[16], q_out[16]);
	D_ff_IM dIM17 (clk, reset, d_in[17], q_out[17]);
	D_ff_IM dIM18 (clk, reset, d_in[18], q_out[18]);
	D_ff_IM dIM19 (clk, reset, d_in[19], q_out[19]);
	D_ff_IM dIM20 (clk, reset, d_in[20], q_out[20]);
	D_ff_IM dIM21 (clk, reset, d_in[21], q_out[21]);
	D_ff_IM dIM22 (clk, reset, d_in[22], q_out[22]);
	D_ff_IM dIM23 (clk, reset, d_in[23], q_out[23]);
	D_ff_IM dIM24 (clk, reset, d_in[24], q_out[24]);
	D_ff_IM dIM25 (clk, reset, d_in[25], q_out[25]);
	D_ff_IM dIM26 (clk, reset, d_in[26], q_out[26]);
	D_ff_IM dIM27 (clk, reset, d_in[27], q_out[27]);
	D_ff_IM dIM28 (clk, reset, d_in[28], q_out[28]);
	D_ff_IM dIM29 (clk, reset, d_in[29], q_out[29]);
	D_ff_IM dIM30 (clk, reset, d_in[30], q_out[30]);
	D_ff_IM dIM31 (clk, reset, d_in[31], q_out[31]);
	
endmodule

module mux64to1( input [31:0] outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,outR8,outR9,outR10,outR11,outR12,outR13,outR14,outR15,
										outR16,outR17,outR18,outR19,outR20,outR21,outR22,outR23,outR24,outR25,outR26,outR27,outR28,outR29,outR30,outR31,
										outR32,outR33,outR34,outR35,outR36,outR37,outR38,outR39,outR40,outR41,outR42,outR43,outR44,outR45,outR46,outR47,
										outR48,outR49,outR50,outR51,outR52,outR53,outR54,outR55,outR56,outR57,outR58,outR59,outR60,outR61,outR62,outR63,
										input [5:0] Sel, output reg [31:0] outBus );
	always@(outR0 or outR1 or outR2 or outR3 or outR4 or outR5 or outR6 or outR7 or outR8 or outR9 or outR10 or outR11 or outR12 or outR13 or outR14 or outR15 or 
			outR16 or outR17 or outR18 or outR19 or outR20 or outR21 or outR22 or outR23 or outR24 or outR25 or outR26 or outR27 or outR28 or outR29 or outR30 or outR31 or 
			outR32 or outR33 or outR34 or outR35 or outR36 or outR37 or outR38 or outR39 or outR40 or outR41 or outR42 or outR43 or outR44 or outR45 or outR46 or outR47 or
			outR48 or outR49 or outR50 or outR51 or outR52 or outR53 or outR54 or outR55 or outR56 or outR57 or outR58 or outR59 or outR60 or outR61 or outR62 or outR63 or Sel)
	case (Sel)
				6'b000000: outBus=outR0;
				6'b000001: outBus=outR1;
				6'b000010: outBus=outR2;
				6'b000011: outBus=outR3;
				6'b000100: outBus=outR4;
				6'b000101: outBus=outR5;
				6'b000110: outBus=outR6;
				6'b000111: outBus=outR7;
				6'b001000: outBus=outR8;
				6'b001001: outBus=outR9;
				6'b001010: outBus=outR10;
				6'b001011: outBus=outR11;
				6'b001100: outBus=outR12;
				6'b001101: outBus=outR13;
				6'b001110: outBus=outR14;
				6'b001111: outBus=outR15;
				
				6'b010000: outBus=outR16;
				6'b010001: outBus=outR17;
				6'b010010: outBus=outR18;
				6'b010011: outBus=outR19;
				6'b010100: outBus=outR20;
				6'b010101: outBus=outR21;
				6'b010110: outBus=outR22;
				6'b010111: outBus=outR23;
				6'b011000: outBus=outR24;
				6'b011001: outBus=outR25;
				6'b011010: outBus=outR26;
				6'b011011: outBus=outR27;
				6'b011100: outBus=outR28;
				6'b011101: outBus=outR29;
				6'b011110: outBus=outR30;
				6'b011111: outBus=outR31;
				
				6'b100000: outBus=outR32;
				6'b100001: outBus=outR33;
				6'b100010: outBus=outR34;
				6'b100011: outBus=outR35;
				6'b100100: outBus=outR36;
				6'b100101: outBus=outR37;
				6'b100110: outBus=outR38;
				6'b100111: outBus=outR39;
				6'b101000: outBus=outR40;
				6'b101001: outBus=outR41;
				6'b101010: outBus=outR42;
				6'b101011: outBus=outR43;
				6'b101100: outBus=outR44;
				6'b101101: outBus=outR45;
				6'b101110: outBus=outR46;
				6'b101111: outBus=outR47;
				
				6'b110000: outBus=outR48;
				6'b110001: outBus=outR49;
				6'b110010: outBus=outR50;
				6'b110011: outBus=outR51;
				6'b110100: outBus=outR52;
				6'b110101: outBus=outR53;
				6'b110110: outBus=outR54;
				6'b110111: outBus=outR55;
				6'b111000: outBus=outR56;
				6'b111001: outBus=outR57;
				6'b111010: outBus=outR58;
				6'b111011: outBus=outR59;
				6'b111100: outBus=outR60;
				6'b111101: outBus=outR61;
				6'b111110: outBus=outR62;
				6'b111111: outBus=outR63;
	endcase
endmodule

module IM(  input clk, input reset, input [5:0] pc_6bits, output [31:0] IR );
	wire [31:0] Qout0, Qout1, Qout2, Qout3, Qout4, Qout5, Qout6, Qout7,
					Qout8, Qout9, Qout10, Qout11, Qout12, Qout13, Qout14, Qout15,
					Qout16, Qout17, Qout18, Qout19, Qout20, Qout21, Qout22, Qout23,
					Qout24, Qout25, Qout26, Qout27, Qout28, Qout29, Qout30, Qout31,
					Qout32, Qout33, Qout34, Qout35, Qout36, Qout37, Qout38, Qout39,
					Qout40, Qout41, Qout42, Qout43, Qout44, Qout45, Qout46,
					Qout47, Qout48, Qout49, Qout50, Qout51, Qout52, Qout53, Qout54,
					Qout55, Qout56, Qout57, Qout58, Qout59, Qout60, Qout61, Qout62, Qout63;
	register_IM rIM0 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000,Qout0); 		
	register_IM rIM1 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout1); 
	register_IM rIM2 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout2); 	
	register_IM rIM3 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout3); 	
	register_IM rIM4 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout4); 	
	register_IM rIM5 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout5); 	
	register_IM rIM6 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout6); 	
	register_IM rIM7 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout7);		
	register_IM rIM8 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout8); 	
	register_IM rIM9 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout9); 		
	register_IM rIM10 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout10); 	
	register_IM rIM11 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout11); 	
	register_IM rIM12 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout12); 
	register_IM rIM13 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout13); 
	register_IM rIM14 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout14); 	
	register_IM rIM15 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout15);

	register_IM rIM16 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000,Qout0); 		
	register_IM rIM17 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout1); 	
	register_IM rIM18 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout2); 	
	register_IM rIM19 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout3); 	
	register_IM rIM20 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout4); 	
	register_IM rIM21 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout5); 	
	register_IM rIM22 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout6); 	
	register_IM rIM23 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout7);		
	register_IM rIM24 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout8); 	
	register_IM rIM25 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout9); 		
	register_IM rIM26 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout10); 	
	register_IM rIM27 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout11); 	
	register_IM rIM28 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout12); 
	register_IM rIM29 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout13); 
	register_IM rIM30 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout14); 	
	register_IM rIM31 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout15);
	
	register_IM rIM32 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000,Qout0); 		
	register_IM rIM33 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout1); 	
	register_IM rIM34 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout2); 	
	register_IM rIM35 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout3); 	
	register_IM rIM36 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout4); 	
	register_IM rIM37 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout5); 	
	register_IM rIM38 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout6); 	
	register_IM rIM39 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout7);		
	register_IM rIM40 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout8); 	
	register_IM rIM41 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout9); 		
	register_IM rIM42 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout10); 	
	register_IM rIM43 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout11); 	
	register_IM rIM44 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout12); 
	register_IM rIM45 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout13); 
	register_IM rIM46 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout14); 	
	register_IM rIM47 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout15);
	
	register_IM rIM48 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000,Qout0); 		
	register_IM rIM49 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout1); 	
	register_IM rIM50 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout2); 	
	register_IM rIM51 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout3); 	
	register_IM rIM52 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout4); 	
	register_IM rIM53 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout5); 	
	register_IM rIM54 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout6); 	
	register_IM rIM55 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout7);		
	register_IM rIM56 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout8); 	
	register_IM rIM57 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout9); 		
	register_IM rIM58 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout10); 	
	register_IM rIM59 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout11); 	
	register_IM rIM60 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout12); 
	register_IM rIM61 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout13); 
	register_IM rIM62 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout14); 	
	register_IM rIM63 (clk, reset, 32'b0000_0000_0000_0000_0000_0000_0000_0000, Qout15);
	
	mux64to1 mIM (Qout0,Qout1,Qout2,Qout3,Qout4,Qout5,Qout6,Qout7,Qout8,Qout9,Qout10,Qout11,Qout12,Qout13,Qout14,Qout15,
					 Qout16,Qout17,Qout18,Qout18,Qout20,Qout21,Qout22,Qout23,Qout24,Qout25,Qout26,Qout27,Qout28,Qout29,Qout30,Qout31,
					 Qout32,Qout33,Qout34,Qout35,Qout36,Qout37,Qout38,Qout39,Qout40,Qout41,Qout42,Qout43,Qout44,Qout45,Qout46,Qout47,
					 Qout48,Qout49,Qout50,Qout51,Qout52,Qout53,Qout54,Qout55,Qout56,Qout57,Qout58,Qout59,Qout60,Qout61,Qout62,Qout63,
					 pc_6bits[5:0],IR);
endmodule

//Instruction Memory Code Ends

//Register Memory Code Starts
module D_ff_reg (input clk, input reset, input regWrite, input decOut1b, input d, output reg q);
	always @ (negedge clk)
		begin
			if(reset==1)
				q=1;
			else
				if(regWrite == 1 && decOut1b==1)
					begin
						q=d;
					end
		end
endmodule


module register32bit( input clk, input reset, input regWrite, input decOut1b, input [31:0] writeData, output  [31:0] outR );
	D_ff_reg d0(clk, reset, regWrite,  decOut1b,  writeData[0], outR[0]);
	D_ff_reg d1(clk, reset, regWrite,  decOut1b,  writeData[1], outR[1]);
	D_ff_reg d2(clk, reset, regWrite,  decOut1b,  writeData[2], outR[2]);
	D_ff_reg d3(clk, reset, regWrite,  decOut1b,  writeData[3], outR[3]);
	D_ff_reg d4(clk, reset, regWrite,  decOut1b,  writeData[4], outR[4]);
	D_ff_reg d5(clk, reset, regWrite,  decOut1b,  writeData[5], outR[5]);
	D_ff_reg d6(clk, reset, regWrite,  decOut1b,  writeData[6], outR[6]);
	D_ff_reg d7(clk, reset, regWrite,  decOut1b,  writeData[7], outR[7]);
	D_ff_reg d8(clk, reset, regWrite,  decOut1b,  writeData[8], outR[8]);
	D_ff_reg d9(clk, reset, regWrite,  decOut1b,  writeData[9], outR[9]);
	D_ff_reg d10(clk, reset, regWrite, decOut1b, writeData[10], outR[10]);
	D_ff_reg d11(clk, reset, regWrite, decOut1b, writeData[11], outR[11]);
	D_ff_reg d12(clk, reset, regWrite, decOut1b, writeData[12], outR[12]);
	D_ff_reg d13(clk, reset, regWrite, decOut1b, writeData[13], outR[13]);
	D_ff_reg d14(clk, reset, regWrite, decOut1b, writeData[14], outR[14]);
	D_ff_reg d15(clk, reset, regWrite, decOut1b, writeData[15], outR[15]);
	
	D_ff_reg d16(clk, reset, regWrite, decOut1b, writeData[16], outR[16]);
	D_ff_reg d17(clk, reset, regWrite, decOut1b, writeData[17], outR[17]);
	D_ff_reg d18(clk, reset, regWrite, decOut1b, writeData[18], outR[18]);
	D_ff_reg d19(clk, reset, regWrite, decOut1b, writeData[19], outR[19]);
	D_ff_reg d20(clk, reset, regWrite, decOut1b, writeData[20], outR[20]);
	D_ff_reg d21(clk, reset, regWrite, decOut1b, writeData[21], outR[21]);
	D_ff_reg d22(clk, reset, regWrite, decOut1b, writeData[22], outR[22]);
	D_ff_reg d23(clk, reset, regWrite, decOut1b, writeData[23], outR[23]);
	D_ff_reg d24(clk, reset, regWrite, decOut1b, writeData[24], outR[24]);
	D_ff_reg d25(clk, reset, regWrite, decOut1b, writeData[25], outR[25]);
	D_ff_reg d26(clk, reset, regWrite, decOut1b, writeData[26], outR[26]);
	D_ff_reg d27(clk, reset, regWrite, decOut1b, writeData[27], outR[27]);
	D_ff_reg d28(clk, reset, regWrite, decOut1b, writeData[28], outR[28]);
	D_ff_reg d29(clk, reset, regWrite, decOut1b, writeData[29], outR[29]);
	D_ff_reg d30(clk, reset, regWrite, decOut1b, writeData[30], outR[30]);
	D_ff_reg d31(clk, reset, regWrite, decOut1b, writeData[31], outR[31]);
endmodule


module register_32bit( input clk, input reset, input regWrite,  input [31:0] writeData, output  [31:0] outR );
	D_ff_reg d0(clk, reset, regWrite,    writeData[0], outR[0]);
	D_ff_reg d1(clk, reset, regWrite,   writeData[1], outR[1]);
	D_ff_reg d2(clk, reset, regWrite,    writeData[2], outR[2]);
	D_ff_reg d3(clk, reset, regWrite,    writeData[3], outR[3]);
	D_ff_reg d4(clk, reset, regWrite,    writeData[4], outR[4]);
	D_ff_reg d5(clk, reset, regWrite,    writeData[5], outR[5]);
	D_ff_reg d6(clk, reset, regWrite,    writeData[6], outR[6]);
	D_ff_reg d7(clk, reset, regWrite,    writeData[7], outR[7]);
	D_ff_reg d8(clk, reset, regWrite,    writeData[8], outR[8]);
	D_ff_reg d9(clk, reset, regWrite,    writeData[9], outR[9]);
	D_ff_reg d10(clk, reset, regWrite,  writeData[10], outR[10]);
	D_ff_reg d11(clk, reset, regWrite,  writeData[11], outR[11]);
	D_ff_reg d12(clk, reset, regWrite,  writeData[12], outR[12]);
	D_ff_reg d13(clk, reset, regWrite,  writeData[13], outR[13]);
	D_ff_reg d14(clk, reset, regWrite,  writeData[14], outR[14]);
	D_ff_reg d15(clk, reset, regWrite,  writeData[15], outR[15]);
	
	D_ff_reg d16(clk, reset, regWrite,  writeData[16], outR[16]);
	D_ff_reg d17(clk, reset, regWrite, writeData[17], outR[17]);
	D_ff_reg d18(clk, reset, regWrite,  writeData[18], outR[18]);
	D_ff_reg d19(clk, reset, regWrite,  writeData[19], outR[19]);
	D_ff_reg d20(clk, reset, regWrite,  writeData[20], outR[20]);
	D_ff_reg d21(clk, reset, regWrite,  writeData[21], outR[21]);
	D_ff_reg d22(clk, reset, regWrite,  writeData[22], outR[22]);
	D_ff_reg d23(clk, reset, regWrite,  writeData[23], outR[23]);
	D_ff_reg d24(clk, reset, regWrite,  writeData[24], outR[24]);
	D_ff_reg d25(clk, reset, regWrite,  writeData[25], outR[25]);
	D_ff_reg d26(clk, reset, regWrite,  writeData[26], outR[26]);
	D_ff_reg d27(clk, reset, regWrite,  writeData[27], outR[27]);
	D_ff_reg d28(clk, reset, regWrite,  writeData[28], outR[28]);
	D_ff_reg d29(clk, reset, regWrite,  writeData[29], outR[29]);
	D_ff_reg d30(clk, reset, regWrite,  writeData[30], outR[30]);
	D_ff_reg d31(clk, reset, regWrite,  writeData[31], outR[31]);
endmodule

module registerSet( input clk, input reset, input regWrite, input [31:0] decOut, input [31:0] writeData,
	output [31:0] outR0,  output [31:0] outR1,  output [31:0] outR2,  output [31:0] outR3,
	output [31:0] outR4,  output [31:0] outR5,  output [31:0] outR6,  output [31:0] outR7,
	output [31:0] outR8,  output [31:0] outR9,  output [31:0] outR10, output [31:0] outR11,
	output [31:0] outR12, output [31:0] outR13, output [31:0] outR14, output [31:0] outR15,
	output [31:0] outR16, output [31:0] outR17, output [31:0] outR18, output [31:0] outR19,
	output [31:0] outR20, output [31:0] outR21, output [31:0] outR22, output [31:0] outR23,
	output [31:0] outR24, output [31:0] outR25, output [31:0] outR26, output [31:0] outR27,
	output [31:0] outR28, output [31:0] outR29, output [31:0] outR30, output [31:0] outR31);

	register32bit rs0 ( clk, reset, regWrite, decOut[0], writeData, outR0 );
	register32bit rs1 ( clk, reset, regWrite, decOut[1], writeData, outR1 );
	register32bit rs2 ( clk, reset, regWrite, decOut[2], writeData, outR2 );
	register32bit rs3 ( clk, reset, regWrite, decOut[3], writeData, outR3 );
	
	register32bit rs4 ( clk, reset, regWrite, decOut[4], writeData, outR4 );
	register32bit rs5 ( clk, reset, regWrite, decOut[5], writeData, outR5 );
	register32bit rs6 ( clk, reset, regWrite, decOut[6], writeData, outR6 );
	register32bit rs7 ( clk, reset, regWrite, decOut[7], writeData, outR7 );
	
	register32bit rs8 ( clk, reset, regWrite, decOut[8], writeData, outR8 );
	register32bit rs9 ( clk, reset, regWrite, decOut[9], writeData, outR9 );
	register32bit rs10( clk, reset, regWrite, decOut[10], writeData, outR10 );
	register32bit rs11( clk, reset, regWrite, decOut[11], writeData, outR11 );
	
	register32bit rs12( clk, reset, regWrite, decOut[12], writeData, outR12 );
	register32bit rs13( clk, reset, regWrite, decOut[13], writeData, outR13 );
	register32bit rs14( clk, reset, regWrite, decOut[14], writeData, outR14 );
	register32bit rs15( clk, reset, regWrite, decOut[15], writeData, outR15 );
	
	register32bit rs16( clk, reset, regWrite, decOut[16], writeData, outR16 );
	register32bit rs17( clk, reset, regWrite, decOut[17], writeData, outR17 );
	register32bit rs18( clk, reset, regWrite, decOut[18], writeData, outR18 );
	register32bit rs19( clk, reset, regWrite, decOut[19], writeData, outR19 );
	
	register32bit rs20( clk, reset, regWrite, decOut[20], writeData, outR20 );
	register32bit rs21( clk, reset, regWrite, decOut[21], writeData, outR21 );
	register32bit rs22( clk, reset, regWrite, decOut[22], writeData, outR22 );
	register32bit rs23( clk, reset, regWrite, decOut[23], writeData, outR23 );
	
	register32bit rs24( clk, reset, regWrite, decOut[24], writeData, outR24 );
	register32bit rs25( clk, reset, regWrite, decOut[25], writeData, outR25 );
	register32bit rs26( clk, reset, regWrite, decOut[26], writeData, outR26 );
	register32bit rs27( clk, reset, regWrite, decOut[27], writeData, outR27 );
	
	register32bit rs28( clk, reset, regWrite, decOut[28], writeData, outR28 );
	register32bit rs29( clk, reset, regWrite, decOut[29], writeData, outR29 );
	register32bit rs30( clk, reset, regWrite, decOut[30], writeData, outR30 );
	register32bit rs31( clk, reset, regWrite, decOut[31], writeData, outR31 );
	
	
	
endmodule

module decoder( input [5:0] destReg, output reg [31:0] decOut);
always @(destReg)
	case(destReg)
	5'd0:  decOut=32'b0000_0000_0000_0000_0000_0000_0000_0001;
	5'd1:  decOut=32'b0000_0000_0000_0000_0000_0000_0000_0010;
	5'd2:  decOut=32'b0000_0000_0000_0000_0000_0000_0000_0100;
	5'd3:  decOut=32'b0000_0000_0000_0000_0000_0000_0000_1000;
	5'd4:  decOut=32'b0000_0000_0000_0000_0000_0000_0001_0000;
	5'd5:  decOut=32'b0000_0000_0000_0000_0000_0000_0010_0000;
	5'd6:  decOut=32'b0000_0000_0000_0000_0000_0000_0100_0000;
	5'd7:  decOut=32'b0000_0000_0000_0000_0000_0000_1000_0000;
	5'd8:  decOut=32'b0000_0000_0000_0000_0000_0001_0000_0000;
	5'd9:  decOut=32'b0000_0000_0000_0000_0000_0010_0000_0000;
	5'd10: decOut=32'b0000_0000_0000_0000_0000_0100_0000_0000;
	5'd11: decOut=32'b0000_0000_0000_0000_0000_1000_0000_0000;
	5'd12: decOut=32'b0000_0000_0000_0000_0001_0000_0000_0000;
	5'd13: decOut=32'b0000_0000_0000_0000_0010_0000_0000_0000;
	5'd14: decOut=32'b0000_0000_0000_0000_0100_0000_0000_0000;
	5'd15: decOut=32'b0000_0000_0000_0000_1000_0000_0000_0000;
	5'd16: decOut=32'b0000_0000_0000_0001_0000_0000_0000_0000;
	5'd17: decOut=32'b0000_0000_0000_0010_0000_0000_0000_0000;
	5'd18: decOut=32'b0000_0000_0000_0100_0000_0000_0000_0000;
	5'd19: decOut=32'b0000_0000_0000_1000_0000_0000_0000_0000;
	5'd20: decOut=32'b0000_0000_0001_0000_0000_0000_0000_0000;
	5'd21: decOut=32'b0000_0000_0010_0000_0000_0000_0000_0000;
	5'd22: decOut=32'b0000_0000_0100_0000_0000_0000_0000_0000;
	5'd23: decOut=32'b0000_0000_1000_0000_0000_0000_0000_0000;
	5'd24: decOut=32'b0000_0001_0000_0000_0000_0000_0000_0000;
	5'd25: decOut=32'b0000_0010_0000_0000_0000_0000_0000_0000;
	5'd26: decOut=32'b0000_0100_0000_0000_0000_0000_0000_0000;
	5'd27: decOut=32'b0000_1000_0000_0000_0000_0000_0000_0000;
	5'd28: decOut=32'b0001_0000_0000_0000_0000_0000_0000_0000;
	5'd29: decOut=32'b0010_0000_0000_0000_0000_0000_0000_0000;
	5'd30: decOut=32'b0100_0000_0000_0000_0000_0000_0000_0000;
	5'd31: decOut=32'b1000_0000_0000_0000_0000_0000_0000_0000;
	endcase
endmodule

module mux32to1( input [31:0] outR0, input [31:0] outR1, input [31:0] outR2, input [31:0] outR3, input [31:0] outR4, input [31:0] outR5, input [31:0] outR6, input [31:0] outR7,
					 input [31:0] outR8, input [31:0] outR9, input [31:0] outR10, input [31:0] outR11, input [31:0] outR12, input [31:0] outR13, input [31:0] outR14, input [31:0] outR15,
					 input [31:0] outR16, input [31:0] outR17, input [31:0] outR18, input [31:0] outR19, input [31:0] outR20, input [31:0] outR21, input [31:0] outR22, input [31:0] outR23,
					 input [31:0] outR24, input [31:0] outR25, input [31:0] outR26, input [31:0] outR27, input [31:0] outR28, input [31:0] outR29, input [31:0] outR30, input [31:0] outR31,
					 input [4:0] Sel, output reg [31:0] outBus );

always@(outR0,outR1,outR2,outR3,outR4,outR5,outR6,outR7,
		  outR8,outR9,outR10,outR11,outR12,outR13,outR14,outR15,
		  outR16,outR17,outR18,outR19,outR20,outR21,outR22,outR23,
		  outR24,outR25,outR26,outR27,outR28,outR29,outR30,outR31,Sel)
	case(Sel)
		4'd0:outBus=outR0;
		4'd1:outBus=outR1;
		4'd2:outBus=outR2;
		4'd3:outBus=outR3;
		4'd4:outBus=outR4;
		4'd5:outBus=outR5;
		4'd6:outBus=outR6;
		4'd7:outBus=outR7;
		4'd8:outBus=outR8;
		4'd9:outBus=outR9;
		4'd10:outBus=outR10;
		4'd11:outBus=outR11;
		4'd12:outBus=outR12;
		4'd13:outBus=outR13;
		4'd14:outBus=outR14;
		4'd15:outBus=outR15;
		4'd16:outBus=outR16;
		4'd17:outBus=outR17;
		4'd18:outBus=outR18;
		4'd19:outBus=outR19;
		4'd20:outBus=outR20;
		4'd21:outBus=outR21;
		4'd22:outBus=outR22;
		4'd23:outBus=outR23;
		4'd24:outBus=outR24;
		4'd25:outBus=outR25;
		4'd26:outBus=outR26;
		4'd27:outBus=outR27;
		4'd28:outBus=outR28;
		4'd29:outBus=outR29;
		4'd30:outBus=outR30;
		4'd31:outBus=outR31;
	endcase
endmodule

module registerFile(input clk, input reset, input regWrite, input [4:0] rs, input [4:0] rt,input [4:0] rd, 
input [31:0] writeData, output [31:0] outR0, output [31:0] outR1);
	
	wire [31:0] decOut;
	wire [31:0] outR00, outR2, outR3, outR4, outR5, outR6, outR7,
					outR8,outR9, outR10, outR11, outR12, outR13, outR14, outR15,
					outR16,outR17, outR18, outR19, outR20, outR21, outR22, outR23,
					outR24,outR25, outR26, outR27, outR28, outR29, outR30, outR31;
	decoder dec(rd,decOut);
	registerSet rSet( clk, reset, regWrite,decOut, writeData,
							outR00,outR11, outR2, outR3, outR4, outR5, outR6, outR7,
							outR8,outR9, outR10, outR11, outR12, outR13, outR14, outR15,
							outR16,outR17, outR18, outR19, outR20, outR21, outR22, outR23,
							outR24,outR24, outR26, outR27, outR28, outR29, outR30, outR31);
	mux32to1 mux32_1_1( outR00,outR11, outR2, outR3, outR4, outR5, outR6, outR7,
							outR8,outR9, outR10, outR11, outR12, outR13, outR14, outR15,
							outR16,outR17, outR18, outR19, outR20, outR21, outR22, outR23,
							outR24,outR24, outR26, outR27, outR28, outR29, outR30, outR31,
							rs, outR0 );
	mux32to1 mux32_1_2( outR00,outR11, outR2, outR3, outR4, outR5, outR6, outR7,
							outR8,outR9, outR10, outR11, outR12, outR13, outR14, outR15,
							outR16,outR17, outR18, outR19, outR20, outR21, outR22, outR23,
							outR24,outR24, outR26, outR27, outR28, outR29, outR30, outR31,
							rt, outR1 );
endmodule
//Register Memory Code Ends



module control_CKT(input [5:0] opcode, input [5:0] funcode, output reg regwrite, output reg as, output reg aluIn1sel, output reg [2:0] outputsel,
						 output reg regwritesel, output reg [1:0] aluIn2sel, output reg [1:0] lowsel, output reg [1:0] highsel, output reg hiW, output reg lowW,
						 output reg [1:0] pcVal, output reg [1:0] destsel, output reg mw, output reg mr, output reg b, output reg [3:0] aluctrl);
						 
						 
						 //input [5:0] opcode;
						 //input [5:0] funcode;
						 
						 always @(opcode or funcode)
						 
						 begin
							
							case(opcode)
								6'd0:
									begin 
																			
										case(funcode)
											6'd32:  //add
												begin
													regwrite = 1'b1;
													//as = 0;
													aluIn1sel = 1'b1;
													outputsel = 3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =
													//highsel= 
													hiW = 1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw = 1'b0;
													mr =1'b0;
													b =1'b0;
													aluctrl =4'b0000;
												end
												
											6'd36: //and
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 0;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =
													//highsel=
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end												
											
											6'd26: //div
												begin
													aluctrl = 4'd0;
													regwrite =1'b0;
													//as = 0;
													aluIn1sel =1'b1;
													//outputsel =3'b010;
													//regwritesel = 0;
													aluIn2sel = 2'b10;
													lowsel = 2'b00;
													highsel= 2'b00;
													hiW =1'b1;
													lowW = 1'b1;
													pcVal = 2'b01;
													//destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd24: //mult
												begin
													aluctrl = 4'd0;
													regwrite =1'b0;
													//as = 1'b0;
													aluIn1sel =1'b1;
													//outputsel =3'b010;
													//regwritesel = 0;
													aluIn2sel = 2'b10;
													lowsel = 2'b00;
													highsel= 2'b00;
													hiW =1'b1;
													lowW = 1'b1;
													pcVal = 2'b01;
													//destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd34: // sub
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 1'b0;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =2'b
													//highsel=2'b
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd39: // nor
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 1'b0;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =2'b
													//highsel=2'b
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd37: // or
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 1'b0;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =2'b
													//highsel=2'b
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end	
										6'd38: // xor
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =2'b0
													//highsel=2'b0
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end	
										6'd0: // sll
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													aluIn1sel =1'b0;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =2'b0
													//highsel=2'b0
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd4: // sllv
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =2'b0
													//highsel=2'b0
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd3: // sra
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													aluIn1sel =1'b0;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =1'b0
													//highsel=1'b0
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd7: // srav
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =2'b0
													//highsel=2'b0
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd2: // srl
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													aluIn1sel =1'b0;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =1'b0
													//highsel=1'b0
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd4: // srlv
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =1'b0
													//highsel=1'b0
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd42: // slt
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =2'b0
													//highsel=2'b0
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd16: // mfhi
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													//aluIn1sel =1'b0;
													outputsel =3'b000;
													regwritesel = 1'b0;
													//aluIn2sel = 2'b10;
													//lowsel =2'b0
													//highsel=2'b0
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd18: // mfl0
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													//aluIn1sel =1'b0;
													outputsel =3'b001;
													regwritesel = 1'b0;
													//aluIn2sel = 2'b10;
													//lowsel =2'b0
													//highsel=2'b0
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd17: // mthi
												begin
													aluctrl = 4'b0000;
													regwrite =1'b0;
													//as = 0;
													//aluIn1sel =1'b0;
													//outputsel =3'b000;
													//regwritesel = 1'b0;
													//aluIn2sel = 2'b10;
													//lowsel =1'b1;
													highsel=2'b01;
													hiW =1'b1;
													lowW = 1'b0;
													pcVal = 2'b01;
													//destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd19: // mtl0
												begin
													aluctrl = 4'b0000;
													regwrite =1'b0;
													//as = 0;
													//aluIn1sel =1'b0;
													//outputsel =3'b000;
													//regwritesel = 1'b0;
													//aluIn2sel = 2'b10;
													//lowsel =1'b1
													highsel=2'b00;
													hiW = 1'b0;
													lowW = 1'b1;
													pcVal = 2'b01;
													//destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end	
										6'd9: // jalr
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													//aluIn1sel =1'b0;
													//outputsel =3'b000;
													regwritesel = 1'b1;
													//aluIn2sel = 2'b10;
													//lowsel =2'b1
													//highsel=2'b0;
													hiW = 1'b0;
													lowW = 1'b0;
													pcVal = 2'b00;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd8: // jr
												begin
													aluctrl = 4'b0000;
													regwrite =1'b0;
													//as = 0;
													//aluIn1sel =1'b0;
													//outputsel =3'b000;
													//regwritesel = 1'b1;
													//aluIn2sel = 2'b10;
													//lowsel =2'b1
													//highsel=2'b0;
													hiW = 1'b0;
													lowW = 1'b0;
													pcVal = 2'b00;
													//destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
											
										endcase
									end
								6'd28: //R type with opcode 28
									begin
										case(funcode)
											6'd2:  // mul
												begin
													aluctrl = 4'b0000;
													regwrite =1'b1;
													//as = 0;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel =2'b1
													//highsel=2'b0;
													hiW = 1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd0: //madd
											begin
												aluctrl = 4'b0000;
													regwrite =1'b0;
													as = 1'b0;
													aluIn1sel =1'b1;
													//outputsel =3'b000;
													//regwritesel = 1'b1;
													aluIn2sel = 2'b10;
													lowsel =2'b01;
													highsel=2'b01;
													hiW = 1'b1;
													lowW = 1'b1;
													pcVal = 2'b01;
													//destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										6'd4: //msub
												begin
													aluctrl = 4'd0;
													regwrite =1'b0;
													as = 1'b1;
													aluIn1sel =1'b1;
													//outputsel =3'b010;
													//regwritesel = 0;
													aluIn2sel = 2'b10;
													lowsel = 2'b01;
													highsel= 2'b01;
													hiW =1'b1;
													lowW = 1'b1;
													pcVal = 2'b01;
													//destsel = 2'b00;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
										endcase
									end
								6'd8: //addi
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 1'b1;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b01;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b01;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
								6'd12: //andi
												begin
													aluctrl = 4'd1;
													regwrite =1'b1;
													//as = 1'b1;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b01;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b01;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
								6'd13: //ori
												begin
													aluctrl = 4'd7;
													regwrite =1'b1;
													//as = 1'b1;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b00;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b01;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
								6'd14: //xori
												begin
													aluctrl = 4'd8;
													regwrite =1'b1;
													//as = 1'b1;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b00;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b01;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
								6'd15: //lui
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 1'b1;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b00;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b01;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
								6'd10: //slti
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 1'b1;
													aluIn1sel =1'b1;
													outputsel =3'b010;
													regwritesel = 1'b0;
													aluIn2sel = 2'b01;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b01;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
								6'd4: //beq
												begin
													aluctrl = 4'd0;
													regwrite =1'b0;
													//as = 1'b1;
													aluIn1sel =1'b1;
													//outputsel =3'b010;
													//regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													//destsel = 2'b01;
													mw =1'b0;
													mr =1'b0;
													b =1'b1;
												end					
								6'd5: //bne
												begin
													aluctrl = 4'd0;
													regwrite =1'b0;
													//as = 1'b1;
													aluIn1sel =1'b1;
													//outputsel =3'b010;
													//regwritesel = 1'b0;
													aluIn2sel = 2'b10;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													//destsel = 2'b01;
													mw =1'b0;
													mr =1'b0;
													b =1'b1;
												end
								6'd32: //lb
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 1'b1;
													aluIn1sel =1'b1;
													outputsel =3'b011;
													regwritesel = 1'b0;
													aluIn2sel = 2'b01;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b01;
													mw =1'b0;
													mr =1'b1;
													b =1'b0;
												end
									6'd36: //lui
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 1'b1;
													aluIn1sel =1'b1;
													outputsel =3'b100;
													regwritesel = 1'b0;
													aluIn2sel = 2'b01;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b01;
													mw =1'b0;
													mr =1'b1;
													b =1'b0;
												end
								6'd33: //lh
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 1'b1;
													aluIn1sel =1'b1;
													outputsel =3'b101;
													regwritesel = 1'b0;
													aluIn2sel = 2'b01;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b01;
													mw =1'b0;
													mr =1'b1;
													b =1'b0;
												end
								6'd37: //lhu
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 1'b1;
													aluIn1sel =1'b1;
													outputsel =3'b110;
													regwritesel = 1'b0;
													aluIn2sel = 2'b01;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b01;
													mw =1'b0;
													mr =1'b1;
													b =1'b0;
												end
							6'd15: //lw
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 1'b1;
													aluIn1sel =1'b1;
													outputsel =3'b111;
													regwritesel = 1'b0;
													aluIn2sel = 2'b01;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													destsel = 2'b01;
													mw =1'b0;
													mr =1'b1;
													b =1'b0;
												end						
								6'd40: //sb
												begin
													aluctrl = 4'd0;
													regwrite =1'b0;
													//as = 1'b1;
													aluIn1sel =1'b1;
													//outputsel =3'b010;
													//regwritesel = 1'b0;
													aluIn2sel = 2'b01;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													//destsel = 2'b01;
													mw =1'b1;
													mr =1'b0;
													b =1'b0;
												end
							6'd41: // sh
												begin
													aluctrl = 4'd0;
													regwrite =1'b0;
													//as = 1'b1;
													aluIn1sel =1'b1;
													//outputsel =3'b010;
													//regwritesel = 1'b0;
													aluIn2sel = 2'b01;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													//destsel = 2'b01;
													mw =1'b1;
													mr =1'b0;
													b =1'b0;
												end
							6'd43: //lui
												begin
													aluctrl = 4'd0;
													regwrite =1'b0;
													//as = 1'b1;
													aluIn1sel =1'b1;
													//outputsel =3'b010;
													//regwritesel = 1'b0;
													aluIn2sel = 2'b00;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b01;
													//destsel = 2'b01;
													mw =1'b1;
													mr =1'b0;
													b =1'b0;
												end
								6'd2: // j
												begin
													aluctrl = 4'd0;
													regwrite =1'b0;
													//as = 1'b1;
													//aluIn1sel =1'b1;
													//outputsel =3'b010;
													//regwritesel = 1'b0;
													//aluIn2sel = 2'b00;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b10;
													//destsel = 2'b01;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end
									6'd3: //jal
												begin
													aluctrl = 4'd0;
													regwrite =1'b1;
													//as = 1'b1;
													//aluIn1sel =1'b1;
													//outputsel =3'b010;
													regwritesel = 1'b1;
													//aluIn2sel = 2'b00;
													//lowsel = 2'b01;
													//highsel= 2'b01;
													hiW =1'b0;
													lowW = 1'b0;
													pcVal = 2'b10;
													destsel = 2'b10;
													mw =1'b0;
													mr =1'b0;
													b =1'b0;
												end	
												
							endcase
						end
						 
endmodule 

// ALU Unit Code 
module alu(input [31:0] aluIn1, input [31:0] aluIn2,input [3:0] aluOp, output reg [31:0] aluOut1,output reg [31:0] aluOut2, output  reg branchFlag);
	always@(aluIn1 or aluIn2 or aluOp)
	begin
		case(aluOp)
			4'b0000: // 0 -> add
				begin
					aluOut1 = aluIn1 + aluIn2;		
				end
			4'b0001:	//	1 -> and
				begin 
					aluOut1 = aluIn1 & aluIn2;		
				end
			4'b0010:	//	2 -> sub
				begin
					aluOut1=aluIn1 - aluIn2;	
				end
			4'b0011:	//3 -> div
				begin
					aluOut1=aluIn1 / aluIn2;	
					aluOut2=aluIn2  % aluIn2; 	
				end
				
			4'b0100:	//	4 -> mult
				begin
					{aluOut2,aluOut1}=aluIn1 * aluIn2;
				end
						
			
				
			4'b0101:	// 5 -> nor
				begin
					aluOut1=~(aluIn1 | aluIn2);
				end
			4'b0110: // 6 -> or
				begin
					aluOut1=aluIn1 | aluIn2;
				end
				
			4'b0111: // 7 -> xor
				begin
					aluOut1=aluIn1 ^ aluIn2;
				end
			4'b1000: // 8 -> sl
				begin
					aluOut1=aluIn1 << aluIn2;
				end
			
			4'b1001: // 9 -> sra
				begin 
					aluOut1=aluIn1 >>> aluIn2;
				end
				
			
				
			4'b1010:	//	10-> sr
				begin
					aluOut1=aluIn1 >> aluIn2;	
				end
			
			4'b1011: // 11-> slt
				begin
					if(aluIn1 < aluIn2 )
						begin
							aluOut1 = 32'd1;
						end
					else
						begin
							aluOut1 = 32'd0;
						end
				end
			4'd1100: // 12-> shift 16 bit
				aluOut1 = aluIn2 << 16;
			4'd1101: // 13-> branch equal
				begin
						if(aluIn1==aluIn2)
							branchFlag=1'b1;
						else
							branchFlag=1'b0;
				end
			4'd14:  // 14-> branch not equal
				begin
						if(aluIn1!=aluIn2)
							branchFlag=1'b1;
						else
							branchFlag=1'b0;
				end
			4'd15: // 15 -> NOP
				aluOut1 = 32'd0;
		endcase
	end
endmodule

module alu_ctrl(input [3:0] aluctrl, input [5:0] funcode, output reg [3:0] aluOp);
	always@(aluctrl,funcode)
		case(aluctrl)
			4'b0000:
				begin
					case(funcode)
						6'd32:
							aluOp=4'd0;
						6'd36:
							aluOp= 4'd1;
						6'd26:
							aluOp= 4'd3;
						6'd24:
							aluOp= 4'd4;
						6'd34:
							aluOp= 4'd2;
						6'd39:
							aluOp= 4'd5;
						6'd37:
							aluOp= 4'd6;
						6'd38:
							aluOp= 4'd7;
						6'd0:
							aluOp= 4'd8;
						6'd4:
							aluOp= 4'd8;
						6'd3:
							aluOp= 4'd9;
						6'd7:
							aluOp= 4'd9;
						6'd2:
							aluOp= 4'd10;
						6'd6:
							aluOp= 4'd10;
						6'd42:
							aluOp= 4'd11;
						6'd16:
							aluOp= 4'd15;
						6'd18:
							aluOp= 4'd15;
						6'd17:
							aluOp= 4'd15;
						6'd19:
							aluOp= 4'd15;
						6'd9:
							aluOp= 4'd15;
						6'd8:
							aluOp= 4'd15;
					endcase	
				end
		endcase
endmodule


