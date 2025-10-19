module memory(
    input clk,
    input reset,
    input [31:0] address,
    input mem_write_en,
    input mem_read_en,
    input [31:0] write_data,
    output reg [31:0] read_data
);

reg [31:0] data_mem [0:255];

always @(*) begin
    $display("MEM ");
    if(reset) read_data <= 32'b0;
    //memory read
    if(mem_read_en && (address >> 2) < 256) begin
        read_data <= data_mem[address >> 2];
    end
    //memory write
    if(mem_write_en && (address >> 2) < 256) begin
        data_mem[address >> 2] <= write_data;
    end
end

endmodule
