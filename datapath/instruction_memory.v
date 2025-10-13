module instruction_memory(
    input [31:0] addr,
    output reg[31:0] instruction
);

reg [31:0] instr_mem [0:255];

initial begin
  $readmemh("instruction.hex", instr_mem);
end

always @(*) begin
  if((addr >> 2) < 256) instruction = instr_mem[addr>>2];
  else instruction = 32'b0;
end

endmodule