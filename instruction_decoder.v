module instruction_decoder(
    input [31:0] instruction, //32 bit instruction
    output reg [6:0]opcode, //7bit opcode
    output reg [4:0] rs1, rs2, // source register
    output reg [2:0] func3,
    output reg[6:0] func7,
    output reg[4:0] rd //destination register
);

assign opcode = instruction[6:0];
assign rs1 = instruction[19:15];
assign rs2 = instruction [24:20];
assign func3 = instruction[14:12];
assign func7 = instruction [31:25];
assign rd = instruction[11:7];

endmodule
