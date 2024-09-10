module bloonpop_rom (
	input logic clock,
	input logic [9:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:1023] /* synthesis ram_init_file = "./bloonpop/bloonpop.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
