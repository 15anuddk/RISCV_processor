module adder(
    input [31:0] PC,
    output [31:0] PC_new
);

assign PC_new = PC + 32'h4;

endmodule