`timescale 1ns / 1ps

module ID_tb;
    reg clk, rst, RegWrite;
    reg [31:0] Instr, WriteData;
    reg [4:0] WriteReg;
    wire [31:0] ReadData1, ReadData2, imm;
    wire [4:0] rs1, rs2, rd;
    wire [6:0] opcode, funct7;
    wire [2:0] funct3;

    // Instantiate ID stage
    ID id_inst(
        .clk(clk),
        .rst(rst),
        .RegWrite(RegWrite),
        .Instr(Instr),
        .WriteData(WriteData),
        .WriteReg(WriteReg),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .imm(imm),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7)
    );

    always #5 clk = ~clk; // Clock generator (10ns period)

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, ID_tb);

        clk = 0;
        rst = 1; #10; // Reset
        rst = 0;

        // Example: ADD instruction (opcode 0110011, rd=1, rs1=2, rs2=3, funct3=000, funct7=0000000)
        Instr = 32'b0000000_00011_00010_000_00001_0110011; #10;
        
        // Example: ADDI instruction (opcode 0010011, rd=1, rs1=2, imm=5, funct3=000)
        Instr = 32'b000000000101_00010_000_00001_0010011; #10;

        // Example: BEQ instruction (opcode 1100011, rs1=1, rs2=2, imm=4, funct3=000)
        Instr = 32'b0000000_00010_00001_000_00001_1100011; #10;

        // Example: LUI instruction (opcode 0110111, rd=1, imm=0xFFFFF)
        Instr = 32'b11111111111111111111_00001_0110111; #10;

        $finish;
    end
endmodule
