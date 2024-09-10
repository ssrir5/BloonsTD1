module font_example (
	input logic [9:0] relativeXF, relativeYF,
	input logic [3:0] number,
	input logic vga_clk, blank,
	output logic [3:0] red, green, blue
);

logic [7:0] data;
logic [10:0] rom_address;

assign rom_address = (relativeYF % 16) + number*16;

always_ff @ (posedge vga_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;

	if (blank) begin
		if(data[7 - relativeXF[2:0]])
		begin
			red <= 4'hf;
			green <= 4'hf;
			blue <= 4'hf;
		end
		else
		begin
			red<= 4'h7;
			green<=4'hb;
			blue<= 4'h7;
		end
	end
end

font_rom font_rom1 (
	.address (rom_address),
	.data    (data)
);


endmodule
