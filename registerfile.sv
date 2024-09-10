module registerfile(input logic Clk, Reset, Load_Reg,
input logic [2:0] DRS, input logic [2:0] SR1S, input logic [9:0] MonkeyX, input logic [9:0] MonkeyY, output logic [19:0] regfile[7:0]);
//DRS is select line for writing, SR1S is for reading

// logic [19:0] regfile [7:0];
always_comb
begin
    RegOut <= regfile[SR1S];
end

always_ff @ (posedge Clk)
begin
        if(Reset) 
            for(int i = 0; i <= 7; i = i + 1)
                regfile[i] <= 16'h0000;

        else if(Load_Reg)
            regfile[DRS][19:10] <= MonkeyX;
            regfile[DRS][9:0] <= MonkeyY;

end
endmodule