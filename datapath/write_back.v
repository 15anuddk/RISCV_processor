module write_back(
    input [31:0] alu_result, read_memdata,
    input mem_to_reg,
    output reg [31:0] write_data
);

always @(*) begin
  write_data = (mem_to_reg) ? read_memdata : alu_result;
end

endmodule