module riscv(
    input clk,
    input reset
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

wire[31:0]instr, PC_n, PC_in1;

IF_ID IF(.clk(clk),
        .reset(reset),
        .PC_new(PC_new),
        .instruction(instruction),
        .instr(instr),
        .PC_n(PC_n),
        .PC_in(PC_in),
        .PC_in1(PC_in1));


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


wire alu_op, reg_write, alu_src;
wire mem_to_reg, mem_read, mem_write;
wire jumpl, branch;
control_unit controller(.reset(reset),
                        .opcode(opcode),
                        .alu_op(alu_op),
                        .reg_write_en(reg_write),
                        .alu_src(alu_src),
                        .mem_to_reg_en(mem_to_reg),
                        .mem_read_en(mem_read),
                        .mem_write_en(mem_write),
                        .jumpl_en(jumpl),
                        .branch_en(branch));


wire [3:0] alu_sel;
alu_ctrl a_c(.func3(funct3),
            .func7(funct7),
            .alu_op(alu_op),
            .sel(alu_sel));

wire [31:0] write_data;
wire [31:0] rs1_data , rs2_data;
reg_file registers(.reset(reset),
                    .rs1(rs1),
                    .rs2(rs2),
                    .rd(rd),
                    .reg_write_en(reg_write),
                    .write_data(write_data),
                    .rs1_data(rs1_data),
                    .rs2_data(rs2_data));

wire [31:0] A_in, B_in;
assign A_in = rs1_data;
imm imm_values(.alu_src(alu_src),
                .mem_write_en(mem_write),
                .instruction(instr),
                .rs2_data(rs2_data),
                .B(B_in));

wire mem_read_n;
wire mem_write_n;
wire mem_to_reg_n;
wire jumpl_n;
wire branch_n;
wire [31:0] A;
wire [31:0] B;
wire [3:0] alu_select;
wire [31:0] PC_n2;
wire[31:0] PC_in2, rs2data,instr_n;

ID_EX ID(.clk(clk),
          .reset(reset),
          .mem_read_en(mem_read),
          .mem_write_en(mem_write),
          .mem_to_reg_en(mem_to_reg),
          .jumpl_en(jumpl),
          .branch(branch),
          .A_in(A_in),
          .B_in(B_in),
          .sel(alu_sel),
          .PC_n(PC_n),
          .mem_read_n(mem_read_n),
          .mem_write_n(mem_write_n),
          .mem_to_reg_n(mem_to_reg_n),
          .jumpl_n(jumpl_n),
          .branch_n(branch_n),
          .A(A),
          .B(B),
          .alu_select(alu_select),
          .PC_n2(PC_n2),
          .PC_in(PC_in1),
          .PC_in2(PC_in2),
          .rs2_data(rs2_data),
          .rs2data(rs2data),
          .instr(instr),
          .instr_n(instr_n));

wire [31:0] Alu_out;
wire zerof;
ALU alu(.sel(alu_select),
        .A(A),
        .B(B),
        .out(Alu_out),
        .zeroflag(zerof));

wire [31:0] writeback;

mux3 WB(.jumpl_en(jumpl_n),
        .PC_new(PC_in2),
        .alu_result(Alu_out),
        .write_back(writeback));

mux2 pc(.PC(PC_in2),
        .PC_new(PC_n2),
        .jumpl_en(jumpl_n),
        .instruction(instr_n),
        .branch_en(branch_n),
        .zeroflag(zerof),
        .PC_next(PC_next_in));

wire mem_read_n2, mem_to_reg_n2, mem_write_n2;
wire [31:0] alu_out_n,rs2_data_n;

EX_MEM uut(.clk(clk),
        .reset(reset),
        .mem_to_reg(mem_to_reg_n),
        .mem_read(mem_read_n),
        .mem_write(mem_write_n),
        .alu_out(Alu_out),
        .rs2_data(rs2data),
        .mem_to_reg_n2(mem_to_reg_n2),
        .mem_read_n2(mem_read_n2),
        .mem_write_n2(mem_write_n2),
        .alu_out_n(alu_out_n),
        .rs2_data_n(rs2_data_n));

wire [31:0] read_data;

memory mem(
    .clk(clk),
    .reset(reset),
    .address(address),
    .mem_write_en(mem_write_n2),
    .mem_read_en(mem_read_n2),
    .write_data(writedata),
    .read_data(read_data));

wire mem_to_reg_n3;
wire [31:0] read_data_n, alu_result_n;
MEM_WB uut(
    .clk(clk),
    .reset(reset),
    .mem_to_reg_n2(mem_to_reg_n2),
    .read_data(read_data),
    .alu_result(address),
    .mem_to_reg_n3(mem_to_reg_n3),
    .read_data_n(read_data_n),
    .alu_result_n(alu_result_n));            

    