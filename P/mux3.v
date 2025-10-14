module mux3(
    input jumpl_en,
    input [31:0]PC_new,
    input [31:0]alu_result,
    output [31:0] write_back
);

assign write_back = (jumpl_en) ? PC_new : alu_result;

endmodule   