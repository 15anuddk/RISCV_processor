module EX_tb();

reg clk,reset;

reg [31:0] PC_n2, PC_in2;
reg branch_n, jumpl_n,mem_read_n, mem_to_reg_n, mem_write_n;
reg [31:0] A, B,rs2data, instr_n;
reg [3:0] alu_select;

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

wire [31:0] PC_next_in;

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

always #10 clk = ~clk;

initial begin
  $dumpfile("EX_tb_test.vcd");
  $dumpvars(0,EX_tb);
end

initial begin
  clk = 0;
  reset = 1;

  instr_n = 32'h002082B3;
        A = 32'd10;        // x1
        B = 32'd20;        // x2
        alu_select = 4'b0000; // ADD
        mem_to_reg_n = 0;
        mem_read_n = 0;
        mem_write_n = 0;
        rs2data = B;
  #20 reset = 0;
  #10 $strobe("ADD -> alu_out_n = %d, rs2_data_n = %d",  alu_out_n, rs2_data_n);
  #20
  instr_n = 32'h00C32303;
        A = 32'd100;      // base (x3)
        B = 32'd12;       // immediate offset
        alu_select = 4'b0000; // address calc
        mem_to_reg_n = 1;
        mem_read_n = 1;
        mem_write_n = 0;
       #10 $strobe("LW  -> alu_out_n = %d, rs2_data_n = %d",  alu_out_n, rs2_data_n);
   #20
   instr_n = 32'h00732223;
        A = 32'd200;      // base (x3)
        B = 32'd16;       // offset
        rs2data = 32'd55; // data from x7
        alu_select = 4'b0000;
        mem_to_reg_n = 0;
        mem_read_n = 0;
        mem_write_n = 1;
      #10  $strobe("ADD -> alu_out_n = %d, rs2_data_n = %d", alu_out_n, rs2_data_n);
        #20 $finish;
end

endmodule

