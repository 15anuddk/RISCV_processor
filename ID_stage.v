module id_stage(
    input clk,
    input reset,
    input [31:0] instruction,
    input [31:0] write_data,


    output [31:0] rs1_data,
    output [31:0] rs2_data,
    output reg [3:0] alu_sel,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg mem_to_reg,
    output reg alu_src
);
    wire [6:0]opcode,
    wire [4:0] rs1, rs2, 
    wire  [2:0] func3,
    wire [6:0] func7,
    wire [4:0] rd 

instruction_decoder id_f(
    .instruction(instruction),
    .opcode(opcode),
    .rs1(rs1),
    .rs2(rs2),
    .func3(func3),
    .func7(func7),
    .rd(rd)
);

//instruction goes to control Unit
CV cv_f(
    .opcode(opcode),
    .func3(func3),
    .func7(func7),
    .alu_sel(alu_sel),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .branch(branch),
    .mem_to_reg(mem_to_reg),
    .alu_src(alu_src)
);

wire reg_write;
wire [31:0] write_data;
//we need data from register
register_file reg_file_f(
    .clk(clk),
    .reset(reset),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .reg_write(reg_write),
    .write_data(write_data),
    .rs1_data(rs1_data),
    .rs2_data(rs2_data)
);

endmodule
