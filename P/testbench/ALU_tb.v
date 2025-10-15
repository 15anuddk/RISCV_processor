module ALU_tb();

//input 
 reg [3:0] sel;
 reg [31:0] A,B;

 wire [31:0] out;
 wire zeroflag;

 ALU uut(.sel(sel),
        .A(A),
        .B(B),
        .out(out),
        .zeroflag(zeroflag));

initial begin
  $dumpfile("alu_test.vcd");
  $dumpvars();
end

initial begin
  $monitor("A = %h , B = %h , sel = %b , out = %h, zeroflag = %b", A,B,sel,out, zeroflag);
end

initial begin
  A = 32'h0FFF1256;
  B = 32'h0011FF23;
  sel = 4'b0000;
  #10 sel = 4'b0001;
  #10 sel = 4'b0010;
  #10 sel = 4'b0011;
  #10 sel = 4'b0100;

  #5 B = 32'h5;
  #10 sel = 4'b0101;
  #10 sel = 4'b0110;
  #10 sel = 4'b0111;
  #10 sel = 4'b1000;
  #10 sel = 4'b1001;

  #5 B = 32'b0;
  #10 sel = 4'b0100;
end

endmodule