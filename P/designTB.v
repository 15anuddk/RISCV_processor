module tb();
reg clk;
reg reset;

// Instantiate the design
riscv uut(.clk(clk),
          .reset(reset));

// Clock generation - 50MHz (20ns period)
always #10 clk = ~clk;

// Dump waveforms for viewing in GTKWave or similar
initial begin
  $dumpfile("riscv_pipeline.vcd");
  $dumpvars(0, tb);
end

// Monitor key signals
initial begin
  $monitor("Time=%0t | PC=%h | Instr=%h | ALU_out=%h | MemData=%h | WriteBack_r=%h | writedata = %h", 
           $time, uut.PC, uut.instruction, uut.Alu_out, uut.read_data, uut.write_data_r, uut.rs2_data_n);
end

// Test sequence
initial begin
  clk = 0;
  reset = 1;
#20 reset = 0;
  #10000

  $finish;
  end
  
endmodule