module PC(
    input clk,
    input reset,
    input [31:0]PC_next,
    output reg [31:0] PC
);

always @(posedge clk) begin
    $display("IF ");
    if(reset) PC <= 32'b0;
    else PC <= PC_next;
end

endmodule