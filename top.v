`include "mips.v"
`include "datamemory.v"
`include "instructionmemory.v"

module top (
	input clk,reset
);
	wire [31:0] imem_data, imem_addr, dmem_rdata, dmem_addr, dmem_wdata;
	wire dmem_we;
	instructionmemory instrmem (.addr(imem_addr[7:2]), .data(imem_data)
	);
	mips mips (.clk (clk), .rst (reset), .imem_data (imem_data), .imem_addr (imem_addr), .dmem_rdata(dmem_rdata), .dmem_we (dmem_we), .dmem_addr (dmem_addr), .dmem_wdata(dmem_wdata)
	);
	datamemory datamem ( .clk(clk), .we (dmem_we), .addr(dmem_addr), .wdata(dmem_wdata), .rdata(dmem_rdata)
	);
endmodule
