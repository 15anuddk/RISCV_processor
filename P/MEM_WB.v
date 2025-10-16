module MEM_WB(
    input clk,
    input reset,
    input mem_to_reg_n2,
    input [31:0] read_data,
    input [31:0] alu_result,
    output reg mem_to_reg_n3,
    output reg [31:0] read_data_n,
    output reg [31:0] alu_result_n
);


always @(posedge clk) begin
  if(reset) begin
    mem_to_reg_n3 <= 1'b0;
    read_data_n<= 32'b0;
    alu_result_n <= 32'b0;
  end
  else begin
    mem_to_reg_n3 <= mem_to_reg_n2;
    read_data_n <= read_data;
    alu_result_n <= alu_result;
  end
end

endmodule

