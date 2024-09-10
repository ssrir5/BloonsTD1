// module dart_collision(input logic Clk, input logic reset, input logic [59:0] bloonfile[8], input logic[19:0] dartfile, output logic bloon_alive, output logic dart_alive, output logic [19:0] pop_loc);

// logic [31:0] pop_counter;

// always_ff @ (posedge Clk)
// begin
//     //BLOONCOUNT // REVISE FOR MULTIPLE BLOONS
//     // for (int i = 0; i < 8; i = i + 1)
//     // begin
        
//         if(reset)
//         begin
//             dart_alive <= 0;
//             bloon_alive <= 0;
//             pop_counter <= 0;
//             pop_loc <= 0;
//         end

//         else if(bloonfile[0][59:50] <= dartfile[19:10]  && dartfile[19:10] <= bloonfile[0][59:50] + 31 && bloonfile[0][59:50] != 0 && dartfile != 0)
//         begin
//             if(bloonfile[0][29:20] <= dartfile[9:0]  && dartfile[9:0] <= bloonfile[0][29:20] + 31 && bloonfile[0][29:20] != 0)
//             begin
//                 dart_alive <= 1; //1 means the dart goes away
//                 bloon_alive <= 1; //1 means we popped the bloon
//                 pop_loc[19:10] <= bloonfile[0][59:50];
//                 pop_loc[9:0] <= bloonfile[0][29:20];
//                 // break;

//             end
//         end
        
//         if(pop_loc != 0)
//         begin
//             pop_counter <= pop_counter + 1;
//             if(pop_counter >= 10000000)
//             begin
//                 pop_loc <= 0;
//                 dart_alive <= 0;
//                 pop_counter <= 0;
//             end
//         end
//     // end



// end



module dart_collision(input logic Clk, input logic reset, input logic [59:0] bloonfile[32], input logic[4:0] bloon_index, input logic[19:0] dartfile, output logic[31:0] bloon_alive, output logic dart_alive, output logic [19:0] pop_loc);

logic [31:0] pop_counter;

always_ff @ (posedge Clk)
begin
    //BLOONCOUNT // REVISE FOR MULTIPLE BLOONS
    // for (int i = 0; i < 8; i = i + 1)
    // begin
        
        if(reset)
        begin
            dart_alive <= 0;
            pop_loc <= 0;

            pop_counter <= 0;
            for(int i = 0; i < 32; i = i + 1)
                begin
                    bloon_alive[i] <= 0;

                end
        end

        else if(bloonfile[bloon_index][59:50] <= dartfile[19:10]  && dartfile[19:10] <= bloonfile[bloon_index][59:50] + 31 && bloonfile[bloon_index][59:50] != 0 && dartfile != 0)
        begin
            if(bloonfile[bloon_index][29:20] <= dartfile[9:0]  && dartfile[9:0] <= bloonfile[bloon_index][29:20] + 31 && bloonfile[bloon_index][29:20] != 0)
            begin
                dart_alive <= 1; //1 means the dart goes away
                bloon_alive[bloon_index] <= 1; //1 means we popped the bloon
                pop_loc[19:10] <= bloonfile[bloon_index][59:50];
                pop_loc[9:0] <= bloonfile[bloon_index][29:20];
                // break;

            end
        end
        
        if(pop_loc != 0)
        begin
            pop_counter <= pop_counter + 1;
            if(pop_counter >= 10000000)
            begin
                
                pop_loc <= 0;
                dart_alive <= 0;
                pop_counter <= 0;
            end
        end
    // end



end





endmodule