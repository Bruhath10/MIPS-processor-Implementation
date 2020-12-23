`include "controlsignals.v"
`include "aluoperationcontrol.v"
module controller (
	input  [31:0] instr,
	output branch,jump,MemToReg, MemWrite,RegDst,RegWrite,
	output [ 2:0] alucontrol,
	output ALUSrc
);
	controlsignals i0 (
		.instr(instr),.branch(branch), .jump(jump), .MemToReg(MemToReg), .MemWrite(MemWrite), .RegDst(RegDst), .RegWrite(RegWrite), .ALUSrc(ALUSrc)
	);
	aluoperationcontrol i1 (.instr(instr), .alucontrol(alucontrol));
endmodule
