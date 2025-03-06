module RISCVProcessor(
    input clk, rst
);

    // Instruction Fetch (IF) Signals
    wire [31:0] Instr, PC_next, PC;

    // Instruction Decode (ID) Signals
    wire [31:0] ReadData1, ReadData2, imm;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode, funct7;
    wire [2:0] funct3;
    wire [3:0] ALU_control;
    wire RegWrite, Branch, ZeroFlag, MemWrite, MemRead, MemtoReg, ALUSrc;

    // Execution (EX) Signals
    wire [31:0] ALU_result;

    // Memory (MEM) Signals
    wire [31:0] MemData;

    // Write Back (WB) Signal
    wire [31:0] WriteBackData;

    // Program Counter (PC) Register
    PC pc_module(
        .clk(clk),
        .rst(rst),
        .PC_next(PC_next),
        .PC(PC)
    );

    // Instruction Memory
    IM instruction_memory(
        .PC(PC),
        .Instr(Instr)
    );

    // Instruction Decode Stage
    ID id_stage(
        .clk(clk),
        .rst(rst),
        .Instr(Instr),
        .RegWrite(RegWrite),
        .WriteData(WriteBackData),  // Corrected
        .rd(rd),  // Used directly instead of WriteReg
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .imm(imm),
        .rs1(rs1),
        .rs2(rs2),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7)
    );

    // Execution Stage (ALU Operations)
    EX_Stage ex_stage(
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .imm(imm),
        .rd(rd),
        .ALU_control(ALU_control),
        .ALUSrc(ALUSrc),
        .ALU_result(ALU_result),
        .ZeroFlag(ZeroFlag)
    );

    // Memory Access Stage
    MEM_Stage mem_stage(
        .clk(clk),
        .ALU_result(ALU_result),
        .WriteData(ReadData2),  // WriteData should come from ID Stage
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemData(MemData)
    );

    // Write Back Stage
    WB_Stage wb_stage(
        .ALU_result(ALU_result),
        .MemData(MemData),
        .MemtoReg(MemtoReg),
        .WriteBackData(WriteBackData)
    );

    // Branch Decision Logic (Sign-extend immediate properly)
    assign PC_next = (Branch && ZeroFlag) ? (PC + {{20{imm[31]}}, imm[11:0]}) : (PC + 4);

endmodule
