module CV(
    input [6:0] opcode, //7 bits opcode risc32
    input func3 [3:0],
    input alu_sel [3:0],
    output reg reg_write, 
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg mem_to_reg,
    output reg alu_src
);

always @(*) begin
  // Default values
    reg_write = 0;
    alu_src = 0;
    mem_read = 0;
    mem_write = 0;
    branch =0;
    mem_to_reg =0;
    alu_sel = 4'b0000; //default ADD

    case (opcode)
        7'b0110011: begin // R-type
            reg_write = 1;
            case(func3)
                3'b000 : begin // ADD and SUB
                    if(func7 == 7'b0000000) alu_sel = 4'b0000;
                    else if(func7 == 7'b0100000) alu_sel = 4'b0001;
                end
                
                3'b001: alu_sel = 4'b0010;
                3'b010: alu_sel = 4'b0011;
                3'b011: alu_sel = 4'b1000;
                3'b100: alu_sel = 4'b0100;
                3'b101: alu_sel = 4'b0101;
                3'b110: alu_sel = 4'b0110;
                3'b111: alu_sel = 4'b0111;
            endcase
        end
        
        7'b0010011: begin // I-type (e.g., ADDI)
            reg_write = 1;
            alu_src = 1;
            case(func3)
                3'b000 : begin // ADD and SUB
                    if(func7 == 7'b0000000) alu_sel = 4'b0000;
                    else if(func7 == 7'b0100000) alu_sel = 4'b0001;
                end
                
                3'b001: alu_sel = 4'b0010;
                3'b010: alu_sel = 4'b0011;
                3'b011: alu_sel = 4'b1000;
                3'b100: alu_sel = 4'b0100;
                3'b101: alu_sel = 4'b0101;
                3'b110: alu_sel = 4'b0110;
                3'b111: alu_sel = 4'b0111;
            endcase
        end

         7'b0000011: begin // Load (e.g., LW)
            reg_write = 1;
            mem_read = 1;
            alu_control = 4'b0000; // ADD for address calculation
            mem_to_reg = 1; // Data comes from memory
        end
        7'b0100011: begin // Store (e.g., SW)
            mem_write = 1;
            alu_control = 4'b0000; // ADD for address calculation
        end
        7'b1100011: begin // Branch (e.g., BEQ)
            branch = 1;
            alu_control = 4'b0001; // SUB for comparison
        end           
    endcase
end

endmodule




