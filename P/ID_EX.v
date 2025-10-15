module ID_EX(
    input clk,
    input reset,
    input [6:0]funct7,
    input [4:0] rs2,
    input [4:0] rs1,
    input [2:0] funct3,
    input [4:0] rd,
    input [6:0] opcode,
    input [31:0] PC_n,
    output reg[6:0]funct7_n,
    output reg[4:0] rs2_n,
    output reg[4:0] rs1_n,
    output reg[2:0] funct3_n,
    output reg[4:0] rd_n,
    output reg[6:0] opcode_n,
    output reg [31:0] PC_new
);


always @(posedge clk) begin
  if(reset)begin
    funct7_n <= 7'b0;
    rs2_n <= 5'b0;
    rs1_n <= 5'b0;
    rd_n <= 5'b0;
    opcode_n <= 7'b0;
    PC_new <= 32'b0;
  end
  else begin
    funct7_n <= funct7;
    funct3_n <= funct3;
    rs2_n <= rs2;
    rs1_n <= rs1;
    rd_n <= rd;
    opcode_n <= opcode;
    PC_new <= PC_n;
  end
end

endmodule
