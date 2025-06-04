//ALU IC 74181
`timescale 1ns / 1ps

module alu(
    input [31:0] A , B, //input
    input [3:0] S, //select
    output reg [31:0] F, //output
    output reg zeroflag
);


always @(*) begin
    case(S)
        4'b0000: F = A + B;  // ADD
        4'b0001: F = A - B;  // SUB
        4'b0010: F = A << B;  // SLL
        4'b0011: F = (A < B) ? 1 : 0; // Sel less than
        4'b0100: F = A ^ B;  // XOR
        4'b0101: F = A >> B; // SRL (Shift Right Logical)
        4'b0110: F = A | B;  // OR
        4'b0111: F = A & B;  // AND
        4'b1000: F = (A < B) ? 1 : 0; // SLT (Set Less Than) logial
        default: F = 32'b0;  // Default case
    endcase

    zeroflag = (F == 32'b0);
end

endmodule

