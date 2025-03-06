`timescale 1ns / 1ps

module RF_tb;
//Inputs
reg clk, rst, RegWrite;
reg [4:0] ReadReg1, ReadReg2, WriteReg;
reg[31:0] WriteData;

//Output
wire [31:0] ReadData1, ReadData2;

// Instantiate the Register File
    RF uut (
        .clk(clk),
        .rst(rst),
        .RegWrite(RegWrite),
        .ReadReg1(ReadReg1),
        .ReadReg2(ReadReg2),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    //Clock generation
    always #5 clk = ~clk;  // 10ns clock cycle
    initial begin
      clk = 0;
      rst = 1;
      RegWrite = 0;
      ReadReg1 = 0;
      ReadReg2 = 0;
      WriteReg = 0;
      WriteData =0;

      //Reset 
      #10 rst = 0;

      // Test writing and reading registers
        #10 RegWrite = 1; WriteReg = 5; WriteData = 32'hAABBCCDD;  // Write to x5
        #10 RegWrite = 1; WriteReg = 10; WriteData = 32'h12345678;  // Write to x10

        // Read from registers
        #10 RegWrite = 0; ReadReg1 = 5; ReadReg2 = 10;
        #10 $display("ReadReg1 = %h, ReadReg2 = %h", ReadData1, ReadData2);

        // Read x0 (should always be 0)
        #10 ReadReg1 = 0;
        #10 $display("Read x0: %h (should be 0)", ReadData1);

        // End simulation
        #20 $finish;
    end
endmodule