`include "regfile.v"
 `include "alu.v"
 `include "sign_extend.v"

module datapath (
	input clk, rst,
	input [2:0] alucontrol,
	input ALUSrc, branch, jump,MemToReg, MemWrite,RegDst,RegWrite,
	input  [31:0] instr,
	output [31:0] pc,
	input  [31:0] DataRead ,
	output [31:0] alu_result,
	output [31:0] DataWrite
);

	wire [31:0] pc_plus_4, pc_jump, pc_branch, pc_next, result, RegData1, RegData2, src_a, src_b, alu_out, imm_ext;
	wire pc_src;
	reg [31:0] pc;
	wire [5:0] rt, rd;
	wire [4:0] write_reg;
	wire c_out;

	assign pc_plus_4 = pc + 4;
	assign pc_jump = {pc_plus_4[31:28], instr[25:0], 2'b00};
	assign pc_src = branch & zero;
	assign pc_branch = pc_plus_4 + {imm_ext[29:0], 2'b00};
	assign pc_next = jump ? pc_jump : (pc_src ? pc_branch : pc_plus_4);

	always @(posedge clk) begin : proc_pc
		if(~rst) begin
			pc = pc_next;
		end else begin
			pc = 32'h00000000;
		end
	end
	regfile regfile_inst (.clk (clk), .rw(RegWrite), .addr1(instr[25:21]), .addr2(instr[20:16]), .addr3(write_reg), .wdata(result), .data1(RegData1), .data2(RegData2)
	);
	alu alu_inst ( .a (src_a), .b (src_b), .alu_control (alucontrol), .zero (zero), .c_out(c_out), .alu_out(alu_out)
	);
	sign_extend sign_extend_inst ( .DataIn(instr[15:0]), .DataOut(imm_ext)
	);
	assign rt = instr[20:16];
	assign rd = instr[15:11];
	assign write_reg = RegDst ? rd : rt;
	assign result = MemToReg ? DataRead : alu_result;
	assign src_a = RegData1;
	assign src_b = ALUSrc ? imm_ext : RegData2;
	assign alu_result = alu_out;
	assign DataWrite = RegData2;

endmodule
