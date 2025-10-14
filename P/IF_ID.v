module IF_ID(
    input clk,
    input reset,
    input [31:0] PC_new,
    input [31:0] instruction,
    output reg [31:0]instr,
    output reg [31:0] PC_n
);

always @(posedge clk) begin
    if(reset) begin
        instr <= 32'b0;
        PC_n <= 32'b0;
    end
    else begin
        instr <= instruction;
        PC_n <= PC_new;
    end
end

endmodule