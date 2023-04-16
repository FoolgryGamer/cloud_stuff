`timescale 1ns/1ps

module tb_vector;

parameter size=256;

reg clk;
reg [size-1:0] data;
reg en_read;
reg [1:0] mod;
reg rst;
reg [5:0] addr;
wire [size-1:0] out_number;
reg [5:0] host_read_addr;

vector_U inst(
    .clk(clk),
    .data_in(data),
    .en_read(en_read),
    .rst(rst),
    .host_write_addr(addr),
    .host_read_addr(host_read_addr),
    .mod(mod),
    .out_number(out_number)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1'b0;
    # 20 rst = 1'b1;
    data = 256'h0000ffff;
    host_read_addr = 6'b000000;
    addr = 6'h1;
    # 30
    data = 256'h0abcffff;
    addr = 6'h2;
    # 30
    data = 256'h0ffff0000;
    addr = 6'h3;
    # 30
    data = 256'h12345678;
    addr = 6'h4;
    mod = 0;

    #30 en_read = 1'b1;
    #10 en_read = 1'b0;
    #100 mod = 0;
    // #100 mod = 2;
    // #100 mod = 3;
    // #100 mod = 0;
    #30 en_read = 1'b1;
    #10 en_read = 1'b0;
    #100 host_read_addr = 6'b100010;
    #100 host_read_addr = 6'b100100;
    #1000 $finish;
end
endmodule