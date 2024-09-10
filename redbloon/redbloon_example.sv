module redbloon_example (
	input logic [9:0] RelativeXB, RelativeYB,
	input logic vga_clk, blank,
	output logic [3:0] red, green, blue
);

logic [9:0] rom_address;
logic [1:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;

assign rom_address = RelativeXB + RelativeYB * 32;

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

redbloon_rom redbloon_rom (
	.clock   (vga_clk),
	.address (rom_address),
	.q       (rom_q)
);

redbloon_palette redbloon_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

endmodule
