//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input logic       [9:0] MouseX, MouseY, DrawX, DrawY,
							  input logic Clk, bg_data, pixel_clk, blank, monk_ready,mpready, 
							  input logic bloon_alive[32],
							  input logic dart_alive[8],
							  input logic [1:0]orientation[8],
							  input logic [19:0]monkfile[8],
							  input logic [19:0]pop_loc[32],
							  input logic [2:0]mcounter,
							  input logic [19:0]dartfile [8],
							  input logic [59:0]bloonfile[32],
							  input logic [7:0] lives,
							  input logic [9:0] moneyOut,
                       output logic [7:0]  Red, Green, Blue
						);

 // bit ex;                                     // Monkey exists (maybe not necessary)
logic [9:0] MonkeyX;
logic [9:0] MonkeyY;
logic [2:0] MonkeyState;                      // Ready to Shoot State (NOT IN RANGE) {init state} -> Ready to Shoot (IN RANGE) -> NOT READY 


logic [3:0] monkRed, monkGreen, monkBlue;	
logic [3:0]	bloonRed, bloonGreen, bloonBlue;
logic [3:0]	popRed, popGreen, popBlue;
logic [3:0] mouseRed, mouseGreen, mouseBlue;	
logic [3:0]	bgRed, bgGreen, bgBlue;
logic [3:0]	ggRed, ggGreen, ggBlue;
logic [3:0] fontRed0, fontGreen0, fontBlue0;
logic [3:0] fontRed1, fontGreen1, fontBlue1;
logic [3:0] fontRed2, fontGreen2, fontBlue2;
logic [3:0] fontRed3, fontGreen3, fontBlue3;
logic [3:0] fontRed4, fontGreen4, fontBlue4;
logic [3:0] fontRed5, fontGreen5, fontBlue5;
logic [3:0] fontRed6, fontGreen6, fontBlue6;

logic [3:0] life0, life1, life2;
assign life0 = (lives / 100);
assign life1 = ((lives / 10) % 10);
assign life2 = (lives % 10);

logic [3:0] money0, money1, money2;
assign money0 = (moneyOut / 100);
assign money1 = ((moneyOut / 10) % 10);
assign money2 = (moneyOut % 10);

monkey_example monk (.RelativeX(RelativeX), .RelativeY(RelativeY), .vga_clk(Clk), .blank(blank), .red(monkRed), .green(monkGreen), .blue(monkBlue));	 
redbloon_example bloon (.RelativeXB(RelativeXB), .RelativeYB(RelativeYB), .vga_clk(Clk), .blank(blank), .red(bloonRed), .green(bloonGreen), .blue(bloonBlue));
bloonpop_example bloonpop (.RelativeXP(RelativeXP), .RelativeYP(RelativeYP), .vga_clk(Clk), .blank(blank), .red(popRed), .green(popGreen), .blue(popBlue));
bgfinal_example bloonbackground (.DrawX(DrawX), .DrawY(DrawY), .vga_clk(Clk), .blank(blank), .red(bgRed), .green(bgGreen), .blue(bgBlue));
font_example live0(.relativeXF(RelativeXF0), .relativeYF(RelativeYF0), .number(life0), .vga_clk(Clk), .blank(blank), .red(fontRed0), .green(fontGreen0), .blue(fontBlue0));
font_example live1(.relativeXF(RelativeXF1), .relativeYF(RelativeYF1), .number(life1), .vga_clk(Clk), .blank(blank), .red(fontRed1), .green(fontGreen1), .blue(fontBlue1));
font_example live2(.relativeXF(RelativeXF2), .relativeYF(RelativeYF2), .number(life2), .vga_clk(Clk), .blank(blank), .red(fontRed2), .green(fontGreen2), .blue(fontBlue2));
font_example moneys0(.relativeXF(RelativeXM0), .relativeYF(RelativeYM0), .number(money0), .vga_clk(Clk), .blank(blank), .red(fontRed3), .green(fontGreen3), .blue(fontBlue3));
font_example moneys1(.relativeXF(RelativeXM1), .relativeYF(RelativeYM1), .number(money1), .vga_clk(Clk), .blank(blank), .red(fontRed4), .green(fontGreen4), .blue(fontBlue4));
font_example moneys2(.relativeXF(RelativeXM2), .relativeYF(RelativeYM2), .number(money2), .vga_clk(Clk), .blank(blank), .red(fontRed5), .green(fontGreen5), .blue(fontBlue5));
font_example round(.relativeXF(RelativeXR), .relativeYF(RelativeYR), .number(1), .vga_clk(Clk), .blank(blank), .red(fontRed6), .green(fontGreen6), .blue(fontBlue6));
mousefinal_example mouse (.RelativeXM(RelativeXM), .RelativeYM(RelativeYM), .vga_clk(Clk), .blank(blank), .red(mouseRed), .green(mouseGreen), .blue(mouseBlue));
gameover_example gameover (.RelativeXG(RelativeXG), .RelativeYG(RelativeYG), .vga_clk(Clk), .blank(blank), .red(ggRed), .green(ggGreen), .blue(ggBlue));

