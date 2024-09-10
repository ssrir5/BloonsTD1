module bloon_detection(input logic Clk,input logic reset, input logic [19:0] monkfileIn, input logic[59:0]bloonfileIn[32],
                                        output logic monk_ready, output logic [19:0] dartfileDest, output logic[4:0] bloon_index);

//// CAUSE OF ERROR THAT COST US 3 HOURS WE USED A [7:0] --  8


logic [9:0] x_disp, y_disp, min_disp;
logic [63:0] blooncount;
logic allowed; //allowed to continue after a long delay
logic [3:0] j;
logic [19:0] temp_disp[32];
logic [19:0] curr_disp;
logic [4:0] delay;
// logic [4:0] bloon_index;


// // WORKING CODE FOR ONE BLOON
// bloon_distance distance0(.Clk(Clk), .monkfileIn(monkfileIn), .bloonfileIn(bloonfileIn[0]), .temp_disp(temp_disp));
// always_ff @ (posedge Clk)
// begin
//         if(reset)
//         begin
//             dartfileDest <= 0;
//             temp_bloon <= 0;
//             monk_ready <= 0;
//             blooncount <= 0;
//         end
//         else if(allowed == 1'b0)
//         begin
//             blooncount <= blooncount+1;
//             monk_ready <= 1'b0;
//             if(blooncount >= 50000000) //this is a one second delay
//                 begin
//                     allowed <= 1'b1;
//                     blooncount <= 64'b0;
//                 end
//         end
//         else if(temp_disp < 10000 && allowed == 1'b1)
//         begin
//             dartfileDest[19:10] <= bloonfileIn[0][59:50] + 16;
//             dartfileDest[9:0] <= bloonfileIn[0][29:20] + 16;
//             monk_ready <= 1'b1;
//             delay <= delay +1;
//            if(delay > 10)
//            begin
//                 allowed <= 1'b0;
//                 delay <= 1'b0;
//             end
//         end


// end

// // END OF WORKING CODE FOR ONE BLOOON




// START OF  CODE FOR FILTERING THROUGH ALL BLOONS
bloon_distance distance0(.Clk(Clk), .monkfileIn(monkfileIn), .bloonfileIn(bloonfileIn), .temp_disp(temp_disp));

always_ff @ (posedge Clk)
begin


        for(int i = 0; i < 32; i++) begin
            if( temp_disp[i] < curr_disp) begin
                curr_disp <= temp_disp[i];
                bloon_index <= i;
                break;
            end
        end




        if(reset)
        begin
            dartfileDest <= 0;
            // temp_bloon <= 0;
            monk_ready <= 0;
            blooncount <= 0;
            curr_disp <= 10000;
            bloon_index <= 0;
        end
        else if(allowed == 1'b0)
        begin
            blooncount <= blooncount+1;
            monk_ready <= 1'b0;
            if(blooncount >= 50000000) //this is a one second delay
                begin
                    allowed <= 1'b1;
                    blooncount <= 64'b0;
                end
        end
        else if(curr_disp < 10000 && allowed == 1'b1)
        begin
            dartfileDest[19:10] <= bloonfileIn[bloon_index][59:50] + 16;
            dartfileDest[9:0] <= bloonfileIn[bloon_index][29:20] + 16;
            monk_ready <= 1'b1;
            delay <= delay +1;
            curr_disp <= 10000;
           if(delay > 10)
           begin
                allowed <= 1'b0;
                delay <= 1'b0;
            end
        end
 


end


//END OF CODE 

endmodule








// always_ff @ (posedge Clk)
// begin
//     j <= j+1;
//     if(j == 7)
//         j <= 0;
// end

// always_ff @ (posedge Clk)
//     begin
//         if(reset)
//         begin
//          <= 0;
//         temp_bloon <= 0;
//         monk_ready <= 0;
//         end
//         else if(allowed == 1'b0)
//         begin
//             monk_ready <= 1'b0; //sets it back to 0 so we're not sending multiple darts at once
//             min_disp <= 10000;
//             blooncount <= blooncount+1;
//             if(blooncount >= 50000000)
//                 allowed <= 1'b1;
//         end
//         else if(monk_ready == 1'b1)
//         begin
//             allowed <= 1'b0;
//             blooncount <= 127'b0;
//         end
//         else if(allowed == 1'b1)
//         begin   
//             //min_disp <= 10000;
//             // 64x64 pixel range for monkey


//                     if(temp_disp < min_disp)
//                         begin
//                             temp_bloon <= j; //this is the bloon that is the closest
//                             min_disp <= temp_disp;
//                         end
//                 end   
//             end
//             j <= j + 1;
//             if(j == 7)
//             begin
//                 if(min_disp != 10000)
//                     dartfileDest <= bloonfileIn[temp_bloon]; //where the monkey is shooting to
//                 else
//                     dartfileDest <= 20'b0; // so that dartfile dest is set to 0
//                 monk_ready <= 1'b1;
//                 j <= 4'b0;
//             end
//         end
//     end
// endmodule
