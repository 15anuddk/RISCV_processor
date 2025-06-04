module PC(
    input clk,
    input reset,
    input [31:0] PC_next,
    input [31:0] PC
);

always @(posedge clk or posedge reset) begin
  if(reset) PC <= 32'b0;
  else PC <= PC_next;

  $display("PC updated PC=%h, PC_next =%h", PC , PC_next);
end
endmodule