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
