module RF(
    input clk,
    input rst,
    input RegWrite,
    input [4:0] ReadReg1, ReadReg2, WriteReg, //read register address
    input [31:0] WriteData,
    output [31:0] ReadData1, ReadData2
);
// Register memory: 32 register each 32 bits
reg[31:0] registers[0:31];

//Read Operations
assign ReadData1 = (ReadReg1 != 0) ? registers[ReadReg1] : 32'b0; 
assign ReadData2 = (ReadReg2 != 0) ? registers[ReadReg2] : 32'b0;
integer i;
//Write Operation Synchronus with clk
always @(posedge clk or posedge rst) begin
    if(rst) begin
      //Reset all registers to 0
      for(i=0;i<32;i=i+1) begin
        registers[i] <= 32'b0;
      end
    end
    else if (RegWrite && WriteReg !=0) begin
      registers[WriteReg] <= WriteData; // Write only if RegWrite is high and not x0
    end
end
endmodule
    