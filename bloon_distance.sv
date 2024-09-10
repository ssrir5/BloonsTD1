// module bloon_distance(input logic Clk, input logic  [19:0] monkfileIn, input logic [59:0] bloonfileIn, output logic [19:0] temp_disp);
// // WHAT THIS DOES:

// // TAKES MONKEY LOCATION AND BALOON LOCATION _ CALCULATES DISTANCE SQUAREDD
// logic [9:0] x_disp, y_disp;
// always_comb
// begin

//     if(bloonfileIn[59:50] >= monkfileIn[19:10] ) //we are just looking at the top left corner but should just be the same
//         x_disp = (bloonfileIn[59:50] - monkfileIn[19:10]);
//     else 
//         x_disp = (monkfileIn[19:10] - bloonfileIn[59:50]);

//     if(bloonfileIn[29:20] >= monkfileIn[9:0]) //we are just looking at the top left corner but should just be the same
//         y_disp = (bloonfileIn[29:20] - monkfileIn[9:0]);
//     else 
//         y_disp = (monkfileIn[9:0] - bloonfileIn[29:20]);

//     //x_disp^2 + y_disp^2 = temp_disp^2 dont need sqrt, just looking at whats smaller
//         temp_disp = x_disp*x_disp + y_disp*y_disp;

//     // else
//     // temp_disp = 100000;
// end
// endmodule


module bloon_distance(input logic Clk, input logic  [19:0] monkfileIn, input logic [59:0] bloonfileIn[32], output logic [19:0] temp_disp[32]);
// WHAT THIS DOES:

// TAKES MONKEY LOCATION AND BALOON LOCATION _ CALCULATES DISTANCE SQUAREDD
logic [9:0] x_disp, y_disp;
always_comb
begin
    for(int i = 0; i < 32; i = i + 1)
    begin
        if(bloonfileIn[i][59:50] >= monkfileIn[19:10] ) //we are just looking at the top left corner but should just be the same
            x_disp = (bloonfileIn[i][59:50] - monkfileIn[19:10]);
        else 
            x_disp = (monkfileIn[19:10] - bloonfileIn[i][59:50]);

        if(bloonfileIn[i][29:20] >= monkfileIn[9:0]) //we are just looking at the top left corner but should just be the same
            y_disp = (bloonfileIn[i][29:20] - monkfileIn[9:0]);
        else 
            y_disp = (monkfileIn[9:0] - bloonfileIn[i][29:20]);

        //x_disp^2 + y_disp^2 = temp_disp^2 dont need sqrt, just looking at whats smaller
            temp_disp[i] = x_disp*x_disp + y_disp*y_disp;
    end
    // else
    // temp_disp = 100000;
end
endmodule

