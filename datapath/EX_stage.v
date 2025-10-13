module EX_stage(
    input rs1_data,
    input rs2_data,
    input [3:0] alu_sel,
    output reg [31:0] alu_result,
    output reg alu_zero
);

alu alu_f(
    .A(rs1_data),
    .B(alu_src ? {{20{instruction[31]}}, instruction[31:20]} : rs2_data),
    .F(alu_result),
    .zeroflag(alu_zero),
    .S(alu_sel)
);

endmodule