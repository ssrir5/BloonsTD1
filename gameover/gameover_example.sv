module gameover_example (
	input logic [9:0] RelativeXG, RelativeYG,
	input logic vga_clk, blank,
	output logic [3:0] red, green, blue
);

logic [13:0] rom_address;
logic [1:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;

assign rom_address = RelativeXG + (RelativeYG * 240);

always_ff @ (posedge vga_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;

	if (blank) begin
		red <= palette_red;
		green <= palette_green;
		blue <= palette_blue;
	end
end

gameover_rom gameover_rom (
	.clock   (vga_clk),
	.address (rom_address),
	.q       (rom_q)
);

gameover_palette gameover_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

endmodule
