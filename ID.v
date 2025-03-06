module ID(
   input clk,
    input rst,
    input RegWrite,
    input [31:0] Instr,     // Instruction from IF stage
    input [31:0] WriteData, // Data to write to register
    input [4:0] WriteReg,   // Destination register for writing
    output [31:0] ReadData1, ReadData2, // Register values
    output [31:0] imm,      // Immediate value
    output [4:0] rs1, rs2, rd, // Register addresses
    output [6:0] opcode, funct7, // Opcode & funct7
    output [2:0] funct3   // funct3 
);

    // Wires for decoded instruction fields
    wire [4:0] d_rs1, d_rs2, d_rd;
    wire [6:0] d_opcode, d_funct7;
    wire [2:0] d_funct3;
    wire [31:0] d_imm;

    // Instantiate Decoder
    decoder decoder(
        .Instr(Instr),
        .opcode(d_opcode),
        .rs1(d_rs1),
        .rs2(d_rs2),
        .rd(d_rd),
        .funct3(d_funct3),
        .funct7(d_funct7),
        .imm(d_imm)
    );

    // Instantiate Register File
    RF registerFile(
        .clk(clk),
        .rst(rst),
        .RegWrite(RegWrite),
        .ReadReg1(d_rs1),
        .ReadReg2(d_rs2),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // Assign outputs
    assign rs1 = d_rs1;
    assign rs2 = d_rs2;
    assign rd = d_rd;
    assign opcode = d_opcode;
    assign funct3 = d_funct3;
    assign funct7 = d_funct7;
    assign imm = d_imm;

endmodule