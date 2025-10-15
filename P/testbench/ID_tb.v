module ID_tb();

reg clk;
reg reset;
reg [31:0] PC_n;
reg [31:0] instr;

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
wire [31:0] PC_new;

ID_EX uut(.clk(clk),
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
          .PC_new(PC_new));


always #10 clk = ~clk;

initial begin
  $dumpfile("ID_EX_test.vcd");
  $dumpvars(0, ID_tb);
  $monitor("mem_read = %b , mem_read_n = %b ||", mem_read, mem_read_n,
            "mem_write = %b  gtkwave, mem_write_n = %b", mem_write, mem_write_n,
            "mem_to_reg = %b , mem_to_reg_n = %b", mem_to_reg , mem_to_reg_n,
            "jumpl = %b , jumpl_en = %b ", jumpl, jumpl_n,
            "branch = %b , branch_n = %b", branch, branch_n,
            "A_in = %h , A = %h reg_write =%b", A_in, A, reg_write,
            "B_in = %h , B = %h alusrc = %b regwrite = %b", B_in, B, alu_src, reg_write,
            "alu_sel = %b",alu_sel,"                              ");
end

initial begin
  clk = 0;
  reset = 1;
  instr = 32'h00012083; // mem_read_n
  #20reset = 0;

  #20instr = 32'h00322023; //memwrite

  #20 instr = 32'h00832283; // mem_to_reg_n

  #20instr = 32'h008000ef; //jumpl_n

  #20 instr = 32'h00208663; //branch

  #20 instr = 32'h005201b3; // A

  #20 instr = 32'h00a38313; //B addi

  #20 instr = 32'h00a4c433; //xor sel
  PC_n = 32'h12;
  #20
  #10
  $finish;
end

endmodule