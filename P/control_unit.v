module control_unit(
    input reset,
    input [6:0]opcode,
    output reg [1:0] alu_op,
    output reg reg_write_en
    output reg alu_src;
    output reg mem_to_reg_en;
    output reg mem_read_en,
    output reg mem_write_en,
);

always @(*) begin
    if(reset) begin
        sel = 4'b0000;
        reg_write_en = 1'b0;
        alu_src = 1'b0;
        mem_read_en = 1'b0;
        mem_write_en = 1'b0;
        mem_to_reg_en = 1'b0;
        alu_op =2'b00;
    end
    case(opcode)
        7'b0110011: begin //Rtype instructions
            reg_write_en = 1'b1;
            alu_src = 1'b0;
            mem_read_en = 1'b0;
            mem_write_en = 1'b0;
            mem_to_reg_en = 1'b0
            alu_op = 2'b10;
        end 
        7'b0010011: begin //I type instructions
            reg_write_en = 1'b1;
            alu_src = 1'b1;
            mem_read_en = 1'b0;
            mem_write_en = 1'b0;
            mem_to_reg_en = 1'b0
            alu_op = 2'b10;
        end
        7'b0000011: begin
            mem_to_reg_en = 1'b1;
            mem_read_en = 1'b1;
            reg_write_en = 1'b1;
            alu_src = 1'b1;
            alu_op =2'b00;
        end
        7'b0100011: begin
            alu_op = 2'b00;
            mem_write_en = 1'b1;
            alu_src = 1'b1;
        end

    endcase
end
