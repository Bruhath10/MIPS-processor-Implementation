module datamemory (
	input clk,we,
	input [31:0] addr, wdata,
	output [31:0] rdata
);
	reg [31:0] memdata [127:0];
	assign rdata = memdata[addr];
	always @(posedge clk) begin
		if(we==1'b1) begin
			memdata[addr] = wdata;
		end
	end
endmodule
