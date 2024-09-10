module monkey_placer(input logic Clk, input logic reset, input logic placed, input logic[9:0] MouseX, input logic[9:0] MouseY, input logic[7:0] keycode, input logic[9:0] money, output logic mpready, output logic start_round);

always_ff @ (posedge Clk)
begin
if(reset)
begin
    mpready <= 0;
    start_round <= 0;
end

else if(placed == 0 && money >= 250 && 484 <= MouseX && MouseX <= 504 && 90<= MouseY && MouseY<= 110 && keycode == 4'h0001)
    mpready <= 1;


else if(480 <= MouseX && MouseX <= 622 && 402<= MouseY && MouseY<= 450 && keycode == 4'h0001)
    start_round <= 1;

else if( placed == 1)
    mpready <= 0;

end

endmodule