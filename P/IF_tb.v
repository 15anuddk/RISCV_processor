// `include "PC.v"
// `include "adder.v"
// `include "instruction_mem.v"
// `include "IF_ID.v"

module IF_tb();

reg clk;
reg reset;

wire [31:0] PC_in;
wire [31:0] PC_new;
PC program_counter(.clk(clk),
                    .reset(reset),
                    .PC_next(PC_new),
                    .PC(PC_in));


adder PC_add(.PC(PC_in),
            .PC_new(PC_new));


wire [31:0] instruction;
instruction_mem i_m(.address(PC_in),
                    .instruction(instruction));

wire[31:0]instr, PC_n;

IF_ID uut(.clk(clk),
          .reset(reset),
          .PC_new(PC_new),
          .instruction(instruction),
          .instr(instr),
          .PC_n(PC_n));

always #10 clk = ~clk;

// initial begin
//   $dumpfile("IF_test.vcd");
//   $dumpvars(0,IF_tb);
//   $monitor("PC_in = %b  instruction = %b , PC_n = %b", PC_in , instr , PC_n);
// end

always @(posedge clk) begin
    $display("time=%0t | PC_in=%h | instruction=%h | PC_n=%h | instr=%h",
             $time, PC_in, instruction, PC_n, instr);
end

initial begin
  clk = 0;
  reset = 1;

  #20
  reset = 0;
  #500
  $finish;
end

endmodule