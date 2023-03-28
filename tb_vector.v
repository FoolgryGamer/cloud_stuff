`timescale 1ns/1ps

module tb_vector;

parameter size=32;

reg clk;
reg [size-1:0] A;
reg [size-1:0] B;
wire [size-1:0] out;
reg [1:0] mod;
vector inst(
    .clk(clk),
    .A(A),
    .B(B),
    .mod(mod),
    .out(out)
);

always #5 clk = ~clk;

initial begin
    clk <= 0;
    A = 32'h0000ffff;
    B = 32'h0abcffff;
    mod = 0;
    #100 mod = 1;
    #100 mod = 2;
    #100 mod = 3;
    #1000 $finish;
end
endmodule