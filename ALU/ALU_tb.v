`timescale 1ns / 1ps
module ALU_tb;
//Inputs
reg[31:0] A, B;
reg[3:0] ALU_Sel;

//Output
wire[31:0] ALU_Out;
wire ZeroFlag;

//Instantiate the ALU
ALU uut(
    .A(A),
    .B(B),
    .ALU_Sel(ALU_Sel),
    .ALU_Out(ALU_Out),
    .ZeroFlag(ZeroFlag)
);

//Testing
initial begin
    $dumpfile("waveform.vcd");  // Creates the waveform file
    $dumpvars(0, ALU_tb); 
    $monitor("Time=%t, A=%d, B=%d, ALU_Sel= %b, ALU_OUT = %d, ZeroFlag = %b",
    $time, A, B, ALU_Sel, ALU_Out, ZeroFlag);

    // Test ADD
        A = 32'h00000005; B = 32'h00000003; ALU_Sel = 4'b0010; #10; // Expected: 8
        
        // Test SUB
        A = 32'h00000009; B = 32'h00000004; ALU_Sel = 4'b0100; #10; // Expected: 5

        // Test AND
        A = 32'h0000000F; B = 32'h000000F0; ALU_Sel = 4'b0000; #10; // Expected: 0

        // Test OR
        A = 32'h0000000F; B = 32'h000000F0; ALU_Sel = 4'b0001; #10; // Expected: 0xFF
        
        // Test XOR
        A = 32'h0000000F; B = 32'h000000F0; ALU_Sel = 4'b0111; #10; // Expected: 0xFF

        // Test Shift Left Logical (SLL)
        A = 32'h00000001; B = 32'h00000004; ALU_Sel = 4'b0011; #10; // Expected: 16

        // Test Shift Right Logical (SRL)
        A = 32'h00000010; B = 32'h00000002; ALU_Sel = 4'b0101; #10; // Expected: 4

        // Test Multiply (MUL)
        A = 32'h00000003; B = 32'h00000002; ALU_Sel = 4'b0110; #10; // Expected: 6

        // Test Zero Flag
        A = 32'h00000005; B = 32'h00000005; ALU_Sel = 4'b0100; #10; // SUB result = 0, ZeroFlag should be 1
        #100
        //End Simulation
    $finish;
end
endmodule

