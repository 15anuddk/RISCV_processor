module data_mem(
    input clk,
    input [31:0]address, //read address
    input mem_read, //memory read enable
    input mem_write, //memory write enable
    input [31:0] write_data, //data to write in memory
    output reg [31:0]read_data //data read from memory
);

reg [0:31]DataMem[0:255]; //contains 256 words of 32 bits;

always @(posedge clk) begin
    read_data = 32'b0;
  if(address[7:0] < 256) begin
    if(mem_read) begin
      read_data = DataMem[address[7:0]]; // read data from the address
      $display("Time=%t: Memory Read at address %h data=%h", $time, address, read_data);
    end

    if (mem_write) begin
      DataMem[address[7:0]] = write_data;
      $display("Time=%t: Memory Write at address %h with data %h", $time, address, write_data);
    end
  end
end

endmodule


