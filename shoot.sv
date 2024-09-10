module shoot(input logic Clk,  input logic [20:0] monkfileIn, input logic [20:0] bloonfileIn, input logic [20:0]dartfileDest,
             output logic [20:0] dartfile, output logic bloonfileOut);

logic [12:0] X, Y, slope;
logic temp_dartfileDest;

always_ff @ (posedge Clk)
begin
    if(monkfileIn[20] == 1 && dartfileDest != 0)
    begin
        dartfile[20] <= 1'b1;
        dartfile[19:10] <= monkfileIn[19:10];
        dartfile[9:0] <= monkfileIn[9:0];



                            if(dartfileDest[19:10] - monkfileIn[19:10] >= 0)
                                X  = dartfileDest[19:10] - monkfileIn[19:10];
                            else
                                X  =  monkfileIn[19:10] - dartfileDest[19:10];

                            if(dartfileDest[19:10] - monkfileIn[19:10] >= 0)
                                Y  = dartfileDest[9:0] - monkfileIn[9:0];
                            else
                                Y  =  monkfileIn[9:0] - dartfileDest[9:0];

        // X <= max(dartfileDest[19:10] - monkfileIn[19:10], monkfileIn[19:10] - dartfileDest[19:10]);
        // Y <= max(dartfileDest[9:0] - monkfileIn[9:0], monkfileIn[9:0] - dartfileDest[9:0]);
        // slope <= Y/X;
    end
        // bloonfileOut <= 1'b1;

    dartfile[19:10] <= dartfile[19:10] + X;
    dartfile[9:0] <= dartfile[9:0] + Y;
    if(dartfile[19:0] == dartfileDest[19:0])
    begin
        bloonfileOut <= 1'b1;
        dartfile[20] <= 1'b0;
    end



end    


endmodule