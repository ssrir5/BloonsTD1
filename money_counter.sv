module money_counter(input logic Clk, input logic reset, input logic bloon_list[32], input logic [19:0] monkfile [8], output logic [9:0] moneyOut);

logic flag [32];
logic monkey_bought [8];

always_ff @ (posedge Clk)
begin
     if(reset)
    begin
        moneyOut <= 400;
        for(int i = 0; i<8; i++)
            monkey_bought[i] <= 0;
    end
    // else if(moneyIn > 1000)
    // begin

    // end
    for(int i = 0; i <32; i++)
        begin
            flag[i] <= bloon_list[i];
            if(bloon_list[i] && !flag[i])
                moneyOut <= moneyOut + 10;
        end
        for(int k = 0; k < 8; k++)
        begin
            if(monkfile[k] != 0 && monkey_bought[k] != 1)
            begin
                moneyOut <= moneyOut - 250;
                monkey_bought[k] <= 1;
            end
        end

end

endmodule