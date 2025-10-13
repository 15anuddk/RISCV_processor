module riscv(
    input clk,
    input reset
);

wire [31:0] pc, instruction_in;

if_stage unit1(
    .clk(clk),
    .reset(reset),
    .PC(pc),
    .instruction(instruction_in)
);

    wire [31:0] write_data;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [3:0] alu_sel;
    wire mem_read;
    wire mem_write;
    wire branch;
    wire mem_to_reg;
    wire alu_src;

id_stage unit2(.clk(clk),
                .reset(reset),
                .instruction(instruction),
                .rs1_data(rs1_data),
                .rs2_data(rs2_data),
                .alu_sel(alu_sel),
                .mem_read(mem_read),
                .mem_write(mem_write),
                .branch(branch),
                .mem_to_reg(mem_to_reg),
                .alu_src(alu_src)
);

wire [31:0] alu_result;
wire alu_zero;

EX_stage unit3(.rs1_data(rs1_data),
               .rs2_data(rs2_data),
               .alu_sel(alu_sel),
               .alu_result(alu_result),
               .alu_zero(alu_zero));

wire [31:0] read_memdata;
wire [31:0] mem_addr;

data_mem unit3(
    .clk(clk),
    .address(mem_addr),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .write_data(rs2_data),
    .read_data(read_memdata)
);

write_back unit4(
    .alu_result(alu_result),
    .read_memdata(read_memdata),
    .mem_to_reg(mem_to_reg),
    .write_data(write_data)
);

endmodule



