module ID_tb();

reg clk;
reg reset;
reg [31:0] PC_n;
reg [31:0] instr;

wire [6:0] funct7, opcode;
wire [4:0] rs1,rs2,rd;
wire [2:0] funct3;

decoder uut(.instruction(instr),
                .func3(funct3),
                .func7(funct7),
                .rs1(rs1),
                .rs2(rs2),
                .rd(rd),
                .opcode(opcode));

wire [6:0] funct7_n, opcode_n;
wire [4:0] rs1_n,rs2_n,rd_n;
wire [2:0] funct3_n;
wire [31:0] PC_new;

ID_EX uut2(.clk(clk),
            .reset(reset),
            .funct3(funct3),
            .funct7(funct7),
            .rs2(rs2),
            .rs1(rs1),
            .opcode(opcode),
            .PC_n(PC_n),
            .funct7_n(funct7_n),
            .rs2_n(rs2_n),
            .rs1_n(rs1_n),
            .funct3_n(funct3_n),
            .rd_n(rd_n),
            .opcode_n(opcode_n),
            .PC_new(PC_new));


always #10 clk = ~clk;

initial begin
  $dumpfile("ID_test.vcd");
  $dumpvars(0,ID_tb);
  $monitor("instruction = %b rs1 = %b rs2 = %b rd = %b opcode = %b funct3 = %b funct7 = %b rs1_n = %b , rs2_n = %b , rd_n = %b , opcode_n = %b , funct3_n = %B, funct7_n = %b", instr,rs1,rs2,rd,opcode,funct3,funct7,rs1_n, rs2_n,rd_n,opcode_n,funct3_n,funct7_n);
end

initial begin
  clk = 0;
  reset = 1;
  instr = 32'h00500113;
  PC_n = 32'h12;
  #10 reset = 0;

  #20 instr = 32'h00A00193;
  #20 instr = 32'h00002223;
  #20 $finish;
end

endmodule