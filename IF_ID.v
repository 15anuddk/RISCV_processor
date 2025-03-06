module IF_ID(
    input clk, rst,
    input [31:0] instr, pc,
    output reg [31:0] instr_out, pc_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        instr_out <= 32'b0;
        pc_out <= 32'b0;
    end else begin
        instr_out <= instr;
        pc_out <= pc;
    end
end

endmodule
