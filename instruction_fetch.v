module if_stage(
    input clk,
    input reset,
    output reg [31:0] PC,
    output reg [31:0] instruction
);

wire [31:0]PC_next;
assign PC_next = PC + 4;
ProgramCounter pc_f(
    .clk(clk),
    .reset(reset),
    .PC_next(PC_next),
    .PC(PC)
);

instruction_memory im_f(
    .addr(PC);
    .instruction(instruction)
);

endmodule