module ALU(
    input [3:0] sel,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] out,
    output reg zeroflag
);

always @(*) begin
     $display("EX ");
    case(sel)
        4'b0000: out = A + B;
        4'b0001: out = A - B;
        4'b0010: out = A ^ B;
        4'b0011: out = A | B;
        4'b0100: out = A & B;
        4'b0101: out = A << B; //ShiftLeftLogical
        4'b0110: out = A >> B; //ShiftRightLogical
        4'b0111: out = A >> B; //ShiftRightArith*
        4'b1000: out = (A < B) ? 1 : 0;
        4'b1001: out = (A < B) ? 1 : 0;

        default: out = 32'b0;
    
    endcase 

    zeroflag = (out == 32'b0); 
end

endmodule





