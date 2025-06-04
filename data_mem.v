module data_mem(
    input clk,
    input [0:31]address, //read address
    input mem_read, //memory read enable
    input mem_write, //memory write enable
    input [0:31] write_data, //data to write in memory
    output [0:31]read_data //data read from memory
);

reg [0:31]DataMem[0:255]; //contains 256 words of 32 bits;

always @(posedge clk) begin
    read_data = 32'b0;
  if(address[7:0] < 256) begin
    if(mem_read) begin
      read_data = DataMem[address[9:0]]; // read data from the address
    end

    if (mem_write) begin
      DataMem[address[9:0]] = write_data;
    end
  end
end

endmodule


