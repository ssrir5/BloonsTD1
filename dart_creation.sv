module dart_creation(input logic Clk, input logic dart_alive, input logic [19:0] dartfileStart, input logic [19:0] dartfileDest, input logic monk_ready, input logic [63:0] blooncount,
                     output logic [19:0] dartfile, input logic reset, output logic [1:0] monkey_rotation);

logic [19:0] init_x_disp, init_y_disp;
logic signx, signy;
logic [11:0] slope;
logic [15:0] x_dif, y_dif;
logic [31:0] counter;
always_ff @ (posedge Clk)
begin
    if(reset)
        dartfile <= 0;
    else if(dart_alive == 1)
        dartfile <= 0;

    else if(monk_ready == 1)
    begin
        dartfile[19:10] <= dartfileStart[19:10];
        dartfile[9:0] <= dartfileStart[9:0];
    end
    else if(dartfile != 0  && dartfile != dartfileDest && dartfileDest[19:10] < 640 && dartfileDest[9:0] < 480 && dartfile[19:10] < 640 && dartfile[9:0] < 480)
    begin
        if(blooncount  % 333333 == 0)
        begin
            if(signx == 0 )
                dartfile[19:10] <= dartfile[19:10] + (x_dif[9:4]);
            else
                dartfile[19:10] <= dartfile[19:10] - (x_dif[9:4]);
                
            if(signy == 0)
                dartfile[9:0] <= dartfile[9:0] + (y_dif[9:4]);
            else
                dartfile[9:0] <= dartfile[9:0] - (y_dif[9:4]);
        end
    end

    if(dartfileDest[19:10] > dartfileStart[19:10])
        signx <= 1'b0; //0 is when it is going right, pos direction
    else
        signx <= 1'b1; //1 is when going left, neg direction
        
    if(dartfileDest[9:0] > dartfileStart[9:0])
        signy <= 1'b0; //0 is when it is going down, pos direction
    else
        signy <= 1'b1; //1 is when going up, neg direction

    if(dartfileDest[19:10] > dartfileStart[19:10])
        init_x_disp <= dartfileDest[19:10] - dartfileStart[19:10]; //this is to make sure I get a positive x_disp to calculate slope
    else
        init_x_disp <= dartfileStart[19:10] - dartfileDest[19:10];

    if(dartfileDest[9:0] > dartfileStart[9:0])
        init_y_disp <= dartfileDest[9:0] - dartfileStart[9:0]; //this is to make sure I get a positive y_disp to calculate slope
    else
        init_y_disp <= dartfileStart[9:0] - dartfileDest[9:0];

    if(init_x_disp != 0 && init_y_disp == 0)
    begin
        x_dif <= 64; //this is when the slope is a weird number;
        y_dif <= 0;
    end

    else if(init_x_disp == 0 && init_y_disp != 0)
    begin
        x_dif <= 0; //this is when the slope is a weird number;
        y_dif <= 64;
    end


    else if(init_x_disp < 100 && init_x_disp >= init_y_disp) //it needs to go further in x direction, y is smaller so we will set y
    begin
        y_dif <= 64; //there is a slope that is less than 1;
        // slope <= (init_y_disp<<4) / (init_x_disp << 4);
        x_dif <= (64*init_x_disp)/init_y_disp;
        if(counter % 10000000 == 0)
        begin
        if(signx == 0)
            monkey_rotation <= 3;
        else 
            monkey_rotation <= 1;
        end 
    end

    else if(init_y_disp < 100 && init_x_disp < init_y_disp) //it needs to go further in y direction, x is smaller so we will set x
    begin
        x_dif <= 64; //there is a slope that is less than 1;
        // slope <= (init_y_disp<<4) / (init_x_disp << 4);
        y_dif <= (64*init_y_disp)/init_x_disp;
        if(counter % 10000000 == 0)
        begin
         if(signy == 0)
            monkey_rotation <= 2;
        else 
            monkey_rotation <= 0; 
        end
    end
    // if(dartfile == dartfileDest)
    // //     pop <= 1;
    // // else
    // //     pop <= 0;
    counter <= counter + 1;
end


// always_ff @ (posedge Clk)
// begin
//     if(dartfile == dartfileDest)
//         pop <= 1;
//     else
//         pop <= 0;
// end
//         dartfile <= 0;
//     //y2-y1 = m(x2-x1) y2 is final dest
//     else if(dartfile != 0 && dartfile != dartfileDest && dartfileDest[19:10] < 640 && dartfileDest[9:0] < 480 && dartfile[19:10] < 640 && dartfile[9:0] < 480)
//     begin
//         // if(dartfileDest == 0)
//            dartfileTemp <= dartfileStart + ;
//         if(blooncount  % 3333333 == 0)
//         begin
//             if(signx == 0 )
//                 dartfile[19:10] <= dartfile[19:10] + (init_x_disp  >> 4);
//             else
//                 dartfile[19:10] <= dartfile[19:10] - (init_x_disp  >> 4);
                
//             if(signy == 0)
//                 dartfile[9:0] <= dartfile[9:0] + (init_y_disp  >> 4);
//             else
//                 dartfile[9:0] <= dartfile[9:0] - (init_y_disp >> 4);
            
//         end
// end    


// always_ff @ (posedge Clk)
// begin
//         if(dartfileDest[19:10] > dartfileStart[19:10])
//             signx <= 1'b0; //0 is when it is going right, pos direction
//         else
//             signx <= 1'b1; //1 is when going left, neg direction
            
//         if(dartfileDest[19:10] > dartfileStart[19:10])
//             signy <= 1'b0; //0 is when it is going down, pos direction
//         else
//             signy <= 1'b1; //1 is when going up, neg direction

//         init_x_disp <= dartfileDest[19:10] - dartfileStart[19:10];
//         init_y_disp <= dartfileDest[9:0] - dartfileStart[9:0];
// end






// always_ff @ (posedge Clk)
// begin
//     if(reset)
//         dartfile <= 0;
//     //y2-y1 = m(x2-x1) y2 is final dest
//     else if(dartfile != 0 && dartfile != dartfileDest && dartfileDest[19:10] < 640 && dartfileDest[9:0] < 480 && dartfile[19:10] < 640 && dartfile[9:0] < 480)
//     begin
//         if(dartfileDest == 0)
//             dartfile <= dartfile;
//         else if(blooncount  % 3333333 == 0)
//         begin
//             if(signx == 0 )
//             begin
//                 dartfile[19:10] <= dartfile[19:10] + (init_x_disp  >> 4);
//             end
//             else
//             begin
//                 dartfile[19:10] <= dartfile[19:10] - (init_x_disp  >> 4);
//             end
// //SHIFTING BY FOUR GETS RID OF STUFF 
//             if(signy == 0)
//             begin
//                 dartfile[9:0] <= dartfile[9:0] + (init_y_disp  >> 4);
//             end
//             else
//             begin
//                 dartfile[9:0] <= dartfile[9:0] - (init_y_disp >> 4);
//             end
//         end
//     end
// end


endmodule
