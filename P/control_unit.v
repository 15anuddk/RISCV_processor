module control_unit(
    input reset,
    input [6:0]opcode,
    output reg alu_op,
    output reg reg_write_en,
    output reg alu_src,
    output reg mem_to_reg_en,
    output reg mem_read_en,
    output reg mem_write_en,
    output reg jumpl_en,
    output reg branch_en
);

always @(*) begin
    if(reset) begin
        reg_write_en = 1'b0;
        alu_src = 1'b0;
        mem_read_en = 1'b0;
        mem_write_en = 1'b0;
        mem_to_reg_en = 1'b0;
        alu_op =1'b0;
        jumpl_en = 1'b0;
        branch_en = 1'b0;
    end
    case(opcode)
        7'b0110011: begin //Rtype instructions
            reg_write_en = 1'b1;
            alu_src = 1'b0;
            mem_read_en = 1'b0;
            mem_write_en = 1'b0;
            mem_to_reg_en = 1'b0;
            alu_op = 1'b1;
            jumpl_en = 1'b0;
        end 
        7'b0010011: begin //I type instructions
            reg_write_en = 1'b1;
            alu_src = 1'b1;
            mem_read_en = 1'b0;
            mem_write_en = 1'b0;
            mem_to_reg_en = 1'b0;
            alu_op = 1'b1;
            jumpl_en = 1'b0;
        end
        7'b0000011: begin //load
            mem_to_reg_en = 1'b1;
            mem_read_en = 1'b1;
            mem_write_en = 1'b0;
            reg_write_en = 1'b1;
            alu_src = 1'b1;
            alu_op =1'b0;
            jumpl_en = 1'b0;
        end
        7'b0100011: begin //store
            alu_op = 1'b0;
            mem_write_en = 1'b1;
            alu_src = 1'b1;
            jumpl_en = 1'b0;
            mem_to_reg_en = 1'b1;
            mem_read_en = 1'b1;
            reg_write_en = 1'b1;
        end
        7'b1101111: begin //jump
            jumpl_en = 1'b1;
            mem_to_reg_en = 1'b0;
            mem_read_en = 1'b0;
            mem_write_en = 1'b0;
            reg_write_en = 1'b1;
            alu_src = 1'b0;
            alu_op =1'b0;
        end
        7'b1100011: begin //branch
            branch_en = 1'b1;
            alu_op = 1'b0;
            mem_to_reg_en = 1'b0;
            mem_read_en = 1'b0;
            mem_write_en = 1'b0;
            reg_write_en = 1'b0;
            alu_src = 1'b0;
            jumpl_en = 1'b0;
        end
    endcase
end

endmodule
