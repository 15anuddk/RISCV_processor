module EX_Stage(
    input [31:0] ReadData1, ReadData2, // Register values
    input [31:0] imm, // Immediate value
    input [3:0] ALU_control, // ALU operation control
    input ALUSrc, // Selects second operand (register or immediate)
    input [4:0] rd, // Destination register
    output [31:0] ALU_result, // ALU output
    output ZeroFlag, // Zero flag for branches
    output [4:0] rd_out // Destination register output
);

// Operand selection: choose between register value or immediate
wire [31:0] operand2;
assign operand2 = (ALUSrc) ? imm : ReadData2;

// ALU Instance
ALU alu_instance (
    .A(ReadData1),        // First operand
    .B(operand2),         // Second operand (register or immediate)
    .ALU_Sel(ALU_control), // ALU control signal
    .ALU_Out(ALU_result), // Output from ALU
    .ZeroFlag(ZeroFlag)   // Zero flag for branch condition
);

// Pass Destination Register
assign rd_out = rd;

endmodule
