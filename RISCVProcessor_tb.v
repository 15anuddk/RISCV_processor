module RISCVProcessor_tb;

    // Testbench Signals
    reg clk, rst;

    // Instantiate the Processor
    RISCVProcessor uut (  
        .clk(clk),
        .rst(rst)
    );

    // Clock Generation (10ns clock period, 50% duty cycle)
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        #10 rst = 0; // Deassert reset after some time

        // Monitor important signals
        $monitor("Time=%0t | PC=%h | Instr=%h | ALU_result=%h", 
              $time, uut.pc_module.PC, uut.instruction_memory.Instr, uut.ex_stage.ALU_result);

        // Dump waveform data for GTKWave
        $dumpfile("processor.vcd");
        $dumpvars(0, RISCVProcessor_tb);

        // Run simulation for some cycles
        #500;  // Run for more time before stopping
        $finish;
    end

endmodule
