module imm(
    input alu_src,
    input mem_write_en,
    input [31:0] instruction,
    input [31:0] rs2_data,
    output reg [31:0] B
);

always @(*) begin
    if(alu_src == 1'b1 && mem_write_en) begin //store instruction
      B = {{25{instruction[31]}}, instruction[31:25]};
    end
    else if(alu_src == 1'b1) begin
      B = {{20{instruction[31]}},instruction[31:20]};
    end
    else B = rs2_data;
end

endmodule