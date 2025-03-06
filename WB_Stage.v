module WB_Stage(
    input [31:0] ALU_result, MemData,
    input MemtoReg,
    output reg [31:0] WriteBackData
);

always @(*) begin
    WriteBackData = (MemtoReg) ? MemData : ALU_result;
end

endmodule
