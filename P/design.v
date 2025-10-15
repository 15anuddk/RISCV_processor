`include "PC.v"
module design(
    input clk,
    input reset,
);

wire [31:0] PC_in, PC_next_in;
PC program_counter(.clk(clk),
                    .reset(reset),
                    .PC_next(PC_next_in),
                    .PC(PC_in));

wire [31:0] PC_new;
adder PC_add(.PC(PC_in),
            .PC_new(PC_new));


wire [31:0] instruction;
instruction_mem i_m(.address(PC_in),
                    .instruction(instruction));

wire[31:0]instr, PC_n;

IF_ID IF(.clk(clk),
        .reset(reset),
        .PC_new(PC_new),
        .instruction(instruction),
        .instr(instr),
        .PC_n(PC_n));

wire [6:0] funct7, opcode;
wire [4:0] rs1,rs2,rd;
wire [2:0] funct3;

decoder decode(.instruction(instr),
                .func3(funct3),
                .func7(funct7),
                .rs1(rs1),
                .rs2(rs2),
                .rd(rd),
                .opcode(opcode));

