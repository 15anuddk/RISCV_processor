module ControlUnit(
    input [6:0] opcode,
    output reg RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch,
    output reg [3:0] ALU_control
);

always @(*) begin
    // Default values
    RegWrite = 0; ALUSrc = 0; MemRead = 0; MemWrite = 0; MemtoReg = 0; Branch = 0;
    ALU_control = 4'b0000; // Default: No operation

    case (opcode)
        7'b0110011: begin // R-type (ADD, SUB, AND, OR, XOR, etc.)
            RegWrite = 1; ALUSrc = 0; MemRead = 0; MemWrite = 0; MemtoReg = 0;
            ALU_control = 4'b0010; // Default: ADD
        end
        7'b0000011: begin // LW (Load Word)
            RegWrite = 1; ALUSrc = 1; MemRead = 1; MemWrite = 0; MemtoReg = 1;
            ALU_control = 4'b0010; // ADD for address calculation
        end
        7'b0100011: begin // SW (Store Word)
            RegWrite = 0; ALUSrc = 1; MemRead = 0; MemWrite = 1; MemtoReg = 0;
            ALU_control = 4'b0010; // ADD for address calculation
        end
        7'b1100011: begin // BEQ (Branch if Equal)
            RegWrite = 0; ALUSrc = 0; MemRead = 0; MemWrite = 0; MemtoReg = 0;
            Branch = 1; // Activate branching
            ALU_control = 4'b0110; // SUB for comparison (ZeroFlag will be used)
        end
        default: begin
            RegWrite = 0; ALUSrc = 0; MemRead = 0; MemWrite = 0; MemtoReg = 0;
            Branch = 0;
            ALU_control = 4'b0000; // Default No-op
        end
    endcase
end

endmodule