logic[9:0] RelativeX, RelativeY;
logic[9:0] RelativeXB, RelativeYB;
logic[9:0] RelativeXP, RelativeYP;    // POP
logic[9:0] RelativeXM, RelativeYM;
logic[9:0] RelativeXG, RelativeYG;
logic[9:0] RelativeXF0, RelativeYF0; //lives
logic[9:0] RelativeXF1, RelativeYF1;
logic[9:0] RelativeXF2, RelativeYF2;
logic[9:0] RelativeXM0, RelativeYM0; //money
logic[9:0] RelativeXM1, RelativeYM1;
logic[9:0] RelativeXM2, RelativeYM2;
logic[9:0] RelativeXR, RelativeYR;
	  
always_ff @ (posedge pixel_clk)
begin
	
	if(blank)
	begin
		if(MouseX <= DrawX && DrawX <= MouseX + 31 && MouseY<=DrawY && DrawY <= MouseY + 31 && mpready == 1)
		begin
		if(monkRed == 4'h4 && monkGreen == 4'h9 && monkBlue == 4'h2)
						begin
					Red[7:4] <= bgRed;
					Green[7:4] <= bgGreen;
					Blue[7:4] <= bgBlue;
						end
					else
					begin
					Red[7:4] <= monkRed;
					Green[7:4] <= monkGreen;
					Blue[7:4] <= monkBlue;
					end

			RelativeX <= DrawX - MouseX;
			RelativeY <= DrawY - MouseY;

		end	
			else if(lives <= 0 && 150 <= DrawX && DrawX <= 389 && 210 <= DrawY && DrawY <= 269)
		begin
			Red[7:4] <= ggRed;
			Green[7:4] <= ggGreen;
			Blue[7:4] <= ggBlue;
			RelativeXG <= DrawX - 150;
			RelativeYG <= DrawY - 210;
		end
		
		else if(MouseX <= DrawX && DrawX <= MouseX + 15 && MouseY <= DrawY && DrawY <= MouseY + 15)
		begin
		if(mouseRed == 4'h0 && mouseGreen == 4'h0 && mouseBlue == 4'h0)
						begin
					Red[7:4] <= bgRed;
					Green[7:4] <= bgGreen;
					Blue[7:4] <= bgBlue;
						end
					else
					begin
					Red[7:4] <= mouseRed;
					Green[7:4] <= mouseGreen;
					Blue[7:4] <= mouseBlue;
					end

			RelativeXM <= DrawX - MouseX;
			RelativeYM <= DrawY - MouseY;

		end	

	
				
		else if(monkfile[0] != 0 && monkfile[0][19:10] < DrawX  && DrawX <= (monkfile[0][19:10] + 31) && monkfile[0][9:0] <= DrawY && DrawY <= (monkfile[0][9:0] + 31))
				begin
					if(monkRed == 4'h4 && monkGreen == 4'h9 && monkBlue == 4'h2)
						begin
					Red[7:4] <= bgRed;
					Green[7:4] <= bgGreen;
					Blue[7:4] <= bgBlue;
						end
					else
					begin
					Red[7:4] <= monkRed;
					Green[7:4] <= monkGreen;
					Blue[7:4] <= monkBlue;
					end
					// if(orientation[0] == 0)
					// begin
					// RelativeX <= DrawX - monkfile[0][19:10];
					// RelativeY <= DrawY - monkfile[0][9:0];
					// end
					// if(orientation[0] == 1)
					// begin
					// RelativeX <= DrawY - monkfile[0][9:0];
					// RelativeY <= DrawX - monkfile[0][19:10];
					// end
					// if(orientation[0] == 2)
					// begin
					// RelativeX <= DrawX - monkfile[0][9:0];
					// RelativeY <= 31 - DrawY - monkfile[0][19:10];
					// end
					// if(orientation[0] == 3)
					// begin
					// RelativeX <= 31 - DrawY - monkfile[0][9:0];
					// RelativeY <=  DrawX - monkfile[0][19:10];
					// end

					// else
					// begin
					RelativeX <= DrawX - monkfile[0][19:10];
					RelativeY <= DrawY - monkfile[0][9:0];

					// end
				end
		
		else if(monkfile[1] != 0 && monkfile[1][19:10] < DrawX  && DrawX <= (monkfile[1][19:10] + 31) && monkfile[1][9:0] <= DrawY && DrawY <= (monkfile[1][9:0] + 31))
			begin
					if(monkRed == 4'h4 && monkGreen == 4'h9 && monkBlue == 4'h2)
						begin
					Red[7:4] <= bgRed;
					Green[7:4] <= bgGreen;
					Blue[7:4] <= bgBlue;
						end
					else
					begin
					Red[7:4] <= monkRed;
					Green[7:4] <= monkGreen;
					Blue[7:4] <= monkBlue;
					end
					RelativeX <= DrawX - monkfile[1][19:10];
					RelativeY <= DrawY - monkfile[1][9:0];
				end

		else if(monkfile[2] != 0 && monkfile[2][19:10] < DrawX  && DrawX <= (monkfile[2][19:10] + 31) && monkfile[2][9:0] <= DrawY && DrawY <= (monkfile[2][9:0] + 31))
			begin
					if(monkRed == 4'h4 && monkGreen == 4'h9 && monkBlue == 4'h2)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= monkRed;
					Green[7:4] <= monkGreen;
					Blue[7:4] <= monkBlue;
					end
					RelativeX <= DrawX - monkfile[2][19:10];
					RelativeY <= DrawY - monkfile[2][9:0];
				end
		
		else if(monkfile[3] != 0 && monkfile[3][19:10] < DrawX  && DrawX <= (monkfile[3][19:10] + 31) && monkfile[3][9:0] <= DrawY && DrawY <= (monkfile[3][9:0] + 31))
			begin
					if(monkRed == 4'h4 && monkGreen == 4'h9 && monkBlue == 4'h2)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= monkRed;
					Green[7:4] <= monkGreen;
					Blue[7:4] <= monkBlue;
					end
					if(orientation)
					RelativeX <= DrawX - monkfile[3][19:10];
					RelativeY <= DrawY - monkfile[3][9:0];
				end

		// else if(monkfile[4] != 0 && monkfile[4][19:10] < DrawX  && DrawX <= (monkfile[4][19:10] + 31) && monkfile[4][9:0] <= DrawY && DrawY <= (monkfile[4][9:0] + 31))
		// 	begin
		// 			if(monkRed == 4'h4 && monkGreen == 4'h9 && monkBlue == 4'h2)
		// 				begin
		// 					Red[7:4] <= bgRed;
		// 					Green[7:4] <= bgGreen;
		// 					Blue[7:4] <= bgBlue;
							
		// 				end
		// 			else
		// 			begin
		// 			Red[7:4] <= monkRed;
		// 			Green[7:4] <= monkGreen;
		// 			Blue[7:4] <= monkBlue;
		// 			end
		// 			RelativeX <= DrawX - monkfile[4][19:10];
		// 			RelativeY <= DrawY - monkfile[4][9:0];
		// 		end
		
		// else if(monkfile[5] != 0 && monkfile[5][19:10] < DrawX  && DrawX <= (monkfile[5][19:10] + 31) && monkfile[5][9:0] <= DrawY && DrawY <= (monkfile[5][9:0] + 31))
		// 	begin
		// 			if(monkRed == 4'h4 && monkGreen == 4'h9 && monkBlue == 4'h2)
		// 				begin
		// 					Red[7:4] <= bgRed;
		// 					Green[7:4] <= bgGreen;
		// 					Blue[7:4] <= bgBlue;
							
		// 				end
		// 			else
		// 			begin
		// 			Red[7:4] <= monkRed;
		// 			Green[7:4] <= monkGreen;
		// 			Blue[7:4] <= monkBlue;
		// 			end
		// 			RelativeX <= DrawX - monkfile[5][19:10];
		// 			RelativeY <= DrawY - monkfile[5][9:0];
		// 		end

		// else if(monkfile[6] != 0 && monkfile[6][19:10] <= DrawX  && DrawX <= (monkfile[6][19:10] + 31) && monkfile[6][9:0] <= DrawY && DrawY <= (monkfile[6][9:0] + 31))
		// 	begin
		// 			if(monkRed == 4'h4 && monkGreen == 4'h9 && monkBlue == 4'h2)
		// 				begin
		// 					Red[7:4] <= bgRed;
		// 					Green[7:4] <= bgGreen;
		// 					Blue[7:4] <= bgBlue;
		// 				end
		// 			else
		// 			begin
		// 			Red[7:4] <= monkRed;
		// 			Green[7:4] <= monkGreen;
		// 			Blue[7:4] <= monkBlue;
		// 			end
		// 			RelativeX <= DrawX - monkfile[6][19:10];
		// 			RelativeY <= DrawY - monkfile[6][9:0];
		// 		end
		
		// else if(monkfile[7] != 0 && monkfile[7][19:10] < DrawX  && DrawX <= (monkfile[7][19:10] + 31) && monkfile[7][9:0] <= DrawY && DrawY <= (monkfile[7][9:0] + 31))
		// 	begin
		// 		if(monkRed == 4'h4 && monkGreen == 4'h9 && monkBlue == 4'h2)
		// 				begin
		// 					Red[7:4] <= bgRed;
		// 					Green[7:4] <= bgGreen;
		// 					Blue[7:4] <= bgBlue;
		// 			end
		// 		else
		// 		begin
		// 			Red[7:4] <= monkRed;
		// 			Green[7:4] <= monkGreen;
		// 			Blue[7:4] <= monkBlue;
		// 		end
		// 		RelativeX <= DrawX - monkfile[7][19:10];
		// 		RelativeY <= DrawY - monkfile[7][9:0];
		// 	end
		else if(dart_alive[0] == 0 && dartfile[0] != 0 && dartfile[0][19:10] != 16 && dartfile[0][9:0] != 16 && dartfile[0][19:10] <= DrawX  && DrawX <= (dartfile[0][19:10] + 3) && dartfile[0][9:0] <= DrawY && DrawY <= (dartfile[0][9:0] + 3))
				begin
	
					Red[7:4] <= 4'h0;
					Green[7:4] <= 4'h0;
					Blue[7:4] <= 4'h0;
				end
		else if(dart_alive[1] == 0 && dartfile[1] != 0 && dartfile[1][19:10] != 16 && dartfile[1][9:0] != 16 && dartfile[1][19:10] <= DrawX  && DrawX <= (dartfile[1][19:10] + 3) && dartfile[1][9:0] <= DrawY && DrawY <= (dartfile[1][9:0] + 3))
				begin
	
					Red[7:4] <= 4'h0;
					Green[7:4] <= 4'h0;
					Blue[7:4] <= 4'h0;
				end
	

		// START POP LOC

		else if(pop_loc[0] != 0 && pop_loc[0][19:10] <= DrawX && DrawX <= pop_loc[0][19:10] + 31 && pop_loc[0][9:0] <= DrawY && DrawY <= pop_loc[0][9:0] + 31 )
			begin
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
					RelativeXP <= DrawX - pop_loc[0][19:10];
					RelativeYP <= DrawY - pop_loc[0][9:0];
			end
		else if(pop_loc[1] != 0 && pop_loc[1][19:10] <= DrawX && DrawX <= pop_loc[1][19:10] + 31 && pop_loc[1][9:0] <= DrawY && DrawY <= pop_loc[1][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[1][19:10];
					RelativeYP <= DrawY - pop_loc[1][9:0];
					if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
				else if(pop_loc[2] != 0 && pop_loc[2][19:10] <= DrawX && DrawX <= pop_loc[2][19:10] + 31 && pop_loc[2][9:0] <= DrawY && DrawY <= pop_loc[2][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[2][19:10];
					RelativeYP <= DrawY - pop_loc[2][9:0];
					if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[3] != 0 && pop_loc[3][19:10] <= DrawX && DrawX <= pop_loc[3][19:10] + 31 && pop_loc[3][9:0] <= DrawY && DrawY <= pop_loc[3][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[3][19:10];
					RelativeYP <= DrawY - pop_loc[3][9:0];
					if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
			else if(pop_loc[4] != 0 && pop_loc[4][19:10] <= DrawX && DrawX <= pop_loc[4][19:10] + 31 && pop_loc[4][9:0] <= DrawY && DrawY <= pop_loc[4][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[4][19:10];
					RelativeYP <= DrawY - pop_loc[4][9:0];
					if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[5] != 0 && pop_loc[5][19:10] <= DrawX && DrawX <= pop_loc[5][19:10] + 31 && pop_loc[5][9:0] <= DrawY && DrawY <= pop_loc[5][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[5][19:10];
					RelativeYP <= DrawY - pop_loc[5][9:0];
					if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
			else if(pop_loc[6] != 0 && pop_loc[6][19:10] <= DrawX && DrawX <= pop_loc[6][19:10] + 31 && pop_loc[6][9:0] <= DrawY && DrawY <= pop_loc[6][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[6][19:10];
					RelativeYP <= DrawY - pop_loc[6][9:0];
					if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[7] != 0 && pop_loc[7][19:10] <= DrawX && DrawX <= pop_loc[7][19:10] + 31 && pop_loc[7][9:0] <= DrawY && DrawY <= pop_loc[7][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[7][19:10];
					RelativeYP <= DrawY - pop_loc[7][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[8] != 0 && pop_loc[8][19:10] <= DrawX && DrawX <= pop_loc[8][19:10] + 31 && pop_loc[8][9:0] <= DrawY && DrawY <= pop_loc[8][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[8][19:10];
					RelativeYP <= DrawY - pop_loc[8][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[9] != 0 && pop_loc[9][19:10] <= DrawX && DrawX <= pop_loc[9][19:10] + 31 && pop_loc[9][9:0] <= DrawY && DrawY <= pop_loc[9][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[9][19:10];
					RelativeYP <= DrawY - pop_loc[9][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[10] != 0 && pop_loc[10][19:10] <= DrawX && DrawX <= pop_loc[10][19:10] + 31 && pop_loc[10][9:0] <= DrawY && DrawY <= pop_loc[10][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[10][19:10];
					RelativeYP <= DrawY - pop_loc[10][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[11] != 0 && pop_loc[11][19:10] <= DrawX && DrawX <= pop_loc[11][19:10] + 31 && pop_loc[11][9:0] <= DrawY && DrawY <= pop_loc[11][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[11][19:10];
					RelativeYP <= DrawY - pop_loc[11][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[12] != 0 && pop_loc[12][19:10] <= DrawX && DrawX <= pop_loc[12][19:10] + 31 && pop_loc[12][9:0] <= DrawY && DrawY <= pop_loc[12][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[12][19:10];
					RelativeYP <= DrawY - pop_loc[12][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[13] != 0 && pop_loc[13][19:10] <= DrawX && DrawX <= pop_loc[13][19:10] + 31 && pop_loc[13][9:0] <= DrawY && DrawY <= pop_loc[13][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[13][19:10];
					RelativeYP <= DrawY - pop_loc[13][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[14] != 0 && pop_loc[14][19:10] <= DrawX && DrawX <= pop_loc[14][19:10] + 31 && pop_loc[14][9:0] <= DrawY && DrawY <= pop_loc[14][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[14][19:10];
					RelativeYP <= DrawY - pop_loc[14][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[15] != 0 && pop_loc[15][19:10] <= DrawX && DrawX <= pop_loc[15][19:10] + 31 && pop_loc[15][9:0] <= DrawY && DrawY <= pop_loc[15][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[15][19:10];
					RelativeYP <= DrawY - pop_loc[15][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[16] != 0 && pop_loc[16][19:10] <= DrawX && DrawX <= pop_loc[16][19:10] + 31 && pop_loc[16][9:0] <= DrawY && DrawY <= pop_loc[16][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[16][19:10];
					RelativeYP <= DrawY - pop_loc[16][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[17] != 0 && pop_loc[17][19:10] <= DrawX && DrawX <= pop_loc[17][19:10] + 31 && pop_loc[17][9:0] <= DrawY && DrawY <= pop_loc[17][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[17][19:10];
					RelativeYP <= DrawY - pop_loc[17][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[18] != 0 && pop_loc[18][19:10] <= DrawX && DrawX <= pop_loc[18][19:10] + 31 && pop_loc[18][9:0] <= DrawY && DrawY <= pop_loc[18][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[18][19:10];
					RelativeYP <= DrawY - pop_loc[18][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[19] != 0 && pop_loc[19][19:10] <= DrawX && DrawX <= pop_loc[19][19:10] + 31 && pop_loc[19][9:0] <= DrawY && DrawY <= pop_loc[19][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[19][19:10];
					RelativeYP <= DrawY - pop_loc[19][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[20] != 0 && pop_loc[20][19:10] <= DrawX && DrawX <= pop_loc[20][19:10] + 31 && pop_loc[20][9:0] <= DrawY && DrawY <= pop_loc[20][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[20][19:10];
					RelativeYP <= DrawY - pop_loc[20][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[21] != 0 && pop_loc[21][19:10] <= DrawX && DrawX <= pop_loc[21][19:10] + 31 && pop_loc[21][9:0] <= DrawY && DrawY <= pop_loc[21][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[21][19:10];
					RelativeYP <= DrawY - pop_loc[21][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[22] != 0 && pop_loc[22][19:10] <= DrawX && DrawX <= pop_loc[22][19:10] + 31 && pop_loc[22][9:0] <= DrawY && DrawY <= pop_loc[22][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[22][19:10];
					RelativeYP <= DrawY - pop_loc[22][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[23] != 0 && pop_loc[23][19:10] <= DrawX && DrawX <= pop_loc[23][19:10] + 31 && pop_loc[23][9:0] <= DrawY && DrawY <= pop_loc[23][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[23][19:10];
					RelativeYP <= DrawY - pop_loc[23][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[24] != 0 && pop_loc[24][19:10] <= DrawX && DrawX <= pop_loc[24][19:10] + 31 && pop_loc[24][9:0] <= DrawY && DrawY <= pop_loc[24][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[24][19:10];
					RelativeYP <= DrawY - pop_loc[24][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[25] != 0 && pop_loc[25][19:10] <= DrawX && DrawX <= pop_loc[25][19:10] + 31 && pop_loc[25][9:0] <= DrawY && DrawY <= pop_loc[25][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[25][19:10];
					RelativeYP <= DrawY - pop_loc[25][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[26] != 0 && pop_loc[26][19:10] <= DrawX && DrawX <= pop_loc[26][19:10] + 31 && pop_loc[26][9:0] <= DrawY && DrawY <= pop_loc[26][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[26][19:10];
					RelativeYP <= DrawY - pop_loc[26][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[27] != 0 && pop_loc[27][19:10] <= DrawX && DrawX <= pop_loc[27][19:10] + 31 && pop_loc[27][9:0] <= DrawY && DrawY <= pop_loc[27][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[27][19:10];
					RelativeYP <= DrawY - pop_loc[27][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[28] != 0 && pop_loc[28][19:10] <= DrawX && DrawX <= pop_loc[28][19:10] + 31 && pop_loc[28][9:0] <= DrawY && DrawY <= pop_loc[28][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[28][19:10];
					RelativeYP <= DrawY - pop_loc[28][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[29] != 0 && pop_loc[29][19:10] <= DrawX && DrawX <= pop_loc[29][19:10] + 31 && pop_loc[29][9:0] <= DrawY && DrawY <= pop_loc[29][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[29][19:10];
					RelativeYP <= DrawY - pop_loc[29][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[30] != 0 && pop_loc[30][19:10] <= DrawX && DrawX <= pop_loc[30][19:10] + 31 && pop_loc[30][9:0] <= DrawY && DrawY <= pop_loc[30][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[30][19:10];
					RelativeYP <= DrawY - pop_loc[30][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
		else if(pop_loc[31] != 0 && pop_loc[31][19:10] <= DrawX && DrawX <= pop_loc[31][19:10] + 31 && pop_loc[31][9:0] <= DrawY && DrawY <= pop_loc[31][9:0] + 31 )
			begin
					RelativeXP <= DrawX - pop_loc[31][19:10];
					RelativeYP <= DrawY - pop_loc[31][9:0];
				if(popRed == 4'h8 && popGreen == 4'h8 && popBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
					end
				else
				begin
					Red[7:4] <= popRed;
					Green[7:4] <= popGreen;
					Blue[7:4] <= popBlue;
				end
			end
			//END POPLOC
///////////
//////////
///////////
//////////
///////////B ALLOONS
//////////
///////////
//////////
///////////
//////////
			else if( bloonfile[0] != 0 && bloonfile[0][59:50] <= DrawX  && DrawX <= (bloonfile[0][59:50] + 31) && bloonfile[0][29:20] <= DrawY && DrawY <= (bloonfile[0][29:20] + 31))
				begin 
					// if bloon is 0 then it is alive
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[0][59:50];
					RelativeYB <= DrawY - bloonfile[0][29:20];
				// end
				end
				else if(bloonfile[1] != 0 && bloonfile[1][59:50] <= DrawX  && DrawX <= (bloonfile[1][59:50] + 31) && bloonfile[1][29:20] <= DrawY && DrawY <= (bloonfile[1][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[1][59:50];
					RelativeYB <= DrawY - bloonfile[1][29:20];
					
				end
				else if( bloonfile[2] != 0 && bloonfile[2][59:50] <= DrawX  && DrawX <= (bloonfile[2][59:50] + 31) && bloonfile[2][29:20] <= DrawY && DrawY <= (bloonfile[2][29:20] + 31))
				// if(bloonfile[2] != 0 && bloonfile[2][19:10] <= DrawX  && DrawX <= (bloonfile[2][19:10] + 31) && bloonfile[2][9:0] <= DrawY && DrawY <= (bloonfile[2][9:0] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[2][59:50];
					RelativeYB <= DrawY - bloonfile[2][29:20];
					
				end
				else if(bloonfile[3] != 0 && bloonfile[3][59:50] <= DrawX  && DrawX <= (bloonfile[3][59:50] + 31) && bloonfile[3][29:20] <= DrawY && DrawY <= (bloonfile[3][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end

					RelativeXB <= DrawX - bloonfile[3][59:50];
					RelativeYB <= DrawY - bloonfile[3][29:20];

				end
				 else if(bloon_alive[4] == 0 && bloonfile[4] != 0 && bloonfile[4][59:50] <= DrawX  && DrawX <= (bloonfile[4][59:50] + 31) && bloonfile[4][29:20] <= DrawY && DrawY <= (bloonfile[4][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[4][59:50];
					RelativeYB <= DrawY - bloonfile[4][29:20];
					
				end
				 else if(bloon_alive[5] == 0 && bloonfile[5] != 0 && bloonfile[5][59:50] <= DrawX  && DrawX <= (bloonfile[5][59:50] + 31) && bloonfile[5][29:20] <= DrawY && DrawY <= (bloonfile[5][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[5][59:50];
					RelativeYB <= DrawY - bloonfile[5][29:20];

				end
				 else if(bloon_alive[6] == 0 && bloonfile[6] != 0 && bloonfile[6][59:50] <= DrawX  && DrawX <= (bloonfile[6][59:50] + 31) && bloonfile[6][29:20] <= DrawY && DrawY <= (bloonfile[6][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[6][59:50];
					RelativeYB <= DrawY - bloonfile[6][29:20];
					
				end
				 else if(bloon_alive[7] == 0 && bloonfile[7] != 0 && bloonfile[7][59:50] <= DrawX  && DrawX <= (bloonfile[7][59:50] + 31) && bloonfile[7][29:20] <= DrawY && DrawY <= (bloonfile[7][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[7][59:50];
					RelativeYB <= DrawY - bloonfile[7][29:20];
				end
				//8
		 else if(bloon_alive[8] == 0 && bloonfile[8] != 0 && bloonfile[8][59:50] <= DrawX  && DrawX <= (bloonfile[8][59:50] + 31) && bloonfile[8][29:20] <= DrawY && DrawY <= (bloonfile[8][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[8][59:50];
					RelativeYB <= DrawY - bloonfile[8][29:20];
				end
				//9
				else if(bloon_alive[9] == 0 && bloonfile[9] != 0 && bloonfile[9][59:50] <= DrawX  && DrawX <= (bloonfile[9][59:50] + 31) && bloonfile[9][29:20] <= DrawY && DrawY <= (bloonfile[9][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[9][59:50];
					RelativeYB <= DrawY - bloonfile[9][29:20];
				end
				//10		
				else if(bloon_alive[11] == 0 && bloonfile[10] != 0 && bloonfile[10][59:50] <= DrawX  && DrawX <= (bloonfile[10][59:50] + 31) && bloonfile[10][29:20] <= DrawY && DrawY <= (bloonfile[10][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[10][59:50];
					RelativeYB <= DrawY - bloonfile[10][29:20];
				end

					else if(bloon_alive[11] == 0 && bloonfile[11] != 0 && bloonfile[11][59:50] <= DrawX  && DrawX <= (bloonfile[11][59:50] + 31) && bloonfile[11][29:20] <= DrawY && DrawY <= (bloonfile[11][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[11][59:50];
					RelativeYB <= DrawY - bloonfile[11][29:20];
				end
					else if(bloon_alive[12] == 0 && bloonfile[12] != 0 && bloonfile[12][59:50] <= DrawX  && DrawX <= (bloonfile[12][59:50] + 31) && bloonfile[12][29:20] <= DrawY && DrawY <= (bloonfile[12][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[12][59:50];
					RelativeYB <= DrawY - bloonfile[12][29:20];
				end
					else if(bloon_alive[13] == 0 && bloonfile[13] != 0 && bloonfile[13][59:50] <= DrawX  && DrawX <= (bloonfile[13][59:50] + 31) && bloonfile[13][29:20] <= DrawY && DrawY <= (bloonfile[13][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[13][59:50];
					RelativeYB <= DrawY - bloonfile[13][29:20];
				end	
				else if(bloon_alive[14] == 0 && bloonfile[14] != 0 && bloonfile[14][59:50] <= DrawX  && DrawX <= (bloonfile[14][59:50] + 31) && bloonfile[14][29:20] <= DrawY && DrawY <= (bloonfile[14][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[14][59:50];
					RelativeYB <= DrawY - bloonfile[14][29:20];
				end	
				else if(bloon_alive[15] == 0 && bloonfile[15] != 0 && bloonfile[15][59:50] <= DrawX  && DrawX <= (bloonfile[15][59:50] + 31) && bloonfile[15][29:20] <= DrawY && DrawY <= (bloonfile[15][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[15][59:50];
					RelativeYB <= DrawY - bloonfile[15][29:20];
				end
				
				else if(bloon_alive[16] == 0 && bloonfile[16] != 0 && bloonfile[16][59:50] <= DrawX  && DrawX <= (bloonfile[16][59:50] + 31) && bloonfile[16][29:20] <= DrawY && DrawY <= (bloonfile[16][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[16][59:50];
					RelativeYB <= DrawY - bloonfile[16][29:20];
				end
				else if(bloon_alive[17] == 0 && bloonfile[17] != 0 && bloonfile[17][59:50] <= DrawX  && DrawX <= (bloonfile[17][59:50] + 31) && bloonfile[17][29:20] <= DrawY && DrawY <= (bloonfile[17][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[17][59:50];
					RelativeYB <= DrawY - bloonfile[17][29:20];
				end
				else if(bloon_alive[18] == 0 && bloonfile[18] != 0 && bloonfile[18][59:50] <= DrawX  && DrawX <= (bloonfile[18][59:50] + 31) && bloonfile[18][29:20] <= DrawY && DrawY <= (bloonfile[18][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[18][59:50];
					RelativeYB <= DrawY - bloonfile[18][29:20];
				end
				else if(bloon_alive[19] == 0 && bloonfile[19] != 0 && bloonfile[19][59:50] <= DrawX  && DrawX <= (bloonfile[19][59:50] + 31) && bloonfile[19][29:20] <= DrawY && DrawY <= (bloonfile[19][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[19][59:50];
					RelativeYB <= DrawY - bloonfile[19][29:20];
				end
				
				else if(bloon_alive[20] == 0 && bloonfile[20] != 0 && bloonfile[20][59:50] <= DrawX  && DrawX <= (bloonfile[20][59:50] + 31) && bloonfile[20][29:20] <= DrawY && DrawY <= (bloonfile[20][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[20][59:50];
					RelativeYB <= DrawY - bloonfile[20][29:20];
				end



					else if(bloon_alive[21] == 0 && bloonfile[21] != 0 && bloonfile[21][59:50] <= DrawX  && DrawX <= (bloonfile[21][59:50] + 31) && bloonfile[21][29:20] <= DrawY && DrawY <= (bloonfile[21][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[21][59:50];
					RelativeYB <= DrawY - bloonfile[21][29:20];
				end
				
	else if(bloon_alive[22] == 0 && bloonfile[22] != 0 && bloonfile[22][59:50] <= DrawX  && DrawX <= (bloonfile[22][59:50] + 31) && bloonfile[22][29:20] <= DrawY && DrawY <= (bloonfile[22][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[22][59:50];
					RelativeYB <= DrawY - bloonfile[22][29:20];
				end
				
else if(bloon_alive[23] == 0 && bloonfile[23] != 0 && bloonfile[23][59:50] <= DrawX  && DrawX <= (bloonfile[23][59:50] + 31) && bloonfile[23][29:20] <= DrawY && DrawY <= (bloonfile[23][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[23][59:50];
					RelativeYB <= DrawY - bloonfile[23][29:20];
				end
				
else if(bloon_alive[24] == 0 && bloonfile[24] != 0 && bloonfile[24][59:50] <= DrawX  && DrawX <= (bloonfile[24][59:50] + 31) && bloonfile[24][29:20] <= DrawY && DrawY <= (bloonfile[24][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[24][59:50];
					RelativeYB <= DrawY - bloonfile[24][29:20];
				end
				


else if(bloon_alive[25] == 0 && bloonfile[25] != 0 && bloonfile[25][59:50] <= DrawX  && DrawX <= (bloonfile[25][59:50] + 31) && bloonfile[25][29:20] <= DrawY && DrawY <= (bloonfile[25][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[25][59:50];
					RelativeYB <= DrawY - bloonfile[25][29:20];
				end
				

else if(bloon_alive[26] == 0 && bloonfile[26] != 0 && bloonfile[26][59:50] <= DrawX  && DrawX <= (bloonfile[26][59:50] + 31) && bloonfile[26][29:20] <= DrawY && DrawY <= (bloonfile[26][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[26][59:50];
					RelativeYB <= DrawY - bloonfile[26][29:20];
				end
				

else if(bloon_alive[27] == 0 && bloonfile[27] != 0 && bloonfile[27][59:50] <= DrawX  && DrawX <= (bloonfile[27][59:50] + 31) && bloonfile[27][29:20] <= DrawY && DrawY <= (bloonfile[27][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[27][59:50];
					RelativeYB <= DrawY - bloonfile[27][29:20];
				end
				
else if(bloon_alive[28] == 0 && bloonfile[28] != 0 && bloonfile[28][59:50] <= DrawX  && DrawX <= (bloonfile[28][59:50] + 31) && bloonfile[28][29:20] <= DrawY && DrawY <= (bloonfile[28][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[28][59:50];
					RelativeYB <= DrawY - bloonfile[28][29:20];
				end


else if(bloon_alive[29] == 0 && bloonfile[29] != 0 && bloonfile[29][59:50] <= DrawX  && DrawX <= (bloonfile[29][59:50] + 31) && bloonfile[29][29:20] <= DrawY && DrawY <= (bloonfile[29][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[29][59:50];
					RelativeYB <= DrawY - bloonfile[29][29:20];
				end


else if(bloon_alive[30] == 0 && bloonfile[30] != 0 && bloonfile[30][59:50] <= DrawX  && DrawX <= (bloonfile[30][59:50] + 31) && bloonfile[30][29:20] <= DrawY && DrawY <= (bloonfile[30][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[30][59:50];
					RelativeYB <= DrawY - bloonfile[30][29:20];
				end

else if(bloon_alive[31] == 0 && bloonfile[31] != 0 && bloonfile[31][59:50] <= DrawX  && DrawX <= (bloonfile[31][59:50] + 31) && bloonfile[31][29:20] <= DrawY && DrawY <= (bloonfile[31][29:20] + 31))
				begin
					if(bloonRed == 4'h8 && bloonGreen == 4'h8 && bloonBlue == 4'h8)
						begin
							Red[7:4] <= bgRed;
							Green[7:4] <= bgGreen;
							Blue[7:4] <= bgBlue;
							
						end
					else
					begin
					Red[7:4] <= bloonRed;
					Green[7:4] <= bloonGreen;
					Blue[7:4] <= bloonBlue;
					end
					RelativeXB <= DrawX - bloonfile[31][59:50];
					RelativeYB <= DrawY - bloonfile[31][29:20];
				end






































				
			else if(580 <= DrawX && DrawX < 588 && 65 <= DrawY && DrawY < 81) //this and the next three are to draw the lives
			begin
				Red[7:4] <= fontRed0;
				Green[7:4] <= fontGreen0;
				Blue[7:4] <= fontBlue0;
				RelativeXF0 <= DrawX-580; //make sure to change these values when changing the bounds of where you want it
				RelativeYF0 <= DrawY-65;			
			end

			else if(595 <= DrawX && DrawX < (595+8) && 65 <= DrawY && DrawY < 81)
			begin
				Red[7:4] <= fontRed1;
				Green[7:4] <= fontGreen1;
				Blue[7:4] <= fontBlue1;
				RelativeXF1 <= DrawX-595;
				RelativeYF1 <= DrawY-65;			
			end
			else if(610 <= DrawX && DrawX < (610+8) && 65 <= DrawY && DrawY < 81)
			begin
				Red[7:4] <= fontRed2;
				Green[7:4] <= fontGreen2;
				Blue[7:4] <= fontBlue2;
				RelativeXF2 <= DrawX-610;
				RelativeYF2 <= DrawY-65;			
			end

			else if(580 <= DrawX && DrawX < 588 && 45 <= DrawY && DrawY < 61) //this and the next three are money
			begin
				Red[7:4] <= fontRed3;
				Green[7:4] <= fontGreen3;
				Blue[7:4] <= fontBlue3;
				RelativeXM0 <= DrawX-580; //make sure to change these values when changing the bounds of where you want it
				RelativeYM0 <= DrawY-45;			
			end

			else if(595 <= DrawX && DrawX < (595+8) && 45 <= DrawY && DrawY < 61)
			begin
				Red[7:4] <= fontRed4;
				Green[7:4] <= fontGreen4;
				Blue[7:4] <= fontBlue4;
				RelativeXM1 <= DrawX-595;
				RelativeYM1 <= DrawY-45;			
			end
			else if(610 <= DrawX && DrawX < (610+8) && 45 <= DrawY && DrawY < 61)
			begin
				Red[7:4] <= fontRed5;
				Green[7:4] <= fontGreen5;
				Blue[7:4] <= fontBlue5;
				RelativeXM2 <= DrawX-610;
				RelativeYM2 <= DrawY-45;			
			end

			else if(580 <= DrawX && DrawX < 588 && 25 <= DrawY && DrawY < 41) //this is the round number
			begin
				Red[7:4] <= fontRed6;
				Green[7:4] <= fontGreen6;
				Blue[7:4] <= fontBlue6;
				RelativeXR <= DrawX-580; //make sure to change these values when changing the bounds of where you want it
				RelativeYR <= DrawY-25;			
			end

			else if(484 <= DrawX && DrawX <= 504 && 90<=DrawY && DrawY<= 110) //this is the brown square
				begin		
			Red[7:4] <= 4'h7;
			Green[7:4] <= 4'h5;
			Blue[7:4] <= 4'h0;
				end
		else
		begin		
			Red[7:4] <= bgRed;
			Green[7:4] <= bgGreen;
			Blue[7:4] <= bgBlue;
		end
	end
	else
		begin
			Red <= 8'h00;
			Green <= 8'h00;
			Blue <= 8'h00;
		end
end
    
endmodule
