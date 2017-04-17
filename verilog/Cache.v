`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:52 04/15/2017 
// Design Name: 
// Module Name:    Cache 
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
//This has to be top module
module WayPredictiveCache(input Clock, input Reset , output reg [31:0] data);

	WAY way0(ViIn, TagIn, DataIn ,ViOut, TagOut, DataOut, Clock, WayWr, WayRd, SetNo);
	WAY way1(ViIn, TagIn, DataIn ,ViOut, TagOut, DataOut, Clock, WayWr, WayRd, SetNo);
	WAY way2(ViIn, TagIn, DataIn ,ViOut, TagOut, DataOut, Clock, WayWr, WayRd, SetNo);
	WAY way3(ViIn, TagIn, DataIn ,ViOut, TagOut, DataOut, Clock, WayWr, WayRd, SetNo);
	WAY way4(ViIn, TagIn, DataIn ,ViOut, TagOut, DataOut, Clock, WayWr, WayRd, SetNo);
	WAY way5(ViIn, TagIn, DataIn ,ViOut, TagOut, DataOut, Clock, WayWr, WayRd, SetNo);
	WAY way6(ViIn, TagIn, DataIn ,ViOut, TagOut, DataOut, Clock, WayWr, WayRd, SetNo);
	WAY way7(ViIn, TagIn, DataIn ,ViOut, TagOut, DataOut, Clock, WayWr, WayRd, SetNo);
	


endmodule


module WAY(ViIn, TagIn, DataIn ,ViOut, TagOut, DataOut, Clock, WayWr, WayRd, SetNo);
	output reg ViOut;
	output reg [21:0] TagOut;
	output reg [127:0] DataOut;
	
	input ViIn, Clock, WayRd, WayWr;
	input [4:0] SetNo;
	input [21:0] TagIn;
	input [127:0] DataIn;

	reg [150:0] WAY [0:31];
	
	initial begin 
		WAY[0] = {1'd1, 22'd0, 128'd0};
		WAY[1] = {1'd1, 22'd0, 128'd0};
		WAY[2] = {1'd1, 22'd0, 128'd0};
		WAY[3] = {1'd1, 22'd0, 128'd0};
		WAY[4] = {1'd1, 22'd0, 128'd0};
		
		WAY[5] = {1'd1, 22'd0, 128'd0};
		WAY[6] = {1'd1, 22'd0, 128'd0};
		WAY[7] = {1'd1, 22'd0, 128'd0};
		WAY[8] = {1'd1, 22'd0, 128'd0};
		WAY[9] = {1'd1, 22'd0, 128'd0};
		
		WAY[10] = {1'd1, 22'd0, 128'd0};
		WAY[11] = {1'd1, 22'd0, 128'd0};
		WAY[12] = {1'd1, 22'd0, 128'd0};
		WAY[13] = {1'd1, 22'd0, 128'd0};
		WAY[14] = {1'd1, 22'd0, 128'd0};
		
		WAY[15] = {1'd1, 22'd0, 128'd0};
		WAY[16] = {1'd1, 22'd0, 128'd0};
		WAY[17] = {1'd1, 22'd0, 128'd0};
		WAY[18] = {1'd1, 22'd0, 128'd0};
		WAY[19] = {1'd1, 22'd0, 128'd0};
		
		WAY[20] = {1'd1, 22'd0, 128'd0};
		WAY[21] = {1'd1, 22'd0, 128'd0};
		WAY[22] = {1'd1, 22'd0, 128'd0};
		WAY[23] = {1'd1, 22'd0, 128'd0};
		WAY[24] = {1'd1, 22'd0, 128'd0};
		
		WAY[25] = {1'd1, 22'd0, 128'd0};
		WAY[26] = {1'd1, 22'd0, 128'd0};
		WAY[27] = {1'd1, 22'd0, 128'd0};
		WAY[28] = {1'd1, 22'd0, 128'd0};
		WAY[29] = {1'd1, 22'd0, 128'd0};
		WAY[30] = {1'd1, 22'd0, 128'd0};
		WAY[31] = {1'd1, 22'd0, 128'd0};
		
	end
	
	always @ (negedge Clock)
		begin
			if(WayRd)
				begin
					ViOut   = WAY[SetNo][150];
					TagOut  = WAY[SetNo][149:128];
					DataOut = WAY[SetNo] [127:0];
				end
			else if (WayWr)
				begin
					WAY[SetNo][1] 			= ViIn;
					WAY[SetNo][149:128]	= TagIn;
					WAY[SetNo] [127:0]	= DataIn;
				end
		end
	
endmodule
//----------------------------------------------------------------------------------------------------

module TristateTag(TagIn, Enable, TagOut, Clock);
		output reg [21:0] TagOut;
		
		
		input [21:0]TagIn;
		input Enable, Clock;
		
		always @ (negedge Clock or Enable)
		begin
			if(Enable)
				TagOut = TagIn;
			else
				TagOut = 22'dz;
		end

endmodule


//--------------------------------------------------------------------------------------------------------


module SetDecoder( SetNoIn, SetNoOut);

	output reg [4:0]SetNoOut;

	input [4:0] SetNoIn;	
		
	always @(SetNoIn)
		begin	
			case(SetNoIn)
					5'd0: SetNoOut=5'd0;
					5'd1: SetNoOut=5'd1;
					5'd2: SetNoOut=5'd2;
					5'd3: SetNoOut=5'd3;
					5'd4: SetNoOut=5'd4;
					5'd5: SetNoOut=5'd5;
					5'd6: SetNoOut=5'd6;
					5'd7: SetNoOut=5'd7;
					
					5'd8:  SetNoOut=5'd7;
					5'd9:  SetNoOut=5'd8;
					5'd10: SetNoOut=5'd10;
					5'd11: SetNoOut=5'd11;
					5'd12: SetNoOut=5'd12;
					5'd13: SetNoOut=5'd13;
					5'd14: SetNoOut=5'd14;
					5'd15: SetNoOut=5'd15;
					
					5'd16: SetNoOut=5'd16;
					5'd17: SetNoOut=5'd17;
					5'd18: SetNoOut=5'd18;
					5'd19: SetNoOut=5'd19;
					5'd20: SetNoOut=5'd20;
					5'd21: SetNoOut=5'd21;
					5'd22: SetNoOut=5'd22;
					5'd23: SetNoOut=5'd0;
					
					5'd24: SetNoOut=5'd24;
					5'd25: SetNoOut=5'd25;
					5'd26: SetNoOut=5'd26;
					5'd27: SetNoOut=5'd27;
					5'd28: SetNoOut=5'd28;
					5'd29: SetNoOut=5'd29;
					5'd30: SetNoOut=5'd30;
					5'd31: SetNoOut=5'd31;
			endcase
	end	
endmodule

//----------------------------------------------------------------------------------------------------------

module Comparator(Input1, Input2, Output, ComEn);

	output reg Output;
	
	input ComEn;
	input [21:0] Input1, Input2; 
	
	always @ (Input1)
		begin
			if(Input1 == Input2)
				Output = 1'b1;
			else 
				Output =	1'b0;
		end
		
endmodule

//-------------------------------------------------------------------------------------------------------------
//logicfor maintaining MRU
module MRU(MruIn, MruOut, Clock, MruUpdate, SetNo, MruRd);

	output reg [2:0] MruOut;
	
	input Clock, MruUpdate, MruRd;
	input [2:0] MruIn; // from priority out (after hit found)
	input [4:0] SetNo;

	reg [4:0] MRU_set[0:31];
	
	initial begin
		MRU_set[0]  = 3'd0;
		MRU_set[1]  = 3'd0;
		MRU_set[2]  = 3'd0;
		MRU_set[3]  = 3'd0;
		MRU_set[4]  = 3'd0;
		MRU_set[5]  = 3'd0;
		MRU_set[6]  = 3'd0;
		MRU_set[7]  = 3'd0;
	
		MRU_set[8]  = 3'd0;
		MRU_set[9]  = 3'd0;
		MRU_set[10] = 3'd0;
		MRU_set[11] = 3'd0;
		MRU_set[12] = 3'd0;
		MRU_set[13] = 3'd0;
		MRU_set[14] = 3'd0;
		MRU_set[15] = 3'd0;
		
		MRU_set[16] = 3'd0;
		MRU_set[17] = 3'd0;
		MRU_set[18] = 3'd0;
		MRU_set[19] = 3'd0;
		MRU_set[20] = 3'd0;
		MRU_set[21] = 3'd0;
		MRU_set[22] = 3'd0;
		MRU_set[23] = 3'd0;
		
		MRU_set[24] = 3'd0;
		MRU_set[25] = 3'd0;
		MRU_set[26] = 3'd0;
		MRU_set[27] = 3'd0;
		MRU_set[28] = 3'd0;
		MRU_set[29] = 3'd0;
		MRU_set[30] = 3'd0;
		MRU_set[31] = 3'd0;
	end
	
	always @ (negedge Clock or MruIn)
		begin
			if(MruUpdate)
				MRU_set[SetNo] = MruIn;
			else if(MruRd)
				MruOut = MRU_set[SetNo];
		end
			
			
endmodule
// MRU end here
//-------------------------------------------------------------------------------------------------


// module contains logic for wayprediction, tagcomparision, hit calculation (may not be good idea to combine all in one)
module Way_prediction(MruOut, Way0TagIn, Way1TagIn, Way2TagIn, Way3TagIn, Way4TagIn, Way5TagIn, Way6TagIn, Way7TagIn, PredictedTagOut, UsePrediction,
							 TagOut0, TagOut1, TagOut2, TagOut3,TagOut4, TagOut5, TagOut6, TagOut7, RealTag, hit, Clock, Result,
							 Enable0, Enable1, Enable2, Enable3, Enable4, Enable5, Enable6, Enable7,ComEn0,ComEn1, ComEn2, ComEn3, ComEn4, ComEn5, ComEn6,ComEn7,
							 Way0Vi,Way1Vi,Way2Vi,Way3Vi,Way4Vi,Way5Vi,Way6Vi,Way7Vi
							 );
		
		

		//wire  [21:0]
		input UsePrediction, Clock, Way0Vi,Way1Vi,Way2Vi,Way3Vi,Way4Vi,Way5Vi,Way6Vi,Way7Vi;
		input [2:0] MruOut;
		input [21:0] Way0TagIn, Way1TagIn, Way2TagIn, Way3TagIn, Way4TagIn, Way5TagIn, Way6TagIn, Way7TagIn, RealTag;
		
		output reg [21:0] PredictedTagOut, TagOut0, TagOut1, TagOut2, TagOut3,TagOut4, TagOut5, TagOut6, TagOut7; // tristate buffer signal
		output reg Result, Enable0, Enable1, Enable2, Enable3, Enable4, Enable5, Enable6, Enable7,
					  ComEn0,ComEn1, ComEn2, ComEn3, ComEn4, ComEn5, ComEn6,ComEn7;
		output reg [7:0]hit;
		
		TristateTag Tway0(Way0TagIn,Enable0,TagOut0,Clock);
		TristateTag Tway1(Way1TagIn,Enable1,TagOut1,Clock);
		TristateTag Tway2(Way2TagIn,Enable2,TagOut2,Clock);
		TristateTag Tway3(Way3TagIn,Enable3,TagOut3,Clock);
		TristateTag Tway4(Way4TagIn,Enable4,TagOut4,Clock);
		TristateTag Tway5(Way5TagIn,Enable5,TagOut5,Clock);
		TristateTag Tway6(Way6TagIn,Enable6,TagOut6,Clock);
		TristateTag Tway7(Way7TagIn,Enable7,TagOut7,Clock);
		
		Comparator TagComp0(TagOut0, RealTag,Result0, ComEn0);
		Comparator TagComp1(TagOut1, RealTag,Result1, ComEn1);
		Comparator TagComp2(TagOut2, RealTag,Result2, ComEn2);
		Comparator TagComp3(TagOut3, RealTag,Result3, ComEn3);
		Comparator TagComp4(TagOut4, RealTag,Result4, ComEn4);
		Comparator TagComp5(TagOut5, RealTag,Result5, ComEn5);
		Comparator TagComp6(TagOut6, RealTag,Result6, ComEn6);
		Comparator TagComp7(TagOut7, RealTag,Result7, ComEn7);
		
		and(Result00, Result0, Way0Vi);
		and(Result01, Result1, Way0Vi);
		and(Result02, Result2, Way0Vi);
		and(Result03, Result3, Way0Vi);
		and(Result04, Result4, Way0Vi);
		and(Result05, Result5, Way0Vi);
		and(Result06, Result6, Way0Vi);
		and(Result07, Result7, Way0Vi);
		
		
		always @(Way0TagIn, Way1TagIn, Way2TagIn, Way3TagIn, Way4TagIn, Way5TagIn, Way6TagIn, Way7TagIn)
		begin
			if (UsePrediction)
				begin
					case(MruOut)
						3'd0:
							begin
								Enable0 = 1'b1;
								Enable1 = 1'b0; Enable2 = 1'b0; Enable3 = 1'b0; Enable4 = 1'b0; Enable5 = 1'b0; Enable6 = 1'b0; Enable7 = 1'b0;
								ComEn0  = 1'b1;
								ComEn1  = 1'b0; ComEn2  = 1'b0; ComEn3  = 1'b0; ComEn4  = 1'b0; ComEn5  = 1'b0; ComEn6  = 1'b0; ComEn7  = 1'b0;
								
								if(Result00)
								 begin
									hit = 8'b00000001;
								 end
							end
						3'd1:
							begin
								Enable1 = 1'b1;
								Enable0 = 1'b0; Enable2 = 1'b0; Enable3 = 1'b0; Enable4 = 1'b0; Enable5 = 1'b0; Enable6 = 1'b0; Enable7 = 1'b0;
								ComEn1  = 1'b1;
								ComEn0  = 1'b0; ComEn2  = 1'b0; ComEn3  = 1'b0; ComEn4  = 1'b0; ComEn5  = 1'b0; ComEn6  = 1'b0; ComEn7  = 1'b0;
								if(Result01)
								 begin
									hit = 8'b00000010;
								 end
							end
						3'd2:
							begin
								Enable2 = 1'b1;
								Enable1 = 1'b0; Enable0 = 1'b0; Enable3 = 1'b0; Enable4 = 1'b0; Enable5 = 1'b0; Enable6 = 1'b0; Enable7 = 1'b0;
								ComEn2  = 1'b1;
								ComEn1  = 1'b0; ComEn0  = 1'b0; ComEn3  = 1'b0; ComEn4  = 1'b0; ComEn5  = 1'b0; ComEn6  = 1'b0; ComEn7  = 1'b0;
								if(Result02)
								 begin
									hit = 8'b00000100;
								 end
							end
						3'd3:
							begin
								Enable3 = 1'b1;
								Enable1 = 1'b0; Enable2 = 1'b0; Enable0 = 1'b0; Enable4 = 1'b0; Enable5 = 1'b0; Enable6 = 1'b0; Enable7 = 1'b0;
								ComEn3  = 1'b1;
								ComEn1  = 1'b0; ComEn2  = 1'b0; ComEn0  = 1'b0; ComEn4  = 1'b0; ComEn5  = 1'b0; ComEn6  = 1'b0; ComEn7  = 1'b0;
								if(Result03)
								 begin
									hit = 8'b00001000;
								 end
							end
						3'd4:
							begin
								Enable4 = 1'b1;
								Enable1 = 1'b0; Enable2 = 1'b0; Enable3 = 1'b0; Enable0 = 1'b0; Enable5 = 1'b0; Enable6 = 1'b0; Enable7 = 1'b0;
								ComEn4  = 1'b1;
								ComEn1  = 1'b0; ComEn2  = 1'b0; ComEn3  = 1'b0; ComEn0  = 1'b0; ComEn5  = 1'b0; ComEn6  = 1'b0; ComEn7  = 1'b0;
								if(Result04)
								 begin
									hit = 8'b00010000;
								 end
							end						
						3'd5:
							begin
								Enable5 = 1'b1;
								Enable1 = 1'b0; Enable2 = 1'b0; Enable3 = 1'b0; Enable4 = 1'b0; Enable0 = 1'b0; Enable6 = 1'b0; Enable7 = 1'b0;
								ComEn5  = 1'b1;
								ComEn1  = 1'b0; ComEn2  = 1'b0; ComEn3  = 1'b0; ComEn4  = 1'b0; ComEn0  = 1'b0; ComEn6  = 1'b0; ComEn7  = 1'b0;
								if(Result05)
								 begin
									hit = 8'b00100000;
								 end
							end
						3'd6:
							begin
								Enable6 = 1'b1;
								Enable1 = 1'b0; Enable2 = 1'b0; Enable3 = 1'b0; Enable4 = 1'b0; Enable5 = 1'b0; Enable0 = 1'b0; Enable7 = 1'b0;
								ComEn6  = 1'b1;
								ComEn1  = 1'b0; ComEn2  = 1'b0; ComEn3  = 1'b0; ComEn4  = 1'b0; ComEn5  = 1'b0; ComEn0  = 1'b0; ComEn7  = 1'b0;
								if(Result06)
								 begin
									hit = 8'b01000000;
								 end
							end
						3'd7:
							begin
								Enable7 = 1'b1;
								Enable1 = 1'b0; Enable2 = 1'b0; Enable3 = 1'b0; Enable4 = 1'b0; Enable5 = 1'b0; Enable6 = 1'b0; Enable0 = 1'b0;
								ComEn7  = 1'b1;
								ComEn1  = 1'b0; ComEn2  = 1'b0; ComEn3  = 1'b0; ComEn4  = 1'b0; ComEn5  = 1'b0; ComEn6  = 1'b0; ComEn0  = 1'b0;
								if(Result07)
								 begin
									hit = 8'b10000000;
								 end
							end
					endcase
				end
			else
				begin
					Enable0 = 1'b1;Enable1 = 1'b1; Enable2 = 1'b1; Enable3 = 1'b1; Enable4 = 1'b1; Enable5 = 1'b1; Enable6 = 1'b1; Enable7 = 1'b1;
					ComEn0  = 1'b1;ComEn1  = 1'b1; ComEn2  = 1'b1; ComEn3  = 1'b1; ComEn4  = 1'b1; ComEn5  = 1'b1; ComEn6  = 1'b1; ComEn7  = 1'b1;
					
					hit[0]=Result01;
					hit[1]=Result01;
					hit[2]=Result02;
					hit[3]=Result03;
					hit[4]=Result04;
					hit[5]=Result05;
					hit[6]=Result06;
					hit[7]=Result07;
				end
			
		end

endmodule

//------------------------------------------------------------------------------------------------------


//------------------------------------------------------------------------------------------------------
// Priority decider for LRU and also goes to MRU input
module PriorityENC(hit, PriorityOut);
	output reg [2:0] PriorityOut;
	
	input [7:0] hit;
	
	always @ (hit)
		begin
			if(hit[0])
				begin
					PriorityOut = 3'd0;
				end
			if(hit[1])
				begin
					PriorityOut = 3'd1;
				end
			if(hit[2])
				begin
					PriorityOut = 3'd2;
				end
			if(hit[3])
				begin
					PriorityOut = 3'd3;
				end
			if(hit[4])
				begin
				
					PriorityOut = 3'd4;
				end
			if(hit[5])
				begin
					PriorityOut = 3'd5;
				end
			if(hit[6])
				begin
					PriorityOut = 3'd6;
				end
			if(hit[7])
				begin
					PriorityOut = 3'd7;
				end
		end
	
endmodule

//----------------------------------------------------------------------------------------------------
// Logic for maintaining LRU
module LRU(PriorityOut, VI, LruOut, Hit);
		output reg [2:0]LruOut;
		
		input Hit, VI;
		input [2:0] PriorityOut;

		
		reg [7:0] Lru_set[0:8];
		
		initial begin 
			Lru_set[0] = 8'd0;
			Lru_set[1] = 8'd0;
			Lru_set[2] = 8'd0;
			Lru_set[3] = 8'd0;
			Lru_set[4] = 8'd0;
			Lru_set[5] = 8'd0;
			Lru_set[6] = 8'd0;
			Lru_set[7] = 8'd0;
		end
		
		always @ (Hit)
			begin
				case(PriorityOut)
					3'd0 : 
						  begin
								Lru_set[0]    = 8'b01111111;
								Lru_set[1][0] = 1'b0;
								Lru_set[2][0] = 1'b0;
								Lru_set[3][0] = 1'b0;
								Lru_set[4][0] = 1'b0;
								Lru_set[5][0] = 1'b0;
								Lru_set[6][0] = 1'b0;
								Lru_set[7][0] = 1'b0;
							end
					3'd1 : 
						  begin
								Lru_set[0][1] = 1'b0;
								Lru_set[1]    = 8'b10111111;
								Lru_set[2][1] = 1'b0;
								Lru_set[3][1] = 1'b0;
								Lru_set[4][1] = 1'b0;
								Lru_set[5][1] = 1'b0;
								Lru_set[6][1] = 1'b0;
								Lru_set[7][1] = 1'b0;
							end
					3'd2 : 
						  begin
								Lru_set[0][2] = 1'b0;
								Lru_set[1][2] = 1'b0;
								Lru_set[2]    = 8'b11011111;
								Lru_set[3][2] = 1'b0;
								Lru_set[4][2] = 1'b0;
								Lru_set[5][2] = 1'b0;
								Lru_set[6][2] = 1'b0;
								Lru_set[7][2] = 1'b0;
							end
					3'd3 : 
						  begin
								Lru_set[0][3] = 1'b0;
								Lru_set[1][3] = 1'b0;
								Lru_set[2][3] = 1'b0;
								Lru_set[3]    = 8'b11101111;
								Lru_set[4][3] = 1'b0;
								Lru_set[5][3] = 1'b0;
								Lru_set[6][3] = 1'b0;
								Lru_set[7][3] = 1'b0;
							end
					3'd4 : 
						  begin
								Lru_set[0][4] = 1'b0;
								Lru_set[1][4] = 1'b0;
								Lru_set[2][4] = 1'b0;
								Lru_set[3][4] = 1'b0;
								Lru_set[4]    = 8'b11110111;
								Lru_set[5][4] = 1'b0;
								Lru_set[6][4] = 1'b0;
								Lru_set[7][4] = 1'b0;
							end
					3'd5 : 
						  begin
								Lru_set[0][5] = 1'b0;
								Lru_set[1][5] = 1'b0;
								Lru_set[2][5] = 1'b0;
								Lru_set[3][5] = 1'b0;
								Lru_set[4][5] = 1'b0;
								Lru_set[5]    = 8'b11111011;
								Lru_set[6][5] = 1'b0;
								Lru_set[7][5] = 1'b0;
							end
						
					3'd6 : 
						  begin
								Lru_set[0][6] = 1'b0;
								Lru_set[1][6] = 1'b0;
								Lru_set[2][6] = 1'b0;
								Lru_set[3][6] = 1'b0;
								Lru_set[4][6] = 1'b0;
								Lru_set[5][6] = 1'b0;
								Lru_set[6]    = 8'b11111101;
								Lru_set[7][6] = 1'b0;
							end
					3'd7 : 
						  begin
								Lru_set[0][7] = 1'b0;
								Lru_set[1][7] = 1'b0;
								Lru_set[2][7] = 1'b0;
								Lru_set[3][7] = 1'b0;
								Lru_set[4][7] = 1'b0;
								Lru_set[5][7] = 1'b0;
								Lru_set[6][7] = 1'b0;
								Lru_set[7]    = 8'b11111110;
							end	
					endcase
					
					if (Lru_set[0] == 0)
							LruOut = 3'd0;
					else if(Lru_set[1]==0)
							LruOut = 3'd1;
					else if(Lru_set[2]==0)
							LruOut = 3'd2;
					else if(Lru_set[3]==0)
							LruOut = 3'd3;
					else if(Lru_set[4]==0)
							LruOut = 3'd4;
					else if(Lru_set[5]==0)
							LruOut = 3'd5;
					else if(Lru_set[6]==0)
							LruOut = 3'd6;
					else if(Lru_set[7]==0)
							LruOut = 3'd7;
			end
endmodule

//----------------------------------------------------------------------------------------------------------------

//cache control ckt
module Cache_ctrl(Clock, WayWr, WayRd, MruRd, MruUpdate, UsePrediction);



endmodule
//-----------------------------------------------------------------------------------------------------------------

//2 to 1 multiplexer
module Mux2to1_3bit(Output, In0,In1, Select);
	output [2:0] Output;
	
	input [2:0] In0, In1;
	input Select;
	
	reg [2:0] Output;
	
	always @ (In0 or In1 or Select)
		begin
			case(Select)
				1'd0: Output = In0;
				1'd1: Output = In1;
			endcase
		end
endmodule
