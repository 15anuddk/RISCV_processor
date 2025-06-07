module register_file(
    input clk,
    input reset,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input reg_write,
    input [31:0] write_data,
    output [31:0] rs1_data,
    output [31:0] rs2_data  
);

reg [31:0] registers[0:31];

assign rs1_data = registers[rs1];
assign rs2_data = registers[rs2];

integer i;
always @(posedge clk or posedge reset) begin
 $display("Reading: rs1=%d -> %h | rs2=%d -> %h", rs1, rs1_data, rs2, rs2_data);
    if(reset) begin
      for(i=0;i<32;i++) begin
        registers[i] = 32'b0;
      end 
    end

    if(reg_write && rd != 5'b0) begin
      registers[rd] <= write_data;
      $display("Time=%t: Register Write rd=%d data=%h", $time, rd, write_data);
    end
end
endmodule

