module vector#
(parameter size=64)
(
    input CLK,
    input [size-1:0] A,B
    output [size-1:0] out;
)

reg [size-1:0] out;
always@(posedge CLK) begin
    out <= A + B
end

endmodule