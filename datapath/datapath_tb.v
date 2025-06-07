module datapath_tb();

reg clk;
reg reset;

wire [31:0] PC_next, PC, instruction;

datapath uut(
    .clk(clk),
    .reset(reset),
    .PC_next(PC_next),
    .PC(PC),
    .instruction(instruction)
);

always #5 clk = ~clk; //10ns period

initial begin
  $dumpfile("wave.vcd");
  $dumpvars(0, datapath_tb);
  $monitor("Time = %0t | PC = %h | Instruction = %h | Next PC = %h",
                  $time, PC, instruction, PC_next);
    clk = 0;
    reset = 1;
    #10
    reset = 0;


    #500
    $finish;          
end
endmodule


