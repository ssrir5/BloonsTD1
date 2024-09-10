module bloonpath(input logic Clk, reset, pop,
                 input logic [59:0] registerValue,
				 input logic bloon_alive,
                 input logic [127:0] startingTime,
				 input logic [7:0] inputLives,
				 input logic bloonpause,
                 output logic [59:0] registerValueOut, output logic bloon_done, output logic lost_life);

logic [63:0] pixelcount;

always_ff @ (posedge Clk) 
begin
if(reset)
begin
pixelcount <= 0;
registerValueOut <= 0;
lost_life <= 0;
end
// if(bloon_list)
// 	registerValueOut <= 0;
else if(bloon_alive == 1)
	registerValueOut <= 0;

else if(bloonpause == 1)
begin
	// if(pop)
	// registerValueOut <= 0;
	if((pixelcount[63:20] >= startingTime) &&  (pixelcount[63:20] < 2*32 + startingTime) && registerValue[59:50] < (2 * 32))
	begin
		registerValueOut[59:30] <= registerValue[59:30] + 1;
		registerValueOut[29:20] <= 7 * 32;
		end
	//FIRST UP MOVEMENT
	else if((startingTime + 2*32 <= pixelcount[63:20]) && (pixelcount[63:20]  < startingTime + 6*32) && registerValue[29:20] > (3 * 32))
	begin
		registerValueOut[29:0] <= registerValue[29:0] - 1;
	end
	//SECOND RIGHT MOVEMENT	
	else if((startingTime + 6*32 <= pixelcount[63:20] && pixelcount[63:20]  < 10*32+ startingTime) && registerValue[59:50] < (6 * 32))
	begin
		registerValueOut[59:30] <= registerValue[59:30] + 1;
	end

	//FIRST DOWN MOVEMENT
	else if((startingTime + 10*32 <= pixelcount[63:20] && pixelcount[63:20]  <  17 * 32+ startingTime) && registerValue[29:20] < (10 * 32))
	begin
		registerValueOut[29:0] <= registerValue[29:0] + 1;
	end

	//FIRST LEFT MOVEMENT
	else if((startingTime + 17*32 <= pixelcount[63:20] && pixelcount[63:20]  <  22*32+ startingTime)  && registerValue[59:50] > (1 * 32))
	begin
		registerValueOut[59:30] <= registerValue[59:30] - 1;
	end
	//SECOND DOWN MOVEMENT
	else if((startingTime + 22*32 <= pixelcount[63:20] && pixelcount[63:20]  <  25 * 32+ startingTime)  && registerValue[29:20] < (13 * 32))
	begin
		registerValueOut[29:0] <= registerValue[29:0] + 1;
	end
	//THIRD RIGHT MOVEMENT	
	else if((startingTime + 25*32 <= pixelcount[63:20] && pixelcount[63:20]  < 37*32+ startingTime)  && registerValue[59:50] < (13 * 32))
	begin
		registerValueOut[59:30] <= registerValue[59:30] + 1;

	end

	//SECOND UP MOVEMENT
	else if((startingTime + 37*32 <= pixelcount[63:20] && pixelcount[63:20]  <  41*32+ startingTime) && registerValue[29:20] > (9 * 32))
		registerValueOut[29:0] <= registerValue[29:0] - 1;

	//second LEFT MOVEMENT
	else if((startingTime + 41*32 <= pixelcount[63:20] && pixelcount[63:20]  <  45*32+ startingTime) && registerValue[59:50] > (9 * 32))
		registerValueOut[59:30] <= registerValue[59:30] - 1;

	//THIRD UP MOVEMENT
	else if((startingTime + 45*32 <= pixelcount[63:20] && pixelcount[63:20]  < 48*32+ startingTime + 16) && registerValue[29:20] > (6 * 32 - 16))
		registerValueOut[29:0] <= registerValue[29:0] - 1;

	//FOURTH RIGHT MOVEMENT	
	else if((startingTime + 48*32 + 16 <= pixelcount[63:20] && pixelcount[63:20]  < 52*32 + 16 + startingTime) && registerValue[59:50] < (13 * 32))
		registerValueOut[59:30] <= registerValue[59:30] + 1;

	//FOURTH UP MOVEMENT
	else if((startingTime + 52*32 + 16 <= pixelcount[63:20] && pixelcount[63:20]  < 57*32+ startingTime) && registerValue[29:20] > (1 * 32))
		registerValueOut[29:0] <= registerValue[29:0] - 1;
		
	//THIRD LEFT MOVEMENT
	else if((startingTime + 57*32<= pixelcount[63:20]&& pixelcount[63:20] < 62*32 + 16+ startingTime) && registerValue[59:50] > (8 * 32))
		registerValueOut[59:30] <= registerValue[59:30] - 1;
		
	//FIFTH UP MOVEMENT	
	else if(startingTime + 62*32 + 16<= pixelcount[63:20]&& pixelcount[63:20]  < 65*32+ 16 + startingTime)
		registerValueOut[29:0] <= registerValue[29:0] - 1;

	else if((startingTime + 65*32 + 16 <= pixelcount[63:20]&& pixelcount[63:20]  < 65*32+ 16 + 1+ startingTime)) //timing to set lost life high
		lost_life <= 1'b1;
	else if((startingTime + 65 *32 + 16 + 1<= pixelcount[63:20]&& pixelcount[63:20]  < 65*32+ 16 + 2 + startingTime)) //timing to set lost life back to low
		lost_life <= 1'b0;
	pixelcount <= pixelcount + 1;
	end
end
 

endmodule
