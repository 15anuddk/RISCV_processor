module alu_ctrl(
    input [2:0] func3,
    input [6:0] func7,
    input [1:0] alu_op,
    output reg[3:0] alu_sel
);

always @(*) begin
    if(alu_op == 2'b10) begin
        case(func3)
            3'b000: begin
                if(func7 == 7'b000) sel = 4'b0000;
                else sel = 4'b0001;
            end
            
            3'b001: begin
                sel = 4'b0101;
            end

            3'b010: begin
                sel = 4'b1000;
            end

            3'b011: begin
                sel = 4'b1001;
            end

            3'b100: begin
                sel = 4'b0010;
            end

            3'b101: begin
                if(func7 == 7'b0) sel = 4'b0110;
                else sel = 4'b0111;
            end
            3'b110: begin
                sel = 4'b0011;
            end

            3'b111: begin
                sel = 4'b0100;
            end
            default: sel = 4'b0000;
        endcase
    end
    else if(alu_op == 2'b01) begin
        sel = 4'b0000;
    end
endmodule