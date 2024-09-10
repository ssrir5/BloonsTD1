module life_counter (input logic Clk, input logic reset, input logic lost_life [32], output logic [7:0] lives);

logic life_0_flag;
logic flag [32];
always_ff @ (posedge Clk)
begin
    if(reset)
    begin
        lives <= 10;
        life_0_flag <= 0;
    end
    
    else if(life_0_flag == 0)
    begin
        for(int i = 0; i<32; i++)
        begin    
            flag[i] <= lost_life[i];
            if (lost_life[i] && !flag[i])
            begin 
                if(lives == 255)
                    life_0_flag <= 1;
                lives <= lives-1;
            end
        end
    end
    else 
        lives <= 0;
end

endmodule