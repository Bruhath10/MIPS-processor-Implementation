`include "datapath.v"
`include "controller.v"

module mips (
    input clk,rst,
    input  [31:0] imem_data,
    output [31:0] imem_addr,
    input  [31:0] dmem_rdata,
    output dmem_we,
    output [31:0] dmem_addr,
    output [31:0] dmem_wdata
);
    wire [2:0] alucontrol;
    wire ALUSrc, branch, jump, MemToReg, RegDst, RegWrite;
    controller controller_inst (.instr(imem_data ), .alucontrol(alucontrol), .ALUSrc(ALUSrc), .branch(branch), .jump(jump), .MemToReg(MemToReg), .MemWrite(dmem_we), .RegDst(RegDst), .RegWrite(RegWrite)
    );
    datapath datapath_inst (.clk(clk), .rst(rst), .alucontrol(alucontrol), .ALUSrc(ALUSrc), .branch(branch), .jump (jump), .MemToReg(MemToReg), .MemWrite(dmem_we), .RegDst(RegDst), .RegWrite (RegWrite), .instr(imem_data), .pc (imem_addr), .DataRead (dmem_rdata), .alu_result(dmem_addr ), .DataWrite(dmem_wdata)
    );
endmodule
