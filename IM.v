module IM(
    input [31:0] PC,
    output reg [31:0] Instr
);

reg [31:0] memory[0:11]; // 11 instructions

initial begin
  $readmemh("instruction.hex", memory); //Load instruction from File
end

always @(*) begin
  Instr = memory[PC>>2] ;// Fetch Instruction
end
endmodule