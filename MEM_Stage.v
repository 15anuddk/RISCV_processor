module MEM_Stage(
    input clk,
    input MemRead, MemWrite, // Control Signals
    input [31:0] ALU_result, // Computed address
    input [31:0] WriteData, // Data to write to memory
    output reg [31:0] MemData // Data read from memory
);

// Memory (For Simulation)
reg [31:0] DataMemory [0:255]; 

always @(posedge clk) begin
    if (MemWrite) begin
        DataMemory[ALU_result] <= WriteData; // Store data
    end
end

always @(*) begin
    if (MemRead) begin
        MemData = DataMemory[ALU_result]; // Load data
    end
    else begin
        MemData = 0;
    end
end

endmodule
