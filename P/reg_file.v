module reg_file(
    input reset,
    input [4:0]rs1,
    input [4:0]rs2,
    input [4:0]rd,
    input reg_write_en,
    input [31:0] write_data,
    output [31:0] rs1_data,
    output [31:0] rs2_data
);

reg [31:0] registers [31:0];
integer i;

assign rs1_data = registers[rs1];
assign rs2_data = registers[rs2];
always @(*) begin
    if(reset) begin
        for(i=0;i<32;i = i+1) begin
            registers[i] <= 32'b0;
        end
    end 
    else begin
        if(reg_write_en && (rd != 5'b0)) begin
            registers[rd] <= write_data;
        end
    end
end

endmodule