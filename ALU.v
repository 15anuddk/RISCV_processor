module ALU (
    input [31:0] A, B,       // 32-bit ALU inputs
    input [3:0] ALU_Sel,     // 4-bit ALU operation selector
    output reg [31:0] ALU_Out,  // 32-bit ALU result
    output ZeroFlag           // Flag if result is zero
);
    
    assign ZeroFlag = (ALU_Out == 32'b0); // Zero flag set if ALU result is zero

    always @(*) begin
        case (ALU_Sel)
            4'b0000: ALU_Out = A & B;  // AND
            4'b0001: ALU_Out = A | B;  // OR
            4'b0010: ALU_Out = A + B;  // ADD
            4'b0011: ALU_Out = A << B; // SLL (Shift Left Logical)
            4'b0100: ALU_Out = A - B;  // SUB
            4'b0101: ALU_Out = A >> B; // SRL (Shift Right Logical)
            4'b0110: ALU_Out = A * B;  // MUL
            4'b0111: ALU_Out = A ^ B;  // XOR
            4'b1000: ALU_Out = (A < B) ? 1 : 0; // SLT (Set Less Than)
            default: ALU_Out = 32'b0;  // Default case
        endcase
    end

endmodule
