module datapath(
    input clk,
    input reset,
    output [31:0] PC_next, PC,
    output [31:0] instruction
);

//to get the program counter
ProgramCounter pc_inst(
    .clk(clk),
    .reset(reset),
    .PC_next(PC_next),
    .PC(PC)
);

//get the instruction at the particular address
instruction_memory instr_mem_inst(
    .addr(PC),
    .instruction(instruction)
);

wire [6:0] opcode,func7;
wire [4:0] rs1,rs2,rd;
wire [2:0] func3;
//after we get the instruction, decode the instruction
instruction_decoder instr_decoder_inst(
    .instruction(instruction),
    .opcode(opcode),
    .rs1(rs1),
    .rs2(rs2),
    .func3(func3),
    .func7(func7),
    .rd(rd)
);

wire [3:0]alu_sel;
wire reg_write; 
wire mem_read;
wire mem_write;
wire branch;
wire mem_to_reg;
wire alu_src;
//instruction goes to control Unit
CV cv_inst(
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

wire [31:0] rs1_data, rs2_data, write_data;
//we need data from register
register_file reg_file_inst(
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

wire [31:0] alu_result;
wire alu_zero;
//from control unit we get alu_sel values, thus first continuing with ALU
ALU alu_inst(
    .A(rs1_data),
    .B(alu_src ? {{20{instruction[31]}}, instruction[31:20]} : rs2_data),
    .F(alu_result),
    .zeroflag(alu_zero)
);

//memory for load and store
wire [31:0] read_memdata;
wire [31:0] write_memdata;
wire [31:0] mem_addr;

data_mem data_mem_inst(
    .clk(clk),
    .address(mem_addr),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .write_data(write_memdata),
    .read_data(read_memdata)
);

assign PC_next = (branch && alu_zero) ? 
               (pc_out + {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0}) 
               : (pc_out + 4);

endmodule