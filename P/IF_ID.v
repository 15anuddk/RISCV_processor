module IF_ID(
    input clk,
    input reset,
    input [31:0] PC_new,
    input [31:0] PC_in,
    input [31:0] instruction,
    output reg [31:0]instr,
    output reg [31:0] PC_n,
    output reg [31:0] PC_in1
);

always @(posedge clk) begin
    if(reset) begin
        instr <= 32'b0;
        PC_n <= 32'b0;
        PC_in1 <= 32'b0;
    end
    else begin
        instr <= instruction;
        PC_n <= PC_new;
        PC_in1 <= PC_in;
    end
end

endmodule