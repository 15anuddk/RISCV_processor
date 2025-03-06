module decoder(
    input [31:0] Instr,
    output reg [6:0] opcode,
    output reg[4:0] rs1, rs2, rd,
    output reg[2:0] funct3,
    output reg[6:0] funct7,
    output reg [31:0] imm
);

always @(*) begin
    opcode = Instr[6:0];   // Extract opcode
    rd = Instr[11:7];      // Destination register
    funct3 = Instr[14:12]; // funct3
    rs1 = Instr[19:15];    // Source register 1
    rs2 = Instr[24:20];    // Source register 2
    funct7 = Instr[31:25]; // funct7

    case (opcode)
        7'b0010011, 7'b0000011, 7'b1100111: // I-type (ADDI, LOAD, JALR)
            imm = {{20{Instr[31]}}, Instr[31:20]};
        7'b0100011: // S-type (STORE instructions)
            imm = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};
        7'b1100011: // B-type (Branch instructions)
            imm = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};
        7'b0110111, 7'b0010111: // U-type (LUI, AUIPC)
            imm = {Instr[31:12], 12'b0};
        7'b1101111: // J-type (JAL)
            imm = {{11{Instr[31]}}, Instr[31], Instr[19:12], Instr[20], Instr[30:21], 1'b0};
        default:
            imm = 32'b0;
    endcase
end
endmodule