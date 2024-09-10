module bloon_background_rom (
	input logic clock,
	input logic [18:0] address,
	output logic [4:0] q
);

logic [4:0] memory [0:307199] /* synthesis ram_init_file = "./bloon_background/bloon_background.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
