//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module bloonstd1 (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 

);




logic Reset_h, vssig, blank, sync, VGA_Clk;


//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] DrawX, DrawY, MouseX, MouseY;
	// logic [7:0] C_Red, C_Blue, C_Green;
	// logic [7:0] F_Red, F_Blue, F_Green;
	logic BVal, MVal;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;
	logic [31:0] x_displacement, y_displacement;

//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//HEX drivers to convert numbers to HEX output
	HexDriver hex_driver4 (hex_num_4, HEX4[6:0]);
	assign HEX4[7] = 1'b1;
	
	HexDriver hex_driver3 (hex_num_3, HEX3[6:0]);
	assign HEX3[7] = 1'b1;
	
	HexDriver hex_driver1 (hex_num_1, HEX1[6:0]);
	assign HEX1[7] = 1'b1;
	
	HexDriver hex_driver0 (hex_num_0, HEX0[6:0]);
	assign HEX0[7] = 1'b1;
	
	//fill in the hundreds digit as well as the negative sign
	assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];
	
	
	bloonstd1_soc u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export
		.x_displacement_export          (x_displacement),    //x_displacement.export
		.y_displacement_export          (y_displacement),    //y_displacement.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export({hundreds, signs, LEDR}),
		.keycode_export(keycode)
		
	 );


//instantiate a vga_controller, ball, and color_mapper here with the ports.
vga_controller control(.Clk(MAX10_CLK1_50), .Reset(Reset_h), .hs(VGA_HS), .vs(VGA_VS), .pixel_clk(VGA_Clk), .blank(blank), .sync(sync), .DrawX(DrawX), .DrawY(DrawY));
mouse mouse_thing(.Reset(Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .x_displacement(x_displacement), .y_displacement(y_displacement), .MouseX(MouseX), .MouseY(MouseY));
/* COMMENTED FOR MULTIPLE MONKEY PURPOSES
logic [9:0] MonkeyX, MonkeyY;
logic new_monkey;
always_ff @ (posedge MAX10_CLK1_50)
begin
if(keycode == 4'h0001)
begin
MonkeyX <= MouseX;
MonkeyY <= MouseY;
end
//begin
//	monkeysm(Reset(Reset_h), CLK(MAX10_CLK1_50), MouseX(MouseX), MouseY(MouseY), keycode(keycode), MonkeyX(MonkeyX), MonkeyY(MonkeyY),new_monkey(new_monkey));
//end
end
*/

//STRUCT SYNTAX - NOT FIGURED OUT CHECK W TA, USING REGISTERS FOR NOW
//typedef struct{
//	logic[9:0] MonkeyXLoc;
//	logic[9:0] MonkeyYLoc;
//
//} MonkeyStruct;
//logic [2:0] mcounter;

//MonkeyStruct [1:0] monkey_list = '{};
// always_ff @ (posedge MAX10_CLK1_50)
// begin
// 	if(keycode == 4'h0001)
// 	begin
// 		if(keycode == 4'h0000)
// 		begin
// 			MonkeyStruct new_struct = '{MouseX, MouseY};
// 			monkey_list.push_back(new_struct);
// 			mcounter <= mcounter + 1;
// 		end
// 	end
// end

///// ******* INCREASING BLOONS
genvar gen_i;
generate
	for (gen_i=0; gen_i < 32; gen_i=gen_i+1) begin : bloon_gen //<-- do we need this part
			bloonpath bloon0 (
				.Clk(MAX10_CLK1_50), 
				.reset(Reset_h || start_reset), 
				.bloonpause(bloonpause),
				.startingTime(100 + (gen_i * 50)), 
				.registerValue(bloonfile[gen_i]), 
				.registerValueOut(bloonfile[gen_i]),
				.bloon_alive(bloon_list[gen_i]),
				.lost_life(lost_life[gen_i])
			);

	end
endgenerate

// bloonpath bloon0 (.Clk(MAX10_CLK1_50), .reset(Reset_h), .startingTime(100), .registerValue(bloonfile[0]), .registerValueOut(bloonfile[0]),.bloon_alive(bloon_alive[0]));
// bloonpath bloon1 (.Clk(MAX10_CLK1_50), .reset(Reset_h), .startingTime(150), .registerValue(bloonfile[1]), .registerValueOut(bloonfile[1]),.bloon_alive(bloon_alive[1]));
// bloonpath bloon2 (.Clk(MAX10_CLK1_50), .reset(Reset_h), .startingTime(200), .registerValue(bloonfile[2]), .registerValueOut(bloonfile[2]),.bloon_alive(bloon_alive[2]));
// bloonpath bloon3 (.Clk(MAX10_CLK1_50), .reset(Reset_h), .startingTime(250), .registerValue(bloonfile[3]), .registerValueOut(bloonfile[3]),.bloon_alive(bloon_alive[3]));
// bloonpath bloon4 (.Clk(MAX10_CLK1_50), .reset(Reset_h), .startingTime(300), .registerValue(bloonfile[4]), .registerValueOut(bloonfile[4]),.bloon_alive(bloon_alive[4]));
// bloonpath bloon5 (.Clk(MAX10_CLK1_50), .reset(Reset_h), .startingTime(350), .registerValue(bloonfile[5]), .registerValueOut(bloonfile[5]),.bloon_alive(bloon_alive[5]));
// bloonpath bloon6 (.Clk(MAX10_CLK1_50), .reset(Reset_h), .startingTime(400), .registerValue(bloonfile[6]), .registerValueOut(bloonfile[6]),.bloon_alive(bloon_alive[6]));
// bloonpath bloon7 (.Clk(MAX10_CLK1_50), .reset(Reset_h), .startingTime(450), .registerValue(bloonfile[7]), .registerValueOut(bloonfile[7]),.bloon_alive(bloon_alive[7]));







// bloonpath bloon1 (.Clk(MAX10_CLK1_50), .startingTime(150),  .blooncount(blooncount), .registerValue(bloonfile[1]), .registerValueOut(bloonfile[1]));
// bloonpath bloon2 (.Clk(MAX10_CLK1_50), .startingTime(200), .blooncount(blooncount), .registerValue(bloonfile[2]), .registerValueOut(bloonfile[2]));
// bloonpath bloon3 (.Clk(MAX10_CLK1_50), .startingTime(250), .blooncount(blooncount), .registerValue(bloonfile[3]), .registerValueOut(bloonfile[3]));
// bloonpath bloon4 (.Clk(MAX10_CLK1_50), .startingTime(300), .blooncount(blooncount), .registerValue(bloonfile[4]), .registerValueOut(bloonfile[4]));
// bloonpath bloon5 (.Clk(MAX10_CLK1_50), .startingTime(350), .blooncount(blooncount), .registerValue(bloonfile[5]), .registerValueOut(bloonfile[5]));
// bloonpath bloon6 (.Clk(MAX10_CLK1_50), .startingTime(400), .blooncount(blooncount), .registerValue(bloonfile[6]), .registerValueOut(bloonfile[6]));
// bloonpath bloon7 (.Clk(MAX10_CLK1_50), .startingTime(450), .blooncount(blooncount), .registerValue(bloonfile[7]), .registerValueOut(bloonfile[7]));


logic [19:0] monkfile [8]; //these registers only hold x/y values
logic [59:0] bloonfile[32];
logic [19:0] dartfile [8];
logic monk_ready [8]; //Each monkeys ready state
logic [7:0] temp_bloon; //What bloon each monkey is shooting at

logic [2:0] mcounter;
logic allowed;
logic [63:0] blooncount;
logic [19:0] dartfileDest [8];
logic [1:0] monkey_rotation [8];

//ALIVE CHECK
logic dart_alive[8];

/////// ******* INCREASING BLOON COUNT
logic bloon_list[32];

logic [31:0] bloon_alive [8];
logic [19:0] pop_loc [32];
logic [9:0] moneyOut;
logic [7:0] lives;
logic lost_life [32]; //increasing bloon count
logic placed, mpready;
logic start_round;
logic start_round_flag;
logic start_reset;
logic bloonpause;

// always_ff @ (posedge MAX10_CLK1_50) //this is the start round reset logic
// begin
// 	start_round_flag <= start_round;
// 	if(start_round && !start_round_flag) //did this to get clock edge
// 	begin
// 		start_reset <= 1; //when the start round button was pressed 
// 		bloonpause <= 1; //this means our pause has ended
// 	end
// 	else
// 		start_reset <= 0;
// end	

//REG FILE MONKEY DATA
monkey_placer place(.Clk(MAX10_CLK1_50), .reset(Reset_h), .placed(placed), .MouseX(MouseX), .MouseY(MouseY) , .keycode(keycode), .money(moneyOut), .mpready(mpready), .start_round(start_round));

always_ff @ (posedge MAX10_CLK1_50)
begin
	if(Reset_h)
	begin
		for(int i = 0; i < 8; i++)
		begin
			monkfile[i] <= 0;
			mcounter <= 0;
		end	
	blooncount <= 0;
	bloonpause <= 0;
	end

	start_round_flag <= start_round;

	if(start_round && !start_round_flag) //did this to get clock edge
	begin
		start_reset <= 1; //when the start round button was pressed 
		bloonpause <= 1; //this means our pause has ended
	end

	else if(keycode == 4'h0001 && allowed == 1'b1 && mouse_check == 0 && mpready && MouseX < 480)
	begin
		// WE'D HAVE TO EVENTUALLY CHECK BOUNDS WITH BACKGROUND
				if(mcounter == 4)
				begin
				
				end
					// mcounter <= 0;
				else
				begin
					monkfile[mcounter][19:10] <= MouseX - 15;
					monkfile[mcounter][9:0] <= MouseY - 15;
					mcounter <= mcounter + 1;
					placed <= 1;
				end
				allowed <= 1'b0;
	end
	else if(keycode == 4'h0000)
	begin
		allowed <= 1'b1;
		placed <= 0;
	end
		else
	begin
		start_reset <= 0;
	end
	blooncount <= blooncount + 1;							// INCREMENT bloonTIMER
end


logic mouse_check;
logic [4:0] bloon_index [32];
color_mapper map(.Clk(MAX10_CLK1_50),
.orientation(monkey_rotation),
 .pixel_clk(VGA_Clk),
  .monkfile(monkfile),
   .dartfile(dartfile),
    .bloonfile(bloonfile),
	 .mcounter(mcounter),
	  .MouseX(MouseX),
	   .MouseY(MouseY),
	    .DrawX(DrawX),
		 .DrawY(DrawY),
		  .Red(Red),
		   .Green(Green),
		    .Blue(Blue), 
			.blank(blank),
			 .bg_data(BVal),
			  .bloon_alive(bloon_list),
			   .dart_alive(dart_alive),
			    .pop_loc(pop_loc),
				 .lives(lives),
				 	.moneyOut(moneyOut),
					.mpready(mpready));

// dart_collision dart0_col(.Clk(MAX10_CLK1_50), .reset(Reset_h), .bloonfile(bloonfile), .dartfile(dartfile[0]), .bloon_alive(bloon_alive[0]), .dart_alive(dart_alive[0]), .pop_loc(pop_loc[0]));
dart_collision dart0_col(.Clk(MAX10_CLK1_50),
 .reset(Reset_h),
  .bloon_index(bloon_index[0]),
   .bloonfile(bloonfile),
    .dartfile(dartfile[0]),
	 .bloon_alive(bloon_alive[0]),
	  .dart_alive(dart_alive[0]),
	   .pop_loc(pop_loc[0]));



dart_collision dart1_col(.Clk(MAX10_CLK1_50), .reset(Reset_h), .bloon_index(bloon_index[1]), .bloonfile(bloonfile), .dartfile(dartfile[1]), .bloon_alive(bloon_alive[1]), .dart_alive(dart_alive[1]), .pop_loc(pop_loc[1]));

background_rom brom(.addressX(DrawX), .addressY(DrawY), .data(BVal), .MouseX(MouseX),.MouseY(MouseY), .data_mouse(mouse_check));


bloon_detection bloon_dect0 (.Clk(MAX10_CLK1_50), .reset(Reset_h), .bloonfileIn(bloonfile), .monkfileIn(monkfile[0]), .monk_ready(monk_ready[0]), .dartfileDest(dartfileDest[0]), .bloon_index(bloon_index[0]));
bloon_detection bloon_dect1 (.Clk(MAX10_CLK1_50), .reset(Reset_h), .bloonfileIn(bloonfile), .monkfileIn(monkfile[1]), .monk_ready(monk_ready[1]), .dartfileDest(dartfileDest[1]), .bloon_index(bloon_index[1]));

// genvar bloon_dect;
// generate
// 	for (bloon_dect=0; bloon_dect < 8; ++bloon_dect) begin : bloon_detect
// 			bloonpath bloon0 (
// 				.Clk(MAX10_CLK1_50), 
// 				.reset(Reset_h), 
// 				.startingTime(100 + (bloon_dect * 50)), 
// 				.registerValue(bloonfile[bloon_dect]), 
// 				.registerValueOut(bloonfile[bloon_dect]),
// 				.bloon_alive(bloon_alive[bloon_dect])
// 			);

// 	end
// endgenerate

dart_creation dart0(.Clk(MAX10_CLK1_50), .reset(Reset_h), .dartfileStart(monkfile[0]), .dartfileDest(dartfileDest[0]), .monk_ready(monk_ready[0]), .blooncount(blooncount), .dartfile(dartfile[0]), .dart_alive(dart_alive[0]), .monkey_rotation(monkey_rotation[0]));
dart_creation dart1(.Clk(MAX10_CLK1_50), .reset(Reset_h), .dartfileStart(monkfile[1]), .dartfileDest(dartfileDest[1]), .monk_ready(monk_ready[1]), .blooncount(blooncount), .dartfile(dartfile[1]), .dart_alive(dart_alive[1]), .monkey_rotation(monkey_rotation[1]));
bloon_dead bloondeath(.Clk(MAX10_CLK1_50), .reset(Reset_h), .bloon_alive(bloon_alive), .bloon_list(bloon_list));
life_counter life1(.Clk(MAX10_CLK1_50), .reset(Reset_h), .lost_life(lost_life), .lives(lives));
money_counter money11(.Clk(MAX10_CLK1_50), .reset(Reset_h), .monkfile(monkfile), .bloon_list(bloon_list), .moneyOut(moneyOut));


endmodule
