module mux1(
    input mem_to_reg_en,
    input [31:0] read_data,
    input [31:0] alu_res,
    output reg [31:0] write_data
);
always @(*) begin
  $display("WB ");
  write_data = (mem_to_reg_en) ? read_data : alu_res; 
end
 


endmodule