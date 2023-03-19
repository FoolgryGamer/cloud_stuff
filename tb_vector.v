`timescale 1ns/1ps

module tb_vector;

parameter size=64

reg CLK,
reg [size-1:0] A,B
wire [size-1:0] out;

vector inst(
    .CLK(CLK),
    .A(A),
    .B(B),
    .out(out)
);

always #5 clk = ~clk;

initial begin
    clk <= 0;
    A = 32'h0000ffff;
end
endmodule