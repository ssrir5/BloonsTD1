// module monkeysm( input Reset, frame_clk, CLK,
//     input [9:0]  MouseX, MouseY, 
//     input [7:0] keycode,
//     output [9:0] MonkeyX, MonkeyY, Bloon_X_Pos, Bloon_Y_Pos,
//     output new_monkey, new_bloon
// );
// 
//logic [9:0] Monkey_dataX [3:0];
//logic [9:0] Monkey_dataY [3:0];
//logic [1:0] counter;
//
//
//always_ff @ (posedge MAX10_CLK1_50)
//		begin
//			if(keycode == 4'h0001)
//				begin
//
//					MonkeyX <= MouseX;
//					MonkeyY <= MouseY;
//				end
//		end
// 
// 
// 
// 
// 
// 
// 
// 
//endmodule 
// //PLACEMENT LOGIC
//// typedef struct packed{
//// // bit ex;                                     // Monkey exists (maybe not necessary)
//// bit [9:0] MonkeyX;
//// bit [9:0] MonkeyY;
//// bit [2:0] MonkeyState;                      // Ready to Shoot State (NOT IN RANGE) {init state} -> Ready to Shoot (IN RANGE) -> NOT READY
////
//// }monkey_type;
//// typedef monkey_type monkey_array [4];          //ARRAY OF MONKEYS ( MAXED OUT AT 32)
//
// logic [4:0] bcounter, mcounter;
//
//
//
//
//
//
// always_ff @ posedge /*clock*/
// begin
//     if(Reset)
//     begin
//         for(int i = 0; i < 32; i++)
//             begin
//                 monkey_array[i].MonkeyX <= 0;
//                 monkey_array[i].MonkeyY <= 0;
//                 monkey_array[i].State <= 0;
//                 monkey_array[i].MonkeyX <= 0;
//                 counter <= 0;
//             end
//     end
//
//     if(keycode = 8'h0001 && mcounter < 4)
//     begin
//         monkey_array[mcounter].MonkeyX <= Ball_X_Pos + 7;
//         monkey_array[mcounter].MonkeyY <= Ball_X_Pos + 7;
//         monkey_array[mcounter].MonkeyY <= Ball_X_Pos + 7;
//         Monkey_X_Pos <= Ball_X_Pos + 7;
//         Monkey_Y_Pos <= Ball_Y_Pos + 7;
//         ready_signal <= 1;
//         mcounter <= mcounter + 1;                                 // MAINTAINS ITS CURRENT COUNTER VALUE FOR THIS CLOCK CYCLE FOR INDEXING PURPOSES SHOULD BE FINE
//     end
//     else
//         new_monkey <= 0;
// end
//
//
//
//
//
//
//
// // BASIC BLOON 
//
//
// typedef struct packed{
// // bit ex;                                     // Monkey exists (maybe not necessary)
// bit [9:0] BloonX;
// bit [9:0] BloonY;
// bit [1:0] BloonState;                      // Ready to Shoot State (NOT IN RANGE) {init state} -> Ready to Shoot (IN RANGE) -> NOT READY
//
// }bloon_type;
//
// typedef bloon_type bloon_array [4]; 
//
//
// always_ff @ posedge(CLK)
//     if(keycode = 8'h0002 && bcounter < 4)
//     begin
//         monkey_array[counter].BloonX <= Ball_X_Pos + 7;
//         monkey_array[counter].BloonY <= Ball_X_Pos + 7;
//         blkoon_array[counter].BloonY <= Ball_X_Pos + 7;
//         Monkey_X_Pos <= Ball_X_Pos + 7;
//         Monkey_Y_Pos <= Ball_Y_Pos + 7;
//         ready_signal <= 1;
//         counter <= counter + 1;                                 // MAINTAINS ITS CURRENT COUNTER VALUE FOR THIS CLOCK CYCLE FOR INDEXING PURPOSES SHOULD BE FINE
//     end
//     else
//         new_bloon <= 0;
//
//
//
//
//
// endmodule