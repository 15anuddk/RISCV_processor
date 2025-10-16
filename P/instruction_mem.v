`include "instruction.hex"
module instruction_mem(
    input [31:0] address,
    output reg[31:0]instruction
);

reg [31:0] instr_mem[0:63];

initial begin
  $readmemh("instruction.hex", instr_mem);
end

always @(*) begin
  if((address >> 2) < 64) instruction = instr_mem[(address >> 2)];
  else instruction = 32'b0;
end

endmodule