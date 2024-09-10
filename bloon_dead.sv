module bloon_dead(input logic Clk, input logic reset, input logic[31:0] bloon_alive[8], output logic bloon_list[32]);

always_ff @ (posedge Clk)
begin
    if(reset)
    begin
        for(int k = 0; k < 32; k++)
            bloon_list[k] <= 0;
    end
else
begin
for(int i = 0; i < 8; i++)
begin
    for(int j = 0; j < 32; j++)
    begin
    if(bloon_alive[i][j] == 1)
        bloon_list[j] <= 1;
    end
end
end
end

endmodule