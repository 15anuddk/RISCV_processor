module PC_IM_tb;
    reg clk,rst;
    reg [31:0] PC_next;
    wire [31:0] PC;
    wire [31:0] Instr;

    PC pc_inst(
        .clk(clk),
        .rst(rst),
        .PC_next(PC_next),
        .PC(PC)
    );

    IM im_inst(
        .PC(PC),
        .Instr(Instr)
    );

    always #5 clk = ~clk;

    initial begin
      $dumpfile("waveform.vcd");
      $dumpvars(0,PC_IM_tb);

      clk=0;
      rst = 1; #10;
      rst = 0; #10;

      PC_next = 4; #10;
      PC_next = 8; #10;
      PC_next = 12; #10;
      PC_next = 16; #10;

      $finish;
    end
endmodule