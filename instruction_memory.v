module instructionmemory (
	input [5:0] addr,
	output [31:0] data
);
	reg [31:0] data;
	always @(addr) begin
		case(addr)
			00 : data = 32'b000000_00001_00010_00011_00000_100000;
			01 : data = 32'b000000_00010_00011_00100_00000_100000;
			02 : data = 32'b000000_00011_00100_00101_00000_100000;
			03 : data = 32'b000000_00100_00101_00110_00000_100000;
			04 : data = 32'b000000_00101_00110_00111_00000_100000;
			05 : data = 32'b000000_00110_00111_01000_00000_100000;
			06 : data = 32'b000000_00111_01000_01001_00000_100000;
			07 : data = 32'b000000_01000_01001_01010_00000_100000;
			08 : data = 32'b000000_01001_01010_01011_00000_100000;
			09 : data = 32'b100011_01011_01100_0000000000100000;
		endcase
	end
endmodule
