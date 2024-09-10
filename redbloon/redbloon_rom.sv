module redbloon_rom (
	input logic clock,
	input logic [9:0] address,
	output logic [1:0] q
);

logic [1:0] memory [0:1023] /* synthesis ram_init_file = "./redbloon/redbloon.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
