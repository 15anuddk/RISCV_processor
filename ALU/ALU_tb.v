module ALU_tb();
//input
reg [31:0] A, B;
reg [3:0] S;
//output
wire[31:0] F;
wire zeroflag;

alu uut(.A(A), .B(B), .S(S), .F(F), .zeroflag(zeroflag));

initial begin
    $dumpfile("waveform.vcd");  // Creates the waveform file
    $dumpvars(0, ALU_tb); 
    $monitor("Time=%t, A=%d, B=%d, ALU_Sel= %b, ALU_OUT = %d, ZeroFlag = %b",
    $time, A, B, S, F, zeroflag);
  A = 32'b00010010001101000101011001111000;
  B = 32'b10011001101011011011111011110000;
  #10
  //ADD
  S = 4'b0000;
  #10
  //Sub
  S = 4'b0001;
  #10//XOR
  
  S = 4'b0010;
  #10//Sel less than
  S=4'b0011;
  
  #10//OR
  S = 4'b0110;

  #10//AND
  S = 4'b0111;
  #10
    B= 4'b0100;
  S =4'b0100;
  #10//SLL
  #10//SRL
  S = 4'b0101;
  #10
  //defalut
  S=4'b1010;

  #10;
$finish; 
end
endmodule