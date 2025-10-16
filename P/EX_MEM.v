module EX_MEM(
    input clk,
    input reset,
    input mem_to_reg,
    input mem_read,
    input mem_write,
    input [31:0] alu_out,
    input [31:0] rs2_data,
    output reg mem_to_reg_n2,
    output reg mem_read_n2,
    output reg mem_write_n2,
    output reg [31:0] alu_out_n,
    output reg [31:0] rs2_data_n
);

always @(posedge clk) begin
  if(reset) begin
    mem_to_reg_n2 <= 1'b0;
    mem_read_n2 <= 1'b0;
    mem_write_n2 <= 1'b0;
    alu_out_n <= 32'b0;
    rs2_data_n <= 32'b0;
  end
  else begin
    mem_to_reg_n2 <= mem_to_reg;
    mem_read_n2 <= mem_read;
    mem_write_n2 <= mem_write;
    alu_out_n <= alu_out;
    rs2_data_n <= rs2_data;
  end
end

endmodule