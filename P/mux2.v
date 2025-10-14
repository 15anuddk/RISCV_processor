module mux2(
    input [31:0] PC,
    input [31:0] PC_new,
    input jumpl_en,
    input [31:0] instruction,
    input branch_en,
    input zeroflag,
    output [31:0] PC_next
);

always @(*) begin
    if(jumpl_en) PC_next = PC + {{12{instruction[31]}}, instruction[31:12]};
    else if(branch_en && zeroflag) PC_next  = PC_next = PC + {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0}
    else PC_next = PC_new;
endmodule



