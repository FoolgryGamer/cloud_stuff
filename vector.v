module vector
#(parameter size=32)
(
    input clk,
    input [size-1:0] A,
    input [size-1:0] B,
    output reg [size-1:0] out
);

always@(posedge clk) begin
    out <= A + B;
end

endmodule