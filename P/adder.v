module adder(
    input [31:0] PC,
    output [31:0] PC_next
);

assign PC_next = PC + 32'h4;

endmodule