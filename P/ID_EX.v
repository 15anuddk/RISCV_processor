module ID_EX(
    input clk,
    input reset,
    input mem_read_en,
    input mem_write_en,
    input mem_to_reg_en,
    input jumpl_en,
    input branch,
    input [31:0] A_in,
    input [31:0] B_in,
    input [3:0]sel,
    input [31:0] PC_n,
    input [31:0] PC_in,
    input [31:0] rs2_data,
    input [31:0] instr,
    output reg mem_read_n,
    output reg mem_write_n,
    output reg mem_to_reg_n,
    output reg jumpl_n,
    output reg branch_n,
    output reg [31:0] A,
    output reg [31:0] B,
    output reg [3:0] alu_select,
    output reg[31:0] PC_n2,
    output reg[31:0] PC_in2,
    output reg [31:0] rs2data,
    output reg [31:0] instr_n
);


always @(posedge clk) begin
  if(reset)begin
    mem_read_n <=1'b0;
    mem_write_n <=1'b0;
    mem_to_reg_n <=1'b0;
    jumpl_n <=1'b0;
    branch_n <=1'b0;
    A <=  32'b0;
    B <= 32'b0;
    alu_select <= 4'b0;
    PC_n2 <= 32'b0;
    PC_in2 <= 32'b0;
    instr_n <= 32'b0;
  end
  else begin
    mem_read_n <= mem_read_en;
    mem_write_n <= mem_write_en;
    mem_to_reg_n <= mem_to_reg_en;
    jumpl_n <= jumpl_en;
    branch_n <= branch;
    A <=  A_in;
    B <= B_in;
    alu_select <= sel;
    PC_n2 <= PC_n;
    PC_in2 <= PC_in;
    rs2data <= rs2_data;
    instr_n <= instr;
  end
end

endmodule
