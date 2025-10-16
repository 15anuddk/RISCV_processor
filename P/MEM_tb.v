module MEM_tb();

    reg clk;
    reg reset;
    reg mem_to_reg_n2;
    reg mem_read_n2;
    reg mem_write_n2;
    reg [31:0] address;
    reg [31:0] writedata;
    

wire [31:0] read_data;

memory mem(
    .clk(clk),
    .reset(reset),
    .address(address),
    .mem_write_en(mem_write_n2),
    .mem_read_en(mem_read_n2),
    .write_data(writedata),
    .read_data(read_data));

wire mem_to_reg_n3;
wire [31:0] read_data_n, alu_result_n;
MEM_WB uut(
    .clk(clk),
    .reset(reset),
    .mem_to_reg_n2(mem_to_reg_n2),
    .read_data(read_data),
    .alu_result(address),
    .mem_to_reg_n3(mem_to_reg_n3),
    .read_data_n(read_data_n),
    .alu_result_n(alu_result_n));

always #10 clk = ~clk;

initial begin
  $dumpfile("MEM_tb_test.vcd");
  $dumpvars(0, MEM_tb);
end

initial begin
  clk = 0;
  reset = 1;
  #20
  mem_write_n2 = 1'b1;
  address = 32'h12;
  writedata = 32'h55;
  reset = 0;

  

  #20 
  $strobe("mem_to_reg_n3 = %b , read_data_n = %h, alu_result_n = %h", mem_to_reg_n3, read_data_n,alu_result_n);
  reset = 1;
  #10 reset = 0;
  mem_read_n2 = 1'b1;
  address = 32'h12;
  #20
  $strobe("mem_to_reg_n3 = %b , read_data_n = %h, alu_result_n = %h", mem_to_reg_n3, read_data_n,alu_result_n);
  #20 $finish;
end

endmodule